#!/bin/bash
# =============================================================================
# Quick Onyxia Environment Test
# =============================================================================
# Run this in a fresh Onyxia session for a quick verification
# Usage: bash test-onyxia-quick.sh
# =============================================================================

echo "========================================"
echo "    QUICK ONYXIA ENVIRONMENT TEST"
echo "========================================"
echo ""

PASS=0
FAIL=0

test_check() {
    if [ $? -eq 0 ]; then
        echo "✓ $1"
        ((PASS++))
    else
        echo "✗ $1"
        ((FAIL++))
    fi
}

# Test 1: renv disabled
echo ""
echo "--- Testing renv disabled ---"
Rscript -e 'if(any(grepl("renv", .libPaths()))) quit(status=1)' 2>/dev/null
test_check "renv is disabled"

# Test 2: sitsdata installed
echo ""
echo "--- Testing sitsdata package ---"
Rscript -e 'library(sitsdata)' 2>/dev/null
test_check "sitsdata package installed"

# Test 3: torch installed
echo ""
echo "--- Testing torch package ---"
Rscript -e 'library(torch); if(!torch_is_installed()) quit(status=1)' 2>/dev/null
test_check "torch package and backend installed"

# Test 4: AWS credentials (IRSA)
echo ""
echo "--- Testing AWS/IRSA ---"
if [ -n "$AWS_WEB_IDENTITY_TOKEN_FILE" ] && [ -n "$AWS_ROLE_ARN" ]; then
    echo "  IRSA configured: $AWS_ROLE_ARN"
    test_check "AWS IRSA credentials"
elif [ -n "$AWS_ACCESS_KEY_ID" ]; then
    echo "  Static credentials found"
    test_check "AWS static credentials"
else
    echo "  No AWS credentials found"
    ((FAIL++))
    echo "✗ AWS credentials"
fi

# Test 5: Python numpy version
echo ""
echo "--- Testing Python numpy version ---"
NUMPY_VER=$(python3 -c "import numpy; print(numpy.__version__)" 2>/dev/null)
if [ $? -eq 0 ]; then
    MAJOR_VER=$(echo $NUMPY_VER | cut -d. -f1)
    if [ "$MAJOR_VER" -lt 2 ]; then
        echo "  numpy version: $NUMPY_VER (< 2.0) ✓"
        ((PASS++))
    else
        echo "  numpy version: $NUMPY_VER (>= 2.0 - may cause issues)"
        ((FAIL++))
    fi
else
    echo "  numpy not found"
    ((FAIL++))
fi

# Test 6: Python packages for parcel extraction
echo ""
echo "--- Testing Python packages ---"
for pkg in rasterio torch scikit-learn; do
    python3 -c "import ${pkg//-/_}" 2>/dev/null
    if [ $? -eq 0 ]; then
        echo "  $pkg: installed"
    else
        echo "  $pkg: NOT INSTALLED"
    fi
done

# Test 7: System dependencies
echo ""
echo "--- Testing system dependencies ---"
echo "  GDAL: $(gdal-config --version 2>/dev/null || echo 'not found')"
echo "  PROJ: $(proj 2>&1 | head -1)"
dpkg -l | grep -q libmagick++
test_check "libmagick++ installed"

# Test 8: Key R packages
echo ""
echo "--- Testing key R packages ---"
Rscript -e '
pkgs <- c("sits", "terra", "sf", "kohonen", "randomForest", "earthdatalogin", "magick")
missing <- pkgs[!sapply(pkgs, requireNamespace, quietly=TRUE)]
if(length(missing) > 0) {
  cat("Missing:", paste(missing, collapse=", "), "\n")
  quit(status=1)
}
' 2>/dev/null
test_check "Key R packages installed"

# Summary
echo ""
echo "========================================"
echo "            SUMMARY"
echo "========================================"
echo "Passed: $PASS"
echo "Failed: $FAIL"
echo ""

if [ $FAIL -eq 0 ]; then
    echo "🎉 All tests passed!"
    exit 0
else
    echo "⚠️  Some tests failed - review output above"
    exit 1
fi
