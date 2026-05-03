#!/usr/bin/env Rscript
# =============================================================================
# Onyxia Environment Test Script
# =============================================================================
# Run this script in a fresh Onyxia session to verify environment fixes.
# Usage: Rscript test-onyxia-environment.R
# =============================================================================

cat("
================================================================================
                    ONYXIA ENVIRONMENT TEST SUITE
================================================================================
")

results <- list()
test_num <- 0

# Helper function to run a test
run_test <- function(name, test_fn) {
  test_num <<- test_num + 1
  cat(sprintf("\n[TEST %d] %s\n", test_num, name))
  cat(paste(rep("-", 60), collapse = ""), "\n")

  result <- tryCatch({
    test_fn()
    cat("✓ PASSED\n")
    TRUE
  }, error = function(e) {
    cat(sprintf("✗ FAILED: %s\n", e$message))
    FALSE
  })

  results[[name]] <<- result
  invisible(result)
}

# =============================================================================
# TEST 1: renv is disabled (Issue #1 - should be fixed)
# =============================================================================
run_test("renv is disabled", function() {
  # Check that renv is not active
  lib_paths <- .libPaths()
  if (any(grepl("renv", lib_paths))) {
    stop("renv library path detected - renv is still active!")
  }

  # Check environment variable
  if (Sys.getenv("RENV_CONFIG_AUTOLOADER_ENABLED") != "FALSE") {
    cat("  Warning: RENV_CONFIG_AUTOLOADER_ENABLED not set to FALSE\n")
  }

  cat("  Library paths: ", paste(lib_paths, collapse = ", "), "\n")
})

# =============================================================================
# TEST 2: sitsdata package installed (Issue #2 - should be fixed)
# =============================================================================
run_test("sitsdata package installed", function() {
  if (!requireNamespace("sitsdata", quietly = TRUE)) {
    stop("sitsdata package not installed")
  }
  cat("  Version: ", as.character(packageVersion("sitsdata")), "\n")
})

# =============================================================================
# TEST 3: torch installed and working (Issue #3 - should be fixed)
# =============================================================================
run_test("torch installed and functional", function() {
  if (!requireNamespace("torch", quietly = TRUE)) {
    stop("torch package not installed")
  }
  cat("  Package version: ", as.character(packageVersion("torch")), "\n")

  # Check if torch backend is installed
  if (!torch::torch_is_installed()) {
    stop("torch backend not installed - run torch::install_torch()")
  }
  cat("  Backend: installed\n")
  cat("  CUDA available: ", torch::cuda_is_available(), "\n")
})

# =============================================================================
# TEST 4: Core sits functionality works (validates parallel workers)
# =============================================================================
run_test("sits package with parallel workers", function() {
  library(sits)
  library(sitsdata)

  # Test that sits can use multiple cores (this was failing with renv issue)
  # Use a simple operation that spawns workers
  samples <- sitsdata::samples_matogrosso_mod13q1
  cat("  Loaded sample data: ", nrow(samples), " samples\n")

  # Test parallel operation (if this works, renv fix is confirmed)
  cat("  Testing parallel capability...\n")
  result <- sits_cluster_frequency(samples)
  cat("  Parallel test: OK\n")
})

# =============================================================================
# TEST 5: AWS credentials via IRSA (Issue #5 - needs verification)
# =============================================================================
run_test("AWS credentials (IRSA)", function() {
  # Check for AWS credentials
  access_key <- Sys.getenv("AWS_ACCESS_KEY_ID")
  secret_key <- Sys.getenv("AWS_SECRET_ACCESS_KEY")

  if (access_key == "" && secret_key == "") {
    # Check if running with IRSA (web identity token)
    web_identity <- Sys.getenv("AWS_WEB_IDENTITY_TOKEN_FILE")
    role_arn <- Sys.getenv("AWS_ROLE_ARN")

    if (web_identity != "" && role_arn != "") {
      cat("  IRSA configured:\n")
      cat("    Role ARN: ", role_arn, "\n")
      cat("    Token file: ", web_identity, "\n")
    } else {
      stop("No AWS credentials found (neither static keys nor IRSA)")
    }
  } else {
    cat("  Static AWS credentials found\n")
    cat("  Note: For IRSA, static keys should NOT be set\n")
  }

  # Test S3 access (optional - requires network)
  cat("  Testing STAC access to MPC (no auth required)...\n")
  library(rstac)
  stac_obj <- stac("https://planetarycomputer.microsoft.com/api/stac/v1")
  result <- get_request(stac_obj)
  cat("  MPC STAC: accessible\n")
})

# =============================================================================
# TEST 6: Python environment (Issues #8, #9)
# =============================================================================
run_test("Python environment for chapters", function() {
  library(reticulate)

  # Check Python is available
  py_config <- py_config()
  cat("  Python: ", py_config$python, "\n")
  cat("  Version: ", py_config$version, "\n")

  # Check numpy version (Issue #9 - should be < 2)
  numpy <- tryCatch({
    import("numpy")
  }, error = function(e) {
    stop("numpy not installed")
  })

  numpy_version <- numpy$`__version__`
  cat("  numpy version: ", numpy_version, "\n")

  # Parse version to check if < 2
  major_version <- as.integer(strsplit(numpy_version, "\\.")[[1]][1])
  if (major_version >= 2) {
    stop(sprintf("numpy version %s >= 2.0 - some chapters require numpy < 2", numpy_version))
  }

  # Check other key packages for th_parcel_extraction (Issue #8)
  packages_to_check <- c("rasterio", "scikit-learn", "torch")
  for (pkg in packages_to_check) {
    result <- tryCatch({
      mod <- import(pkg, convert = FALSE)
      ver <- tryCatch(mod$`__version__`, error = function(e) "unknown")
      cat(sprintf("  %s: %s\n", pkg, ver))
      TRUE
    }, error = function(e) {
      cat(sprintf("  %s: NOT INSTALLED\n", pkg))
      FALSE
    })
  }
})

# =============================================================================
# TEST 7: System dependencies
# =============================================================================
run_test("System dependencies (GDAL, PROJ, GEOS)", function() {
  # GDAL
  gdal_version <- system("gdal-config --version", intern = TRUE)
  cat("  GDAL: ", gdal_version, "\n")

  # PROJ
  proj_output <- system("proj 2>&1 | head -1", intern = TRUE)
  cat("  PROJ: ", proj_output, "\n")

  # GEOS
  geos_version <- system("geos-config --version 2>/dev/null || echo 'not found'", intern = TRUE)
  cat("  GEOS: ", geos_version, "\n")

  # Check libmagick++ (Issue #10)
  magick_check <- system("dpkg -l | grep libmagick++ | head -1", intern = TRUE)
  if (length(magick_check) > 0 && magick_check != "") {
    cat("  libmagick++: installed\n")
  } else {
    cat("  libmagick++: NOT FOUND (may cause issues with magick package)\n")
  }
})

# =============================================================================
# TEST 8: Key R packages for chapters
# =============================================================================
run_test("Key R packages installed", function() {
  packages <- c(
    "sits", "sitsdata", "terra", "sf", "rstac",
    "kohonen", "randomForest", "torch", "earthdatalogin",
    "gdalcubes", "tidyverse", "tmap", "magick"
  )

  missing <- c()
  for (pkg in packages) {
    if (requireNamespace(pkg, quietly = TRUE)) {
      ver <- as.character(packageVersion(pkg))
      cat(sprintf("  %s: %s\n", pkg, ver))
    } else {
      cat(sprintf("  %s: MISSING\n", pkg))
      missing <- c(missing, pkg)
    }
  }

  if (length(missing) > 0) {
    stop(sprintf("Missing packages: %s", paste(missing, collapse = ", ")))
  }
})

# =============================================================================
# SUMMARY
# =============================================================================
cat("\n")
cat("================================================================================\n")
cat("                              TEST SUMMARY\n")
cat("================================================================================\n")

passed <- sum(unlist(results))
total <- length(results)

for (name in names(results)) {
  status <- if (results[[name]]) "✓ PASSED" else "✗ FAILED"
  cat(sprintf("  %s: %s\n", status, name))
}

cat("\n")
cat(sprintf("Results: %d/%d tests passed\n", passed, total))

if (passed == total) {
  cat("\n🎉 All tests passed! Environment is ready.\n")
} else {
  cat("\n⚠️  Some tests failed. Review the output above for details.\n")
}

cat("================================================================================\n")
