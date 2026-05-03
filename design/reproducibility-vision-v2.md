# Reproducibility Vision 2.0: From Infrastructure to Scholarly Publishing Platform

**Document Status**: Proposal (Draft v1.0)
**Date**: 2025-01-24
**Authors**: UN Handbook Technical Team
**Purpose**: Strategic vision for upgrading the reproducibility system to integrate citation infrastructure, data catalogs, and scholarly publishing workflows

---

## Executive Summary

### The Evolution: From Technical Infrastructure to Research Publishing

The current reproducibility design (v1.0) successfully addresses the **technical challenge** of making handbook chapters executable through containerization, automated CI/CD, and one-click JupyterLab sessions. This proposal (v2.0) extends that foundation to address the **scholarly challenge**: transforming chapters into **citable, discoverable, and reusable research outputs** that integrate with the broader open science ecosystem.

### Current State vs. Vision

**Current System (v1.0 Design)**:
- ✅ Containerized environments with versioned dependencies
- ✅ Automated data packaging via Dagger CI/CD
- ✅ One-click "Reproduce" button for readers
- ✅ Hybrid local/cloud data access with IRSA
- ❌ No DOI minting or citation infrastructure
- ❌ No data catalog integration for discovery
- ❌ Limited author guidance on scholarly publishing
- ❌ Missing data provenance and governance frameworks

**Enhanced Vision (v2.0)**:
- ✅ **Research Compendium Model**: Each chapter is a self-contained, citable unit
- ✅ **DOI Infrastructure**: Automatic DOI minting via Zenodo for versioned releases
- ✅ **Data Catalog Integration**: Chapter datasets registered in FAO/UN data catalogs
- ✅ **Citation Metadata**: Structured frontmatter with authors, ORCID, licenses, provenance
- ✅ **Scholarly Recognition**: Authors receive credit for computational contributions
- ✅ **Enhanced Discovery**: Integration with DataCite, ORCID, Zenodo search
- ✅ **Governance Framework**: Templates for data ethics, licensing, sensitivity assessment

### The Research Compendium Paradigm

This vision adopts the **research compendium** model—a structured package containing all materials needed to reproduce and extend research findings. Each handbook chapter with executable code becomes a compendium including:

**Essential Components**:
1. **Code** - Literate programming via `.qmd` files (analysis + narrative)
2. **Data** - Content-hashed OCI artifacts (local) + STAC queries (cloud)
3. **Environment** - Versioned Docker images with `renv.lock` dependencies
4. **Documentation** - Chapter text, metadata, design decisions, limitations
5. **License** - Clear usage rights for code, data, and derived works
6. **Citation Metadata** - Authors, ORCID, DOI, version, date
7. **Provenance** - Data sources, processing steps, model training procedures

**Benefits by Stakeholder**:

| Stakeholder | Value Proposition |
|-------------|-------------------|
| **Researchers** | Cite specific computational methods, extend to new regions/crops, validate findings |
| **Reviewers** | Verify exact code/data used, test alternative approaches, assess reproducibility |
| **Learners** | Run analyses without local setup, experiment with parameters, hands-on learning |
| **Educators** | Assign chapters as interactive coursework, assess student modifications |
| **Policy Makers** | Verify methodology transparency, assess confidence in statistical claims |
| **Production Teams** | Transition prototypes to operational systems with known dependencies |
| **Chapter Authors** | Receive DOI-based citations, demonstrate impact, scholarly recognition |

---

## Part 1: Strategic Context and Alignment

### 1.1 Alignment with Open Science Frameworks

This vision integrates principles from established reproducibility frameworks:

#### The Turing Way
- **Reproducible Environments**: Docker images + `renv.lock` implement computational environment capture
- **Version Control**: Git-native workflow for code and data artifacts
- **Citation**: DOI minting for research outputs
- **Collaboration**: Public repositories, clear contribution guidelines
- **Documentation**: Literate programming with Quarto

**Enhancement**: Add explicit Turing Way chapter references in handbook documentation.

#### Reproducible Analytical Pipelines (RAP)
- **Automation**: Dagger CI/CD eliminates manual build steps
- **Open Source**: All code, infrastructure-as-code, data publicly available
- **Quality Assurance**: Immutable, content-hashed artifacts
- **Documentation**: Self-documenting via literate programming
- **Auditability**: Git history provides full provenance trail

**Enhancement**: Position handbook as exemplar RAP implementation for geospatial domain.

#### FAIR Principles (Findability, Accessibility, Interoperability, Reusability)

**Findability**:
- ✅ DOI persistence via Zenodo
- ✅ OCI artifact registries (GHCR) with semantic versioning
- ✅ STAC catalog metadata for geospatial data
- 🆕 **Data catalog registration** for FAO/UN discovery systems
- 🆕 **DataCite metadata** for cross-repository search

**Accessibility**:
- ✅ One-click launch button (no authentication barriers for public data)
- ✅ Standard protocols (HTTPS, OCI, STAC)
- 🆕 **Zenodo archival** for long-term preservation
- 🆕 **Multiple access paths**: handbook, GitHub, Zenodo, data catalogs

**Interoperability**:
- ✅ Standard formats: OCI containers, Helm charts, STAC metadata
- ✅ Portable CI/CD via Dagger (runs on any platform)
- ✅ Cloud-native data access via STAC protocol
- 🆕 **Schema.org metadata** in chapter HTML
- 🆕 **CrossRef/DataCite** integration for citation networks

**Reusability**:
- ✅ Permissive licenses (MIT/CC-BY for code, clear data licenses)
- ✅ Comprehensive documentation (design docs, author guides)
- ✅ Modular design (chapters independent, reusable patterns)
- 🆕 **Structured provenance** in metadata
- 🆕 **Usage guidance** for different stakeholder types

### 1.2 Research Compendium Framework

The research compendium model provides the conceptual foundation for this vision. Each reproducible chapter is structured as:

```
UN-Handbook Chapter (Research Compendium)
├── Narrative (chapter.qmd)           # Research story
├── Code (executable blocks)           # Methods implementation
├── Data                               # Inputs
│   ├── Local artifacts (OCI)         # Cached/preprocessed
│   └── Cloud sources (STAC)          # Live queries
├── Environment (Dockerfile, renv)     # Computational setup
├── Outputs (generated on demand)      # Results
├── Metadata (YAML frontmatter)        # Citation, provenance
├── Documentation (README, design)     # Context
└── License (LICENSE file)             # Usage rights
```

**Key Principle**: The compendium is the **unit of publication**, not just the rendered HTML. A reader should be able to:

1. **Read** the narrative in the handbook
2. **Cite** the specific version via DOI
3. **Execute** the analysis via "Reproduce" button
4. **Extend** by modifying code/data in their session
5. **Archive** by forking the repository or downloading from Zenodo
6. **Discover** via data catalogs, ORCID profiles, or citation networks

---

## Part 2: Architecture Enhancements

### 2.1 Citation and DOI Infrastructure

#### 2.1.1 Zenodo Integration Strategy

**Zenodo** provides persistent DOIs for research outputs via GitHub integration. Each handbook release can mint DOIs for:
- **Repository-level** (entire handbook as a collection)
- **Chapter-level** (individual chapters as standalone outputs)
- **Data-level** (specific datasets as citable objects)

**Architecture**:

```
┌─────────────────────────────────────────────────────────────┐
│                    GitHub Repository                         │
│                  (FAO-EOSTAT/UN-Handbook)                   │
└─────────────────────────┬───────────────────────────────────┘
                          │
                          │ On git tag push (e.g., v1.0.0-ct_chile)
                          ↓
┌─────────────────────────────────────────────────────────────┐
│                    GitHub Actions Workflow                   │
│  - Detect chapter from tag                                   │
│  - Extract metadata from .qmd frontmatter                    │
│  - Generate .zenodo.json for chapter                         │
│  - Create GitHub Release                                     │
└─────────────────────────┬───────────────────────────────────┘
                          │
                          │ Webhook trigger
                          ↓
┌─────────────────────────────────────────────────────────────┐
│                         Zenodo                               │
│  - Mints DOI (e.g., 10.5281/zenodo.1234567)                │
│  - Archives release tarball                                  │
│  - Publishes metadata to DataCite                           │
└─────────────────────────┬───────────────────────────────────┘
                          │
                          │ DOI resolves to
                          ↓
┌─────────────────────────────────────────────────────────────┐
│                    Zenodo Landing Page                       │
│  - Chapter metadata (authors, abstract, keywords)           │
│  - Download links (tarball, individual files)               │
│  - "Cite this" widget                                        │
│  - Link back to live handbook                                │
│  - Related identifiers (data DOIs, ORCID)                   │
└─────────────────────────────────────────────────────────────┘
```

**Implementation Steps**:

1. **Enable GitHub-Zenodo Integration**:
   - Authenticate Zenodo with GitHub repository
   - Configure automatic release preservation
   - Set repository-level metadata (.zenodo.json)

2. **Chapter-Level DOI Workflow**:
   - Tag releases per chapter: `v1.0.0-ct_chile`, `v1.1.0-ct_chile`
   - GitHub Action generates chapter-specific .zenodo.json
   - Zenodo mints separate DOI for each chapter release

3. **Metadata Synchronization**:
   - Extract authors, ORCID, keywords from .qmd frontmatter
   - Map to Zenodo schema (DataCite 4.3)
   - Auto-commit DOI back to chapter frontmatter

#### 2.1.2 Enhanced Chapter Frontmatter

**Current (v1.0)**:
```yaml
---
title: "Crop Type Mapping - Chile"
reproducible:
  enabled: true
  tier: heavy
  data-snapshot: sha256-abc123
---
```

**Enhanced (v2.0)**:
```yaml
---
title: "Crop Type Mapping - Chile: Random Forest Classification of Agricultural Parcels"

# Citation metadata
citation:
  type: chapter
  container-title: "UN Handbook on Remote Sensing for Agricultural Statistics"
  doi: "10.5281/zenodo.1234567"  # Auto-updated by CI after Zenodo release
  version: "1.0.0"
  date-published: "2025-01-15"
  license: "CC-BY-4.0"

# Authors with ORCID
authors:
  - name: "María González"
    orcid: "0000-0002-1234-5678"
    affiliation: "Chilean Ministry of Agriculture"
    roles: ["conceptualization", "methodology", "software", "writing"]
  - name: "Carlos Silva"
    orcid: "0000-0003-9876-5432"
    affiliation: "University of Chile"
    roles: ["data curation", "validation"]

# Keywords for discovery
keywords:
  - "crop type mapping"
  - "Random Forest"
  - "Sentinel-2"
  - "Chile"
  - "agricultural statistics"

# Abstract (150-200 words)
abstract: |
  This chapter demonstrates crop type mapping in Chile's central valley
  using Sentinel-2 satellite imagery and Random Forest classification.
  We classify agricultural parcels into wheat, maize, and vineyard categories
  using 62,920 training points from 4,140 field-validated polygons.
  The methodology achieves 92% overall accuracy with F1-scores >0.89 for
  all classes. Pre-trained models and training data are provided for
  reproducibility. The analysis combines local cached artifacts (models,
  samples) with live STAC queries for satellite imagery, enabling both
  exact reproduction and extension to new time periods.

# Reproducibility metadata
reproducible:
  enabled: true
  tier: heavy
  estimated-runtime: "45 minutes"
  storage-size: "50Gi"

  # Computational artifacts
  compute-image:
    repository: "ghcr.io/fao-eostat/handbook-base"
    tag: "v1.0"
    digest: "sha256:def456..."

  data-snapshot:
    version: "sha256-abc123"
    size: "57 MB"
    registry: "ghcr.io/fao-eostat/handbook-data"
    tag: "ct_chile-sha256-abc123"

# Data sources and provenance
data-sources:
  local:
    - name: "Chile crop classification training samples"
      path: "data/ct_chile/training.rds"
      size: "12 MB"
      format: "RDS (R Data Serialization)"
      description: "62,920 training points from 4,140 field polygons"
      provenance:
        source: "Chilean Ministry of Agriculture, Crop Survey 2023"
        collection-date: "2023-03-15 to 2023-05-30"
        labeling-protocol: "Expert agronomist field validation"
        quality-assurance: "Cross-validation with farmer interviews"
      license: "CC-BY-4.0"
      citation: "Chilean Ministry of Agriculture (2023). Crop Survey Data."

    - name: "Pre-trained Random Forest model"
      path: "data/ct_chile/rf_model.rds"
      size: "8 MB"
      format: "RDS (ranger model object)"
      description: "500 trees, mtry=3, trained on 2023 Sentinel-2 features"
      provenance:
        training-date: "2023-06-15"
        validation-method: "5-fold spatial cross-validation"
        hyperparameters:
          num_trees: 500
          mtry: 3
          min_node_size: 5
        performance:
          overall_accuracy: 0.92
          kappa: 0.88
          f1_wheat: 0.91
          f1_maize: 0.89
          f1_vineyard: 0.94
      license: "MIT"

  cloud:
    - name: "Sentinel-2 Level-2A Surface Reflectance"
      stac-endpoint: "https://earth-search.aws.element84.com/v1"
      collection: "sentinel-2-l2a"
      spatial-extent:
        bbox: [-71.5, -33.5, -70.5, -32.5]
        description: "Central Valley, Chile"
      temporal-extent:
        start: "2023-01-01"
        end: "2023-12-31"
        description: "Full 2023 growing season"
      bands-used: ["B02", "B03", "B04", "B08", "B11", "B12"]
      access: "Public (AWS Open Data, no authentication required)"
      license: "Copernicus Sentinel Data - ESA (CC-BY-SA-3.0-IGO)"
      citation: |
        European Space Agency (2023). Sentinel-2 Level-2A.
        Accessed via AWS Open Data: https://registry.opendata.aws/sentinel-2/

# Related resources
related:
  - type: "dataset"
    description: "Training data archived on Zenodo"
    doi: "10.5281/zenodo.1234568"
  - type: "software"
    description: "sits R package for satellite image time series analysis"
    url: "https://github.com/e-sensing/sits"
    citation: "Simoes et al. (2021). sits: Satellite Image Time Series Analysis. doi:10.18637/jss.v099.i05"
  - type: "documentation"
    description: "Random Forest methodology"
    url: "https://en.wikipedia.org/wiki/Random_forest"

# Data ethics and governance
data-governance:
  sensitivity-level: "Public"
  privacy-concerns: "None (aggregated agricultural parcels, no farm-level data)"
  ethical-approval: "Not required (publicly available agricultural statistics)"
  data-sharing-restrictions: "None"
  intended-use: "Academic research, agricultural monitoring, educational purposes"
  prohibited-use: "Commercial profiling of individual farmers"

# Changelog
changelog:
  - version: "1.0.0"
    date: "2025-01-15"
    changes: "Initial release with 2023 training data"
  - version: "1.1.0"
    date: "2025-03-20"
    changes: "Added validation results for 2024 season"
---
```

**Schema Validation**: Create JSON Schema for validating chapter frontmatter:

```json
{
  "$schema": "http://json-schema.org/draft-07/schema#",
  "title": "UN Handbook Chapter Metadata Schema v2.0",
  "type": "object",
  "required": ["title", "citation", "authors", "abstract"],
  "properties": {
    "citation": {
      "type": "object",
      "required": ["type", "doi", "version", "license"],
      "properties": {
        "type": {"enum": ["chapter", "article", "software"]},
        "doi": {"type": "string", "pattern": "^10\\.\\d{4,}/.*$"},
        "version": {"type": "string", "pattern": "^\\d+\\.\\d+\\.\\d+$"},
        "license": {"enum": ["CC-BY-4.0", "CC-BY-SA-4.0", "CC0-1.0", "MIT"]}
      }
    },
    "authors": {
      "type": "array",
      "minItems": 1,
      "items": {
        "type": "object",
        "required": ["name", "orcid", "affiliation"],
        "properties": {
          "name": {"type": "string"},
          "orcid": {"type": "string", "pattern": "^\\d{4}-\\d{4}-\\d{4}-\\d{3}[0-9X]$"},
          "affiliation": {"type": "string"},
          "roles": {
            "type": "array",
            "items": {
              "enum": [
                "conceptualization", "methodology", "software", "validation",
                "formal analysis", "investigation", "resources", "data curation",
                "writing", "visualization", "supervision", "project administration",
                "funding acquisition"
              ]
            }
          }
        }
      }
    },
    "abstract": {
      "type": "string",
      "minLength": 100,
      "maxLength": 500
    },
    "keywords": {
      "type": "array",
      "minItems": 3,
      "maxItems": 10,
      "items": {"type": "string"}
    }
  }
}
```

#### 2.1.3 Automated DOI Workflow

**GitHub Actions Workflow** (`.github/workflows/mint-doi.yml`):

```yaml
name: Mint DOI for Chapter Release

on:
  push:
    tags:
      - 'v*.*.*-*'  # Matches v1.0.0-ct_chile

jobs:
  mint-doi:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout repository
        uses: actions/checkout@v4
        with:
          fetch-depth: 0

      - name: Parse tag
        id: parse
        run: |
          TAG="${GITHUB_REF#refs/tags/}"
          VERSION=$(echo $TAG | grep -oP '^v\K[0-9]+\.[0-9]+\.[0-9]+')
          CHAPTER=$(echo $TAG | grep -oP '(?<=-).+$')
          echo "version=$VERSION" >> $GITHUB_OUTPUT
          echo "chapter=$CHAPTER" >> $GITHUB_OUTPUT
          echo "tag=$TAG" >> $GITHUB_OUTPUT

      - name: Extract chapter metadata
        id: metadata
        run: |
          CHAPTER_FILE="chapters/${{ steps.parse.outputs.chapter }}.qmd"

          if [ ! -f "$CHAPTER_FILE" ]; then
            echo "Error: Chapter file not found: $CHAPTER_FILE"
            exit 1
          fi

          # Extract YAML frontmatter using yq
          sudo snap install yq

          TITLE=$(yq eval '.title' $CHAPTER_FILE)
          AUTHORS=$(yq eval '.authors | map(.name) | join(", ")' $CHAPTER_FILE)
          ABSTRACT=$(yq eval '.abstract' $CHAPTER_FILE)
          KEYWORDS=$(yq eval '.keywords | join("; ")' $CHAPTER_FILE)
          LICENSE=$(yq eval '.citation.license' $CHAPTER_FILE)

          # Store in multiline output
          echo "title<<EOF" >> $GITHUB_OUTPUT
          echo "$TITLE" >> $GITHUB_OUTPUT
          echo "EOF" >> $GITHUB_OUTPUT

          echo "authors=$AUTHORS" >> $GITHUB_OUTPUT
          echo "abstract<<EOF" >> $GITHUB_OUTPUT
          echo "$ABSTRACT" >> $GITHUB_OUTPUT
          echo "EOF" >> $GITHUB_OUTPUT
          echo "keywords=$KEYWORDS" >> $GITHUB_OUTPUT
          echo "license=$LICENSE" >> $GITHUB_OUTPUT

      - name: Generate Zenodo metadata
        run: |
          cat > .zenodo.json <<EOF
          {
            "title": "${{ steps.metadata.outputs.title }} (v${{ steps.parse.outputs.version }})",
            "description": "${{ steps.metadata.outputs.abstract }}",
            "creators": [
              $(yq eval '.authors[] | {"name": .name, "orcid": .orcid, "affiliation": .affiliation}' chapters/${{ steps.parse.outputs.chapter }}.qmd -o=json | jq -s '.')
            ],
            "keywords": $(echo '${{ steps.metadata.outputs.keywords }}' | jq -R 'split("; ")'),
            "license": "${{ steps.metadata.outputs.license }}",
            "upload_type": "software",
            "publication_date": "$(date +%Y-%m-%d)",
            "version": "${{ steps.parse.outputs.version }}",
            "related_identifiers": [
              {
                "relation": "isSupplementTo",
                "identifier": "https://fao-eostat.github.io/UN-Handbook/chapters/${{ steps.parse.outputs.chapter }}.html",
                "resource_type": "publication-chapter",
                "scheme": "url"
              }
            ],
            "communities": [
              {"identifier": "un-handbook-remote-sensing"}
            ]
          }
          EOF

          cat .zenodo.json

      - name: Create GitHub Release
        uses: softprops/action-gh-release@v1
        with:
          tag_name: ${{ steps.parse.outputs.tag }}
          name: "${{ steps.metadata.outputs.title }} - v${{ steps.parse.outputs.version }}"
          body: |
            ## Chapter Release: ${{ steps.metadata.outputs.title }}

            **Version**: ${{ steps.parse.outputs.version }}
            **Authors**: ${{ steps.metadata.outputs.authors }}

            ### Abstract
            ${{ steps.metadata.outputs.abstract }}

            ### How to Cite
            ```
            ${{ steps.metadata.outputs.authors }} (${{ steps.metadata.outputs.version }}).
            ${{ steps.metadata.outputs.title }}.
            In: UN Handbook on Remote Sensing for Agricultural Statistics.
            DOI: [Will be updated automatically after Zenodo archival]
            ```

            ### Reproducibility
            - **One-Click Launch**: Visit the [live chapter](https://fao-eostat.github.io/UN-Handbook/chapters/${{ steps.parse.outputs.chapter }}.html) and click "Reproduce this analysis"
            - **Manual Setup**: Download this release and follow instructions in README.md
            - **Data Artifacts**: `ghcr.io/fao-eostat/handbook-data:${{ steps.parse.outputs.chapter }}-${{ steps.metadata.outputs.data-snapshot }}`

            ### License
            - **Code**: MIT License
            - **Documentation**: ${{ steps.metadata.outputs.license }}
            - **Data**: See data-sources section in chapter frontmatter
          files: |
            .zenodo.json
            chapters/${{ steps.parse.outputs.chapter }}.qmd
          draft: false
          prerelease: false
        env:
          GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}

      - name: Wait for Zenodo archival
        run: |
          echo "Waiting 60 seconds for Zenodo to process the release..."
          sleep 60

          # Note: In production, poll Zenodo API for completion
          # For now, manual verification required

      - name: Update chapter with DOI (manual step)
        run: |
          echo "⚠️  MANUAL STEP REQUIRED:"
          echo "1. Check Zenodo for the new DOI at: https://zenodo.org/account/settings/github/repository/FAO-EOSTAT/UN-Handbook"
          echo "2. Update chapters/${{ steps.parse.outputs.chapter }}.qmd with the DOI"
          echo "3. Commit the change: git add chapters/${{ steps.parse.outputs.chapter }}.qmd && git commit -m 'docs: add DOI for ${{ steps.parse.outputs.tag }}'"
```

**Usage**:
```bash
# Author ready to publish Chile chapter v1.0.0
git tag v1.0.0-ct_chile
git push origin v1.0.0-ct_chile

# CI automatically:
# 1. Extracts metadata from chapters/ct_chile.qmd
# 2. Generates .zenodo.json
# 3. Creates GitHub Release
# 4. Zenodo webhook mints DOI
# 5. Author manually updates .qmd with DOI (or future: auto-commit)
```

### 2.2 Data Catalog Integration

#### 2.2.1 Strategy: Dual Registration

Handbook datasets should be discoverable through:
1. **FAO/UN Data Catalogs** - Institutional discovery systems
2. **Domain-Specific Registries** - Agricultural statistics, remote sensing communities
3. **General Research Repositories** - Zenodo, Dryad, Figshare

**Architecture**:

```
┌──────────────────────────────────────────────────────────┐
│         Chapter with Local Data (e.g., ct_chile)         │
│  - Training samples (12 MB)                              │
│  - Pre-trained model (8 MB)                              │
│  - ROI boundaries (500 KB)                               │
└────────────────────────┬─────────────────────────────────┘
                         │
                         │ On data change, CI packages as OCI artifact
                         ↓
┌──────────────────────────────────────────────────────────┐
│           GitHub Container Registry (GHCR)                │
│  ghcr.io/fao-eostat/handbook-data:ct_chile-sha256-abc123│
│  - Content-hashed (immutable)                            │
│  - Versioned tags                                        │
│  - Public access (no auth)                               │
└────────────────────────┬─────────────────────────────────┘
                         │
                         │ CI generates catalog metadata
                         ↓
┌──────────────────────────────────────────────────────────┐
│                  Metadata Registrations                   │
│                                                           │
│  ┌─────────────────────────────────────────────┐        │
│  │  1. Zenodo (DOI for dataset)                │        │
│  │     - Persistent identifier                 │        │
│  │     - Long-term archival                    │        │
│  │     - DataCite metadata                     │        │
│  └─────────────────────────────────────────────┘        │
│                                                           │
│  ┌─────────────────────────────────────────────┐        │
│  │  2. FAO Data Catalog (institutional)        │        │
│  │     - Internal discovery                    │        │
│  │     - Policy integration                    │        │
│  │     - Usage tracking                        │        │
│  └─────────────────────────────────────────────┘        │
│                                                           │
│  ┌─────────────────────────────────────────────┐        │
│  │  3. STAC Catalog (geospatial)              │        │
│  │     - Spatial/temporal search               │        │
│  │     - Cloud-optimized metadata              │        │
│  │     - Interoperable with GIS tools          │        │
│  └─────────────────────────────────────────────┘        │
│                                                           │
│  ┌─────────────────────────────────────────────┐        │
│  │  4. Schema.org (web discovery)              │        │
│  │     - Embedded in chapter HTML              │        │
│  │     - Google Dataset Search                 │        │
│  │     - SEO optimization                      │        │
│  └─────────────────────────────────────────────┘        │
└──────────────────────────────────────────────────────────┘
```

#### 2.2.2 STAC Catalog for Chapter Data

**Strategy**: Generate STAC (SpatioTemporal Asset Catalog) metadata for chapter datasets, enabling geospatial discovery.

**STAC Item Example** (`stac/ct_chile.json`):

```json
{
  "stac_version": "1.0.0",
  "type": "Feature",
  "id": "un-handbook-ct-chile-training-v1.0.0",
  "bbox": [-71.5, -33.5, -70.5, -32.5],
  "geometry": {
    "type": "Polygon",
    "coordinates": [[
      [-71.5, -33.5],
      [-70.5, -33.5],
      [-70.5, -32.5],
      [-71.5, -32.5],
      [-71.5, -33.5]
    ]]
  },
  "properties": {
    "title": "Chile Crop Classification Training Samples",
    "description": "62,920 training points from 4,140 field-validated agricultural parcels in Chile's central valley. Labeled by expert agronomists for wheat, maize, and vineyard classes.",
    "datetime": "2023-03-15T00:00:00Z",
    "start_datetime": "2023-03-15T00:00:00Z",
    "end_datetime": "2023-05-30T23:59:59Z",
    "created": "2023-06-15T10:30:00Z",
    "updated": "2025-01-15T14:20:00Z",
    "license": "CC-BY-4.0",
    "providers": [
      {
        "name": "Chilean Ministry of Agriculture",
        "roles": ["producer", "licensor"],
        "url": "https://www.minagri.gob.cl/"
      },
      {
        "name": "UN FAO",
        "roles": ["host", "processor"],
        "url": "https://www.fao.org/"
      }
    ],
    "sci:doi": "10.5281/zenodo.1234568",
    "sci:citation": "Chilean Ministry of Agriculture (2023). Crop Survey Training Data. doi:10.5281/zenodo.1234568",
    "version": "1.0.0",
    "deprecated": false
  },
  "links": [
    {
      "rel": "self",
      "href": "https://fao-eostat.github.io/UN-Handbook/stac/ct_chile.json",
      "type": "application/geo+json"
    },
    {
      "rel": "parent",
      "href": "https://fao-eostat.github.io/UN-Handbook/stac/catalog.json",
      "type": "application/json"
    },
    {
      "rel": "collection",
      "href": "https://fao-eostat.github.io/UN-Handbook/stac/collections/training-data.json",
      "type": "application/json"
    },
    {
      "rel": "related",
      "href": "https://fao-eostat.github.io/UN-Handbook/chapters/ct_chile.html",
      "type": "text/html",
      "title": "Chapter: Crop Type Mapping - Chile"
    },
    {
      "rel": "via",
      "href": "https://doi.org/10.5281/zenodo.1234568",
      "type": "text/html",
      "title": "Dataset on Zenodo"
    }
  ],
  "assets": {
    "training-samples": {
      "href": "oci://ghcr.io/fao-eostat/handbook-data:ct_chile-sha256-abc123@/data/ct_chile/training.rds",
      "type": "application/octet-stream",
      "title": "Training samples (RDS format)",
      "roles": ["data"],
      "file:size": 12582912,
      "file:checksum": "sha256:abc123def456...",
      "proj:epsg": 4326
    },
    "rf-model": {
      "href": "oci://ghcr.io/fao-eostat/handbook-data:ct_chile-sha256-abc123@/data/ct_chile/rf_model.rds",
      "type": "application/octet-stream",
      "title": "Pre-trained Random Forest model",
      "roles": ["ml-model:model"],
      "file:size": 8388608,
      "file:checksum": "sha256:def456abc789...",
      "ml-model:type": "random-forest",
      "ml-model:framework": "ranger",
      "ml-model:training-processor-type": "cpu"
    },
    "documentation": {
      "href": "https://fao-eostat.github.io/UN-Handbook/chapters/ct_chile.html",
      "type": "text/html",
      "title": "Chapter Documentation",
      "roles": ["metadata"]
    }
  },
  "stac_extensions": [
    "https://stac-extensions.github.io/file/v2.1.0/schema.json",
    "https://stac-extensions.github.io/scientific/v1.0.0/schema.json",
    "https://stac-extensions.github.io/projection/v1.1.0/schema.json",
    "https://stac-extensions.github.io/ml-model/v1.0.0/schema.json"
  ]
}
```

**CI Workflow to Generate STAC Metadata** (`.github/workflows/generate-stac.yml`):

```yaml
name: Generate STAC Catalog

on:
  push:
    paths:
      - 'chapters/*.qmd'
      - 'data/**'
  workflow_dispatch:

jobs:
  generate-stac:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4

      - name: Setup Python
        uses: actions/setup-python@v5
        with:
          python-version: '3.11'

      - name: Install dependencies
        run: |
          pip install pystac pyyaml

      - name: Generate STAC catalog
        run: |
          python scripts/generate-stac-catalog.py

      - name: Validate STAC
        run: |
          pip install stac-validator
          stac-validator stac/catalog.json --verbose

      - name: Commit STAC metadata
        run: |
          git config user.name "github-actions[bot]"
          git config user.email "github-actions[bot]@users.noreply.github.com"
          git add stac/
          git commit -m "chore: update STAC catalog metadata [skip ci]" || echo "No changes"
          git push
```

**Python Script** (`scripts/generate-stac-catalog.py`):

```python
#!/usr/bin/env python3
"""Generate STAC catalog from chapter metadata."""

import json
import yaml
from pathlib import Path
from datetime import datetime
import pystac

def extract_chapter_metadata(qmd_file):
    """Extract YAML frontmatter from .qmd file."""
    with open(qmd_file, 'r') as f:
        content = f.read()

    # Find YAML frontmatter between --- delimiters
    parts = content.split('---')
    if len(parts) < 3:
        return None

    metadata = yaml.safe_load(parts[1])
    return metadata

def create_stac_item(chapter_name, metadata):
    """Create STAC Item from chapter metadata."""
    data_sources = metadata.get('data-sources', {}).get('local', [])

    if not data_sources:
        return None  # Skip chapters without local data

    # Extract spatial extent from first data source
    bbox = metadata.get('data-sources', {}).get('cloud', [{}])[0].get('spatial-extent', {}).get('bbox')
    if not bbox:
        bbox = [-180, -90, 180, 90]  # Default global extent

    # Create STAC Item
    item = pystac.Item(
        id=f"un-handbook-{chapter_name}-v{metadata['citation']['version']}",
        geometry=pystac.utils.bbox_to_geom(bbox),
        bbox=bbox,
        datetime=datetime.fromisoformat(metadata['citation']['date-published']),
        properties={
            'title': metadata['title'],
            'description': metadata['abstract'],
            'license': metadata['citation']['license'],
            'version': metadata['citation']['version'],
            'sci:doi': metadata['citation'].get('doi'),
            'sci:citation': f"{metadata['authors'][0]['name']} et al. ({metadata['citation']['version']}). {metadata['title']}. doi:{metadata['citation'].get('doi')}"
        }
    )

    # Add assets
    data_snapshot = metadata.get('reproducible', {}).get('data-snapshot', {})
    for ds in data_sources:
        asset_name = ds['name'].lower().replace(' ', '-')
        item.add_asset(
            asset_name,
            pystac.Asset(
                href=f"oci://ghcr.io/fao-eostat/handbook-data:{chapter_name}-{data_snapshot['version']}@{ds['path']}",
                title=ds['name'],
                description=ds['description'],
                media_type='application/octet-stream',
                roles=['data'],
                extra_fields={
                    'file:size': ds.get('size'),
                    'file:checksum': data_snapshot.get('version')
                }
            )
        )

    return item

def main():
    """Generate STAC catalog for all chapters."""
    catalog = pystac.Catalog(
        id='un-handbook-data',
        description='UN Handbook on Remote Sensing for Agricultural Statistics - Data Catalog',
        title='UN Handbook Data Catalog'
    )

    # Process all chapters
    chapters_dir = Path('chapters')
    for qmd_file in chapters_dir.glob('*.qmd'):
        chapter_name = qmd_file.stem
        metadata = extract_chapter_metadata(qmd_file)

        if not metadata or not metadata.get('reproducible', {}).get('enabled'):
            continue

        item = create_stac_item(chapter_name, metadata)
        if item:
            catalog.add_item(item)
            print(f"Added STAC item for {chapter_name}")

    # Save catalog
    output_dir = Path('stac')
    output_dir.mkdir(exist_ok=True)
    catalog.normalize_hrefs(str(output_dir))
    catalog.save(catalog_type=pystac.CatalogType.SELF_CONTAINED)

    print(f"STAC catalog saved to {output_dir}/catalog.json")

if __name__ == '__main__':
    main()
```

#### 2.2.3 FAO Data Catalog Integration

**Strategy**: Register handbook datasets with FAO's internal data catalog system.

**Metadata Mapping**:

| FAO Catalog Field | Source | Example |
|-------------------|--------|---------|
| Title | `citation.title` | "Chile Crop Classification Training Samples" |
| Description | `abstract` | "62,920 training points from..." |
| Publisher | Hardcoded | "FAO-EOSTAT" |
| Publication Date | `citation.date-published` | "2025-01-15" |
| Spatial Coverage | `data-sources.cloud[].spatial-extent` | "Central Valley, Chile" |
| Temporal Coverage | `data-sources.cloud[].temporal-extent` | "2023-01-01/2023-12-31" |
| License | `citation.license` | "CC-BY-4.0" |
| DOI | `citation.doi` | "10.5281/zenodo.1234567" |
| Access URL | OCI registry + chapter link | Multiple URLs |
| Contact | `authors[0]` | "maría.gonzalez@minagri.cl" |

**CI Workflow** (`.github/workflows/register-fao-catalog.yml`):

```yaml
name: Register with FAO Data Catalog

on:
  release:
    types: [published]
  workflow_dispatch:
    inputs:
      chapter:
        description: 'Chapter name (e.g., ct_chile)'
        required: true

jobs:
  register:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4

      - name: Extract chapter from release
        id: chapter
        run: |
          if [ "${{ github.event_name }}" = "workflow_dispatch" ]; then
            echo "name=${{ github.event.inputs.chapter }}" >> $GITHUB_OUTPUT
          else
            # Extract from release tag (e.g., v1.0.0-ct_chile -> ct_chile)
            TAG="${{ github.event.release.tag_name }}"
            CHAPTER=$(echo $TAG | grep -oP '(?<=-).+$')
            echo "name=$CHAPTER" >> $GITHUB_OUTPUT
          fi

      - name: Generate FAO catalog metadata
        run: |
          CHAPTER="${{ steps.chapter.outputs.name }}"

          # Extract metadata from chapter frontmatter
          python scripts/extract-metadata.py chapters/${CHAPTER}.qmd > /tmp/metadata.json

          # Transform to FAO catalog schema
          python scripts/transform-to-fao-schema.py /tmp/metadata.json > /tmp/fao-metadata.json

          cat /tmp/fao-metadata.json

      - name: Submit to FAO Data Catalog API
        run: |
          # Note: Replace with actual FAO catalog API endpoint
          curl -X POST \
            -H "Authorization: Bearer ${{ secrets.FAO_CATALOG_API_KEY }}" \
            -H "Content-Type: application/json" \
            -d @/tmp/fao-metadata.json \
            https://data.fao.org/api/v1/datasets
        continue-on-error: true  # Don't fail build if catalog registration fails

      - name: Record registration
        run: |
          echo "Dataset registered with FAO Data Catalog at $(date)" >> catalog-registrations.log
          git add catalog-registrations.log
          git commit -m "chore: record FAO catalog registration for ${{ steps.chapter.outputs.name }}"
          git push
```

---

## Part 3: User Experience and Author Guidance

### 3.1 User Journey Maps

#### 3.1.1 Journey 1: Policy Maker (Non-Technical Reader)

**Persona**: UN Agricultural Statistician reviewing methodologies for national adoption

**Goal**: Assess methodology transparency and validate accuracy claims

**Journey**:
1. **Discovery**: Finds handbook chapter through FAO data catalog search
2. **Read**: Reviews chapter narrative, sees "92% classification accuracy"
3. **Verify**: Clicks "Reproduce this analysis" button
4. **Explore**: JupyterLab opens with pre-executed results visible
5. **Inspect**: Browses training data quality, model hyperparameters
6. **Export**: Downloads validation report (PDF/HTML)
7. **Cite**: References chapter DOI in national statistical methodology document

**Value**: Confidence that methodology is transparent, verifiable, and suitable for policy decisions

**Pain Points Addressed**:
- ❌ Old: "How do I know this actually works?"
- ✅ New: One-click verification without technical setup

#### 3.1.2 Journey 2: Researcher (Extending Methods)

**Persona**: PhD student adapting Chile crop classification to Kenya smallholder farms

**Goal**: Reuse proven methodology for different region and crop types

**Journey**:
1. **Discovery**: Searches Google Scholar for "crop classification Random Forest"
2. **Read**: Reviews Chile chapter, identifies relevant methodology
3. **Reproduce**: Clicks "Reproduce" button, explores code in JupyterLab
4. **Adapt**: Modifies STAC query to Kenya region, changes crop classes
5. **Train**: Runs with new training samples (collected in Kenya)
6. **Compare**: Evaluates performance against Chile baseline
7. **Publish**: Writes paper citing Chile chapter DOI
8. **Share**: Publishes Kenya results as derivative work with new DOI

**Value**: Accelerated research timeline (weeks vs. months), proven methodology foundation

**Pain Points Addressed**:
- ❌ Old: "I'd need to reimplement everything from scratch"
- ✅ New: Functional code ready to adapt, no environment setup

#### 3.1.3 Journey 3: Educator (Teaching Remote Sensing)

**Persona**: University professor teaching "Remote Sensing for Agriculture" course

**Goal**: Provide hands-on learning without IT infrastructure burden

**Journey**:
1. **Preparation**: Assigns Chile chapter as required reading (Week 8)
2. **Assignment**: "Click 'Reproduce', modify cloud cover threshold, compare results"
3. **Students**: Each gets isolated JupyterLab session (no conflicts)
4. **Experiment**: Students test different spectral band combinations
5. **Discussion**: Class compares results, discusses trade-offs
6. **Assessment**: Students submit modified notebooks as homework
7. **Cleanup**: Sessions auto-expire after 2 hours (no manual cleanup)

**Value**: Hands-on learning without university HPC cluster, zero IT support needed

**Pain Points Addressed**:
- ❌ Old: "We don't have compute resources for 30 students"
- ✅ New: Cloud-hosted, ephemeral sessions, no capacity planning

#### 3.1.4 Journey 4: Chapter Author (Contributing New Methods)

**Persona**: FAO scientist developing flood monitoring methodology

**Goal**: Publish methodology as reproducible chapter with DOI for career credit

**Journey**:
1. **Development**: Codes analysis in local R environment, tests with sample data
2. **Preparation**: Adds enhanced YAML frontmatter with citation metadata
3. **Data**: Commits training data to `data/flood_monitoring/` (3 GB)
4. **Push**: `git push` triggers CI pipeline
5. **Automation**: CI builds OCI data artifact, updates hash in `.qmd`
6. **Preview**: Tests by clicking "Reproduce" button in staging environment
7. **Review**: Submits PR, reviewers test via button
8. **Release**: Tags `v1.0.0-flood_monitoring`, CI mints DOI via Zenodo
9. **Recognition**: Updates CV with DOI, tracks citations via Google Scholar

**Value**: Scholarly credit for computational work, not just narrative papers

**Pain Points Addressed**:
- ❌ Old: "Code is just a GitHub link, no credit"
- ✅ New: DOI-based citability, integrated with academic metrics

### 3.2 Enhanced Author Guidance

#### 3.2.1 Publishing Checklist for Authors

Before marking a chapter as `reproducible: enabled: true`, complete:

**Code Quality**:
- [ ] Code runs without errors in fresh environment
- [ ] All package dependencies in `renv.lock`
- [ ] No hardcoded file paths (use relative paths or `here::here()`)
- [ ] Code comments explain *why*, not just *what*
- [ ] Execution time tested (not estimated)

**Data Provenance**:
- [ ] All data sources documented in frontmatter
- [ ] Local data has clear origin (who collected, when, how)
- [ ] Cloud data has STAC endpoint and collection ID
- [ ] Training data labeling protocol described
- [ ] Model validation methodology documented

**Metadata Completeness**:
- [ ] All authors have ORCID identifiers
- [ ] Abstract is 150-200 words, describes contribution
- [ ] Keywords include domain terms (at least 5)
- [ ] License specified for code and data separately
- [ ] Spatial/temporal extent defined

**Scholarly Requirements**:
- [ ] Related work cited (software packages, data sources)
- [ ] Limitations documented (known issues, edge cases)
- [ ] Intended use cases specified
- [ ] Prohibited uses identified (if applicable)
- [ ] Ethical considerations addressed

**Technical Requirements**:
- [ ] Resource tier tested (not guessed)
- [ ] Estimated runtime verified with actual runs
- [ ] Storage size calculated (not estimated)
- [ ] "Reproduce" button tested in staging environment

**DOI Readiness**:
- [ ] Version number follows semantic versioning (1.0.0)
- [ ] Changelog documents what changed since last version
- [ ] GitHub release notes drafted
- [ ] Zenodo community selected (`un-handbook-remote-sensing`)

#### 3.2.2 Data Provenance Template

**For Local Training Data** (`data/<chapter>/README.md`):

```markdown
# Dataset: [Dataset Name]

## Overview
- **Size**: [e.g., 12 MB]
- **Format**: [e.g., RDS, GeoPackage, Parquet]
- **Records**: [e.g., 62,920 training points]
- **License**: [e.g., CC-BY-4.0]
- **DOI**: [e.g., 10.5281/zenodo.1234568] (if published separately)

## Provenance

### Data Collection
- **Source**: [Organization, project name]
- **Collection Date**: [Start date to end date]
- **Geographic Extent**: [Country, region, bbox]
- **Collection Method**: [Field survey, satellite imagery, etc.]
- **Sampling Strategy**: [Random, stratified, targeted]

### Labeling
- **Labelers**: [Expert agronomists, automated, crowdsourced]
- **Protocol**: [Description of how labels were assigned]
- **Quality Control**: [Validation method, inter-rater agreement]
- **Label Classes**: [List of categories with definitions]

### Processing
- **Raw Data**: [Original format, location if public]
- **Processing Steps**:
  1. [Step 1: e.g., Coordinate transformation to WGS84]
  2. [Step 2: e.g., Removal of invalid geometries]
  3. [Step 3: e.g., Stratified sampling to balance classes]
- **Processing Date**: [When preprocessing occurred]
- **Code**: [Link to processing scripts]

### Quality Assessment
- **Completeness**: [e.g., "98% of polygons have valid labels"]
- **Accuracy**: [e.g., "Cross-validated with farmer interviews"]
- **Known Issues**: [e.g., "Underrepresentation of vineyard class in Region X"]
- **Limitations**: [e.g., "Limited to 2023 growing season"]

## Usage

### Loading in R
\`\`\`r
training_data <- readRDS("data/ct_chile/training.rds")
str(training_data)
\`\`\`

### Loading in Python
\`\`\`python
import pandas as pd
training_data = pd.read_parquet("data/ct_chile/training.parquet")
training_data.info()
\`\`\`

### Schema
| Field | Type | Description |
|-------|------|-------------|
| `id` | integer | Unique sample identifier |
| `geometry` | point | WGS84 coordinates |
| `crop_type` | factor | Crop class (wheat, maize, vineyard) |
| `survey_date` | date | Field validation date |
| `confidence` | numeric | Labeler confidence (1-5 scale) |

## Citation
```
[Author(s)] ([Year]). [Dataset Name]. [Version]. [Publisher]. [DOI]
```

Example:
```
González, M., Silva, C. (2023). Chile Crop Classification Training Samples.
Version 1.0. Chilean Ministry of Agriculture. doi:10.5281/zenodo.1234568
```

## Contact
- **Maintainer**: [Name, email]
- **Organization**: [Institution]
- **Website**: [Project page]
```

#### 3.2.3 Model Card Template

**For Pre-Trained Models** (`data/<chapter>/MODEL_CARD.md`):

```markdown
# Model Card: [Model Name]

## Model Details
- **Model Type**: [e.g., Random Forest Classifier]
- **Framework**: [e.g., ranger, scikit-learn, PyTorch]
- **Version**: [e.g., 1.0.0]
- **Date Trained**: [e.g., 2023-06-15]
- **License**: [e.g., MIT]

## Intended Use
- **Primary Use**: [e.g., Crop type classification in Chile's central valley]
- **Intended Users**: [e.g., Agricultural statisticians, researchers]
- **Out-of-Scope Uses**: [e.g., Not validated for smallholder farms <1 hectare]

## Training Data
- **Dataset**: [Reference to training data README]
- **Size**: [e.g., 62,920 samples across 4,140 polygons]
- **Temporal Coverage**: [e.g., 2023 growing season (Jan-Dec)]
- **Spatial Coverage**: [e.g., Central Valley, Chile (-71.5 to -70.5 lon, -33.5 to -32.5 lat)]
- **Classes**:
  - Wheat (30% of samples)
  - Maize (35% of samples)
  - Vineyard (35% of samples)

## Model Architecture
- **Algorithm**: Random Forest
- **Hyperparameters**:
  ```yaml
  num_trees: 500
  mtry: 3  # sqrt(num_features)
  min_node_size: 5
  max_depth: null  # No limit
  ```
- **Features**: [List spectral bands, indices, temporal metrics]
  - Sentinel-2 bands: B02, B03, B04, B08, B11, B12
  - Derived indices: NDVI, EVI, NDWI
  - Temporal features: Mean, std, min, max per band (growing season)

## Training Procedure
- **Optimization**: Not applicable (Random Forest, no gradient descent)
- **Validation Strategy**: 5-fold spatial cross-validation
- **Early Stopping**: Not applicable
- **Training Time**: ~45 minutes (10 CPU, 48GB RAM)

## Performance

### Overall Metrics
| Metric | Value |
|--------|-------|
| Overall Accuracy | 0.92 |
| Kappa | 0.88 |
| Macro-averaged F1 | 0.91 |

### Per-Class Performance
| Class | Precision | Recall | F1-Score | Support |
|-------|-----------|--------|----------|---------|
| Wheat | 0.93 | 0.89 | 0.91 | 18,876 |
| Maize | 0.87 | 0.91 | 0.89 | 22,022 |
| Vineyard | 0.95 | 0.93 | 0.94 | 22,022 |

### Confusion Matrix
```
              Predicted
Actual     Wheat  Maize  Vineyard
Wheat      16,800  1,500    576
Maize       1,200 20,040    782
Vineyard      700  1,200 20,122
```

## Limitations
- **Geographic**: Trained on central Chile; not validated for other regions
- **Temporal**: 2023 growing season only; may not generalize to different years
- **Crop Types**: Limited to 3 classes; does not distinguish crop varieties
- **Resolution**: Sentinel-2 10m resolution; not suitable for sub-field heterogeneity
- **Cloud Cover**: Performance degrades with >20% cloud cover in imagery

## Bias Assessment
- **Class Imbalance**: Slight imbalance towards maize/vineyard (35% each) vs wheat (30%)
- **Spatial Bias**: Training samples concentrated in flat terrain; under-represents mountainous areas
- **Temporal Bias**: Peak growing season (Jan-Mar) better represented than harvest (Apr-Jun)

## Ethical Considerations
- **Privacy**: Aggregated parcel data; no individual farmer identification possible
- **Fairness**: Model may underperform for smallholder farms (<5 hectares) due to training data bias
- **Transparency**: All training data and code publicly available
- **Accountability**: Contact maintainer for errors or misuse concerns

## Caveats and Recommendations
1. Validate performance on local data before operational use
2. Consider retraining with regional data for non-Chile applications
3. Combine with ground-truth validation for high-stakes decisions
4. Monitor for distribution shift (e.g., new crop varieties, climate change)

## References
- [Link to chapter]
- [Link to training data DOI]
- [Citations to methodology papers]

## Contact
- **Maintainer**: [Name, email]
- **Organization**: [Institution]
- **Last Updated**: [Date]
```

### 3.3 Data Governance and Ethics

#### 3.3.1 Sensitivity Assessment Checklist

Before publishing chapter data, assess:

**Privacy Risk**:
- [ ] Does data include individual farmer/household identifiers?
- [ ] Can individuals be re-identified through location precision?
- [ ] Were participants informed about public data sharing?
- [ ] Is consent documentation available?

**Commercial Sensitivity**:
- [ ] Could data reveal proprietary farming practices?
- [ ] Are yield data aggregated to prevent competitive disadvantage?
- [ ] Do license terms prevent commercial exploitation?

**National Security**:
- [ ] Could infrastructure locations be identified?
- [ ] Is crop production data sensitive for food security?
- [ ] Have government data sharing agreements been reviewed?

**Ethical Use**:
- [ ] Could data be misused for surveillance or discrimination?
- [ ] Are prohibited uses clearly stated?
- [ ] Is data sharing consistent with original collection purpose?

**Decision Tree**:

```
Does data include personally identifiable information?
├─ Yes → Anonymize or obtain explicit consent → Continue
└─ No → Continue

Could individuals be re-identified through linkage?
├─ Yes → Aggregate spatial data or reduce precision → Continue
└─ No → Continue

Is data commercially sensitive?
├─ Yes → Apply restrictive license (e.g., NC clause) → Continue
└─ No → Continue

Is government approval required?
├─ Yes → Obtain clearance before publication → Continue
└─ No → Continue

Safe to publish with appropriate license and usage guidelines
```

#### 3.3.2 License Selection Guidance

**For Code**:
- **MIT License** (Recommended): Permissive, allows commercial use
- **Apache 2.0**: If patent protection needed
- **GPL-3.0**: If requiring derivative works to be open source

**For Data**:
- **CC-BY-4.0** (Recommended): Requires attribution, allows commercial use
- **CC-BY-SA-4.0**: Requires attribution and share-alike (derivatives open)
- **CC-BY-NC-4.0**: Non-commercial use only
- **CC0 (Public Domain)**: No restrictions (use for government data)

**For Models**:
- Typically same as code license (MIT)
- Consider restrictions if bias/misuse concerns

**Template License Statement** (add to chapter frontmatter):

```yaml
licenses:
  code:
    type: "MIT"
    url: "https://opensource.org/licenses/MIT"
    text: |
      Permission is hereby granted, free of charge, to any person obtaining
      a copy of this software...

  documentation:
    type: "CC-BY-4.0"
    url: "https://creativecommons.org/licenses/by/4.0/"
    summary: "You are free to share and adapt with attribution"

  data:
    local:
      type: "CC-BY-4.0"
      url: "https://creativecommons.org/licenses/by/4.0/"
      attribution: "Chilean Ministry of Agriculture (2023)"
      restrictions:
        - "Cannot be used for individual farmer profiling"
        - "Must aggregate to >100 hectare level for public reporting"

    cloud:
      type: "Copernicus Sentinel Data Terms"
      url: "https://scihub.copernicus.eu/twiki/do/view/SciHubWebPortal/TermsConditions"
      summary: "Free and open access with attribution"
```

---

## Part 4: Implementation Roadmap

### Phase 1: Citation Infrastructure (Weeks 1-4)

**Objective**: Enable DOI minting and citation metadata for handbook chapters

**Deliverables**:
1. ✅ Enhanced chapter frontmatter schema with citation metadata
2. ✅ JSON Schema validator for frontmatter
3. ✅ GitHub Actions workflow for Zenodo DOI minting
4. ✅ Template `.zenodo.json` generator
5. ✅ Author guidance documentation (publishing checklist)
6. ✅ Test DOI workflow with pilot chapter (ct_chile)

**Technical Tasks**:

**Week 1: Schema Design**
- [ ] Design enhanced YAML frontmatter schema (see §2.1.2)
- [ ] Create JSON Schema validator
- [ ] Document schema with examples
- [ ] Add validation to CI pipeline

**Week 2: Zenodo Integration**
- [ ] Enable GitHub-Zenodo webhook for repository
- [ ] Create `mint-doi.yml` workflow (see §2.1.3)
- [ ] Test with staging Zenodo (sandbox.zenodo.org)
- [ ] Create Zenodo community: `un-handbook-remote-sensing`

**Week 3: Metadata Extraction**
- [ ] Write Python script to extract frontmatter → `.zenodo.json`
- [ ] Map author roles to DataCite contributor types
- [ ] Handle related identifiers (data DOIs, software DOIs)
- [ ] Add support for multiple authors with ORCID

**Week 4: Testing and Documentation**
- [ ] Test full workflow: tag → release → DOI
- [ ] Update ct_chile.qmd with enhanced metadata
- [ ] Create author guide: "How to Publish a Chapter"
- [ ] Add DOI badges to chapter HTML
- [ ] Document DOI update workflow (manual step for now)

**Success Criteria**:
- ✅ Chile chapter has working DOI via Zenodo
- ✅ GitHub release auto-generates .zenodo.json
- ✅ Authors can test DOI workflow in staging
- ✅ Documentation covers entire publishing process

---

### Phase 2: Data Catalog Integration (Weeks 5-8)

**Objective**: Register handbook datasets with FAO catalog and STAC systems

**Deliverables**:
1. ✅ STAC catalog for all chapter datasets
2. ✅ FAO Data Catalog API integration
3. ✅ Schema.org metadata in chapter HTML
4. ✅ Automated catalog registration workflows
5. ✅ Data provenance templates for authors

**Technical Tasks**:

**Week 5: STAC Catalog**
- [ ] Create `generate-stac-catalog.py` script (see §2.2.2)
- [ ] Define STAC Item template for chapter data
- [ ] Add STAC extensions: file, scientific, projection, ml-model
- [ ] Generate catalog for existing chapters (ct_chile, ct_digital_earth_africa)
- [ ] Validate STAC with `stac-validator`
- [ ] Host STAC catalog on GitHub Pages

**Week 6: Schema.org Metadata**
- [ ] Add Quarto filter to inject Schema.org into HTML
- [ ] Map chapter frontmatter to Schema.org Dataset type
- [ ] Add structured data for Google Dataset Search
- [ ] Test with Google's Rich Results Test tool

**Week 7: FAO Catalog Integration**
- [ ] Document FAO Data Catalog API
- [ ] Create metadata transformer: frontmatter → FAO schema
- [ ] Build `register-fao-catalog.yml` workflow
- [ ] Test with FAO staging environment
- [ ] Handle API authentication securely

**Week 8: Author Templates**
- [ ] Create `data/<chapter>/README.md` template (see §3.2.2)
- [ ] Create `data/<chapter>/MODEL_CARD.md` template (see §3.2.3)
- [ ] Add validation: check for README before publishing
- [ ] Update author guide with provenance requirements
- [ ] Create example chapter with full metadata

**Success Criteria**:
- ✅ STAC catalog discoverable at fao-eostat.github.io/UN-Handbook/stac/
- ✅ Chile chapter registered in FAO Data Catalog
- ✅ Google Dataset Search indexes chapter data
- ✅ Authors have clear templates for provenance

---

### Phase 3: Enhanced Author Experience (Weeks 9-12)

**Objective**: Streamline author workflows with validation, templates, and guidance

**Deliverables**:
1. ✅ Pre-commit hooks for frontmatter validation
2. ✅ Interactive chapter metadata wizard
3. ✅ Automated quality checks (completeness, links, licenses)
4. ✅ Author training materials (video, workshop)
5. ✅ Example "gold standard" chapter

**Technical Tasks**:

**Week 9: Validation Infrastructure**
- [ ] Create pre-commit hook: validate YAML frontmatter
- [ ] Check required fields: authors, ORCID, abstract, license
- [ ] Validate ORCID format (regex)
- [ ] Check DOI format (if present)
- [ ] Warn if data-snapshot not updated recently
- [ ] Add to repository: `.pre-commit-config.yaml`

**Week 10: Metadata Wizard**
- [ ] Build interactive CLI tool: `scripts/metadata-wizard.py`
- [ ] Prompt for: title, authors, ORCID, keywords, abstract
- [ ] Generate compliant YAML frontmatter
- [ ] Support incremental updates (modify existing .qmd)
- [ ] Add to author guide

**Week 11: Quality Checks**
- [ ] CI workflow: check frontmatter completeness
- [ ] Validate external links (data sources, related works)
- [ ] Check license compatibility (code vs. data)
- [ ] Verify STAC endpoints are reachable
- [ ] Report quality score (0-100) in PR checks

**Week 12: Training and Documentation**
- [ ] Record screencast: "Publishing Your First Chapter"
- [ ] Write blog post: "From Code to Citable Output"
- [ ] Host live workshop: "Author Q&A"
- [ ] Create FAQ document
- [ ] Designate "gold standard" example chapter

**Success Criteria**:
- ✅ Authors receive immediate feedback on metadata quality
- ✅ 80% of required fields auto-suggested by wizard
- ✅ New authors can publish chapter in <2 hours (metadata time)
- ✅ 90% of chapters pass quality checks on first submission

---

### Phase 4: Governance and Documentation (Weeks 13-16)

**Objective**: Establish data governance framework and comprehensive documentation

**Deliverables**:
1. ✅ Data sensitivity assessment workflow
2. ✅ License selection guidance
3. ✅ Ethics review checklist
4. ✅ Comprehensive author handbook (PDF)
5. ✅ Usage analytics dashboard

**Technical Tasks**:

**Week 13: Data Governance**
- [ ] Create sensitivity checklist (see §3.3.1)
- [ ] Add to PR template: "Data Ethics Review"
- [ ] Require sensitivity assessment for chapters with local data
- [ ] Document escalation path (for sensitive data)
- [ ] Create decision tree flowchart

**Week 14: License Guidance**
- [ ] Comprehensive license guide (see §3.3.2)
- [ ] License compatibility matrix
- [ ] Template license statements
- [ ] Add license validation to CI
- [ ] Support mixed licensing (code + data + docs)

**Week 15: Comprehensive Documentation**
- [ ] Compile author handbook (50+ pages)
  - Getting started
  - Publishing checklist
  - Metadata guide
  - Data provenance
  - License selection
  - DOI workflow
  - Troubleshooting
- [ ] Generate PDF with Quarto
- [ ] Publish on handbook website
- [ ] Translate to French, Spanish (optional)

**Week 16: Analytics and Metrics**
- [ ] Track chapter views (Google Analytics)
- [ ] Track "Reproduce" button clicks
- [ ] Monitor Zenodo download stats
- [ ] Display citation counts (Crossref)
- [ ] Build dashboard: handbook-analytics.fao.org

**Success Criteria**:
- ✅ 100% of chapters with local data have sensitivity assessment
- ✅ All chapters have explicit licenses
- ✅ Author handbook available in multiple formats
- ✅ Usage metrics visible to authors and administrators

---

## Part 5: Technical Implementation Examples

### 5.1 Complete Frontmatter Example with All Features

**File**: `chapters/ct_chile.qmd`

```yaml
---
################################################################################
# BASIC METADATA
################################################################################
title: "Crop Type Mapping - Chile: Random Forest Classification of Agricultural Parcels"
subtitle: "A Reproducible Analysis Using Sentinel-2 Imagery and Field-Validated Training Data"
date: "2025-01-15"
date-modified: last-modified

################################################################################
# CITATION METADATA (for DOI minting)
################################################################################
citation:
  type: chapter
  container-title: "UN Handbook on Remote Sensing for Agricultural Statistics"
  doi: "10.5281/zenodo.1234567"  # Auto-updated by CI after Zenodo release
  url: "https://fao-eostat.github.io/UN-Handbook/chapters/ct_chile.html"
  version: "1.0.0"
  date-published: "2025-01-15"
  isbn: "978-92-5-138490-5"  # Handbook ISBN
  publisher: "Food and Agriculture Organization of the United Nations (FAO)"
  publisher-location: "Rome, Italy"
  license: "CC-BY-4.0"

################################################################################
# AUTHORS (with ORCID for citation networks)
################################################################################
authors:
  - name: "María González"
    orcid: "0000-0002-1234-5678"
    email: "maria.gonzalez@minagri.cl"
    affiliation:
      - name: "Chilean Ministry of Agriculture"
        department: "Department of Agricultural Statistics"
        city: "Santiago"
        country: "Chile"
    roles:
      - "conceptualization"
      - "methodology"
      - "software"
      - "validation"
      - "formal analysis"
      - "writing"
    corresponding: true

  - name: "Carlos Silva"
    orcid: "0000-0003-9876-5432"
    email: "carlos.silva@uchile.cl"
    affiliation:
      - name: "University of Chile"
        department: "Department of Computer Science"
        city: "Santiago"
        country: "Chile"
    roles:
      - "data curation"
      - "validation"
      - "visualization"

  - name: "Jean Dupont"
    orcid: "0000-0001-2345-6789"
    email: "jean.dupont@fao.org"
    affiliation:
      - name: "Food and Agriculture Organization (FAO)"
        department: "Statistics Division"
        city: "Rome"
        country: "Italy"
    roles:
      - "supervision"
      - "funding acquisition"

################################################################################
# DISCOVERY METADATA
################################################################################
keywords:
  - "crop type mapping"
  - "Random Forest classification"
  - "Sentinel-2"
  - "agricultural statistics"
  - "Chile"
  - "machine learning"
  - "remote sensing"
  - "reproducible research"

categories:
  - "Crop Type Mapping"
  - "Machine Learning"
  - "Sentinel-2"

# Abstract for discovery (150-200 words)
abstract: |
  This chapter demonstrates operational crop type mapping in Chile's central
  valley using Sentinel-2 satellite imagery and Random Forest classification.
  We classify agricultural parcels into three crop types (wheat, maize,
  vineyard) using 62,920 training points derived from 4,140 field-validated
  polygons. The methodology achieves 92% overall accuracy (Kappa=0.88) with
  F1-scores exceeding 0.89 for all classes. Pre-trained models and complete
  training data are provided for reproducibility. The analysis demonstrates
  a hybrid approach combining local cached artifacts (trained models,
  reference samples) with live STAC queries for Sentinel-2 imagery, enabling
  both exact reproduction of 2023 results and extension to new time periods.
  All code executes in a one-click JupyterLab environment with pre-configured
  dependencies. This methodology has been adopted by Chile's Ministry of
  Agriculture for operational annual crop statistics.

################################################################################
# REPRODUCIBILITY CONFIGURATION
################################################################################
reproducible:
  enabled: true

  # Resource allocation (semantic tier)
  tier: "heavy"  # Translated by Helm chart to: 10 CPU, 48GB RAM, 50GB storage
  estimated-runtime: "45 minutes"

  # Computational artifacts (auto-updated by CI)
  compute-image:
    repository: "ghcr.io/fao-eostat/handbook-base"
    tag: "v1.0.0"
    digest: "sha256:def456abc789..."  # Content hash for exact reproducibility
    flavor: "base"  # or "gpu" for deep learning

  data-snapshot:
    version: "sha256-abc123def456"  # Auto-updated by CI when data/ changes
    size: "57 MB"
    registry: "ghcr.io/fao-eostat/handbook-data"
    full-tag: "ct_chile-sha256-abc123def456"

  # Session configuration
  session:
    auto-cleanup: "2 hours"
    allow-download: true
    network-policy: "egress-restricted"  # Can access STAC, cannot send data out

################################################################################
# DATA SOURCES AND PROVENANCE
################################################################################
data-sources:

  # Local cached data (for reproducibility)
  local:
    - name: "Chile crop classification training samples"
      path: "data/ct_chile/training.rds"
      size: "12 MB"
      records: 62920
      format: "RDS (R Data Serialization)"
      schema-version: "1.0"

      description: |
        Point-based training samples extracted from 4,140 field-validated
        agricultural polygons. Each sample includes Sentinel-2 spectral
        features (all 12 bands), derived indices (NDVI, EVI, NDWI), and
        temporal statistics (mean, std, min, max) for the 2023 growing season.

      provenance:
        source: "Chilean Ministry of Agriculture"
        project: "National Agricultural Census 2023"
        collection-date-start: "2023-03-15"
        collection-date-end: "2023-05-30"
        collection-method: "Field survey with GPS"
        labeling-protocol: |
          Expert agronomists visited parcels during peak growing season.
          Crop type verified through visual inspection and farmer interview.
          Coordinates recorded with handheld GPS (±3m accuracy).
        quality-assurance: |
          Cross-validation with 10% farmer callbacks. Independent verification
          by second surveyor for ambiguous cases. Spatial cross-validation
          to assess label quality.
        processing-steps:
          - "Coordinate transformation: EPSG:32719 → EPSG:4326"
          - "Removal of invalid geometries (<0.1 ha parcels)"
          - "Stratified sampling to balance classes (500 points per polygon)"
          - "Feature extraction from Sentinel-2 time series via STAC"
        processing-date: "2023-06-10"
        processing-code: "scripts/process-training-data.R"

      license: "CC-BY-4.0"
      attribution: "Chilean Ministry of Agriculture (2023)"
      citation: |
        González, M., Silva, C. (2023). Chile Crop Classification Training
        Samples (Version 1.0) [Data set]. Chilean Ministry of Agriculture.
        https://doi.org/10.5281/zenodo.1234568

      related-identifiers:
        - type: "IsDerivedFrom"
          identifier: "10.5281/zenodo.1234569"
          description: "Raw field survey data (polygons)"

    - name: "Pre-trained Random Forest model"
      path: "data/ct_chile/rf_model.rds"
      size: "8 MB"
      format: "RDS (ranger model object)"

      description: |
        Random Forest classifier trained on 2023 Sentinel-2 features for
        three-class crop type prediction (wheat, maize, vineyard).

      provenance:
        training-date: "2023-06-15"
        training-duration: "42 minutes"
        training-hardware: "10 CPU, 48GB RAM"
        validation-method: "5-fold spatial cross-validation"

        hyperparameters:
          algorithm: "ranger (R implementation of Random Forest)"
          num_trees: 500
          mtry: 3
          min_node_size: 5
          max_depth: null
          sample_fraction: 0.632
          importance_mode: "impurity"

        features:
          input_bands: ["B02", "B03", "B04", "B05", "B06", "B07", "B08", "B8A", "B11", "B12"]
          derived_indices: ["NDVI", "EVI", "NDWI", "SAVI"]
          temporal_statistics: ["mean", "std", "min", "max"]
          total_features: 56

        performance:
          overall_accuracy: 0.92
          kappa: 0.88
          macro_f1: 0.91

          per_class:
            wheat:
              precision: 0.93
              recall: 0.89
              f1: 0.91
              support: 18876
            maize:
              precision: 0.87
              recall: 0.91
              f1: 0.89
              support: 22022
            vineyard:
              precision: 0.95
              recall: 0.93
              f1: 0.94
              support: 22022

      license: "MIT"

      related-identifiers:
        - type: "IsCompiledFrom"
          identifier: "https://github.com/imbs-hl/ranger"
          description: "ranger R package (v0.16.0)"

  # Cloud data (for live queries)
  cloud:
    - name: "Sentinel-2 Level-2A Surface Reflectance"
      stac-endpoint: "https://earth-search.aws.element84.com/v1"
      collection: "sentinel-2-l2a"

      spatial-extent:
        bbox: [-71.5, -33.5, -70.5, -32.5]
        description: "Central Valley, Chile (O'Higgins and Maule regions)"
        epsg: 4326

      temporal-extent:
        start: "2023-01-01"
        end: "2023-12-31"
        description: "Full 2023 growing season"

      bands-used:
        - "B02 (Blue, 10m)"
        - "B03 (Green, 10m)"
        - "B04 (Red, 10m)"
        - "B08 (NIR, 10m)"
        - "B11 (SWIR1, 20m)"
        - "B12 (SWIR2, 20m)"

      access: "Public (AWS Open Data, no authentication required)"
      access-method: "STAC API queries via {rstac} R package"

      license: "CC-BY-SA-3.0-IGO (Copernicus Sentinel Data)"
      attribution: "European Space Agency (ESA) / Copernicus Programme"
      citation: |
        European Space Agency (2023). Sentinel-2 Level-2A Surface Reflectance.
        Accessed via AWS Open Data: https://registry.opendata.aws/sentinel-2/

      related-identifiers:
        - type: "IsDocumentedBy"
          identifier: "https://sentinels.copernicus.eu/web/sentinel/user-guides/sentinel-2-msi/document-library"
          description: "Sentinel-2 User Handbook"

################################################################################
# RELATED RESOURCES
################################################################################
related:
  - type: "dataset"
    relation: "IsSupplementTo"
    description: "Training data archived on Zenodo"
    identifier: "10.5281/zenodo.1234568"
    url: "https://doi.org/10.5281/zenodo.1234568"

  - type: "software"
    relation: "Uses"
    description: "sits: Satellite Image Time Series Analysis in R"
    identifier: "10.18637/jss.v099.i05"
    url: "https://github.com/e-sensing/sits"
    citation: "Simoes et al. (2021). sits: Satellite Image Time Series Analysis. Journal of Statistical Software, 99(5), 1-44."

  - type: "publication"
    relation: "IsCitedBy"
    description: "Chilean National Agricultural Statistics Report 2023"
    url: "https://www.minagri.gob.cl/estadisticas-2023"

  - type: "documentation"
    relation: "IsDocumentedBy"
    description: "Random Forest algorithm overview"
    url: "https://doi.org/10.1023/A:1010933404324"
    citation: "Breiman, L. (2001). Random forests. Machine Learning, 45(1), 5-32."

################################################################################
# DATA GOVERNANCE AND ETHICS
################################################################################
data-governance:

  sensitivity-assessment:
    level: "Public"
    reviewed-by: "María González"
    review-date: "2024-12-20"

    privacy:
      contains-pii: false
      re-identification-risk: "Low"
      rationale: |
        Data aggregated to parcel level (>0.5 hectare). No farmer names or
        contact information. Geographic precision sufficient for agricultural
        statistics but not individual surveillance.

    commercial:
      competitive-sensitivity: "Low"
      rationale: |
        Crop types are observable from space and reported in national
        statistics. No proprietary farming practices or yield data included.

    security:
      national-security-risk: "None"
      infrastructure-exposure: false
      rationale: "Agricultural parcels only, no critical infrastructure"

  ethical-approval:
    required: false
    rationale: "Publicly available agricultural statistics, no human subjects research"
    institutional-review: "Not applicable"

  data-sharing:
    restrictions: "None"
    embargo-period: null
    geographic-restrictions: false
    user-agreement-required: false

  intended-use:
    - "Academic research on crop monitoring methodologies"
    - "Training machine learning models for agriculture"
    - "Validation of satellite-based crop classification techniques"
    - "Educational coursework in remote sensing"
    - "Operational agricultural statistics by government agencies"

  prohibited-use:
    - "Individual farmer profiling or surveillance"
    - "Precision agriculture services without farmer consent"
    - "High-frequency trading based on crop predictions"
    - "Any use inconsistent with original collection purpose"

################################################################################
# LICENSES (explicit per component)
################################################################################
licenses:
  code:
    type: "MIT"
    url: "https://opensource.org/licenses/MIT"
    holder: "María González, Carlos Silva"
    year: 2025

  documentation:
    type: "CC-BY-4.0"
    url: "https://creativecommons.org/licenses/by/4.0/"
    holder: "Food and Agriculture Organization of the United Nations (FAO)"
    year: 2025

  data:
    training-samples:
      type: "CC-BY-4.0"
      url: "https://creativecommons.org/licenses/by/4.0/"
      holder: "Chilean Ministry of Agriculture"
      year: 2023
      attribution-text: "Chilean Ministry of Agriculture (2023). Crop Survey Data."

    model:
      type: "MIT"
      url: "https://opensource.org/licenses/MIT"
      holder: "María González, Carlos Silva"
      year: 2025

    sentinel-imagery:
      type: "CC-BY-SA-3.0-IGO"
      url: "https://creativecommons.org/licenses/by-sa/3.0/igo/"
      holder: "European Space Agency / Copernicus Programme"
      attribution-text: "Copernicus Sentinel data [Year]"

################################################################################
# VERSION HISTORY
################################################################################
changelog:
  - version: "1.0.0"
    date: "2025-01-15"
    doi: "10.5281/zenodo.1234567"
    changes:
      - "Initial release with 2023 training data and model"
      - "Achieved 92% overall accuracy on validation set"
    authors: ["María González", "Carlos Silva"]

  - version: "0.9.0"
    date: "2024-12-01"
    doi: null
    changes:
      - "Beta release for peer review"
      - "Preliminary results with 10-fold cross-validation"
    authors: ["María González"]

################################################################################
# TECHNICAL METADATA (for rendering)
################################################################################
format:
  html:
    toc: true
    toc-depth: 3
    code-fold: false
    code-tools: true
    code-link: true
    df-print: paged

    # Schema.org metadata for Google Dataset Search
    include-in-header:
      text: |
        <script type="application/ld+json">
        {
          "@context": "https://schema.org/",
          "@type": "Dataset",
          "name": "Chile Crop Classification Training Samples",
          "description": "62,920 training points for crop type mapping in Chile",
          "url": "https://fao-eostat.github.io/UN-Handbook/chapters/ct_chile.html",
          "identifier": "https://doi.org/10.5281/zenodo.1234568",
          "keywords": ["crop classification", "Sentinel-2", "Random Forest", "Chile"],
          "license": "https://creativecommons.org/licenses/by/4.0/",
          "creator": [
            {
              "@type": "Person",
              "name": "María González",
              "@id": "https://orcid.org/0000-0002-1234-5678"
            }
          ],
          "spatialCoverage": {
            "@type": "Place",
            "geo": {
              "@type": "GeoShape",
              "box": "-33.5 -71.5 -32.5 -70.5"
            }
          },
          "temporalCoverage": "2023-01-01/2023-12-31"
        }
        </script>

execute:
  eval: true
  echo: true
  warning: false
  message: false
  cache: false  # Reproducibility via immutable environment, not cache

---
```

### 5.2 Validation Workflow

**Pre-Commit Hook** (`.pre-commit-config.yaml`):

```yaml
repos:
  - repo: local
    hooks:
      - id: validate-chapter-metadata
        name: Validate Chapter Frontmatter
        entry: python scripts/validate-metadata.py
        language: python
        files: ^chapters/.*\.qmd$
        additional_dependencies:
          - pyyaml
          - jsonschema
```

**Validation Script** (`scripts/validate-metadata.py`):

```python
#!/usr/bin/env python3
"""Validate chapter YAML frontmatter against schema."""

import sys
import yaml
import json
from pathlib import Path
from jsonschema import validate, ValidationError
import re

# JSON Schema for chapter metadata
SCHEMA = {
    "$schema": "http://json-schema.org/draft-07/schema#",
    "type": "object",
    "required": ["title", "citation", "authors", "abstract", "keywords", "reproducible"],
    "properties": {
        "citation": {
            "type": "object",
            "required": ["type", "version", "license"],
            "properties": {
                "type": {"enum": ["chapter", "article", "software"]},
                "doi": {"type": ["string", "null"], "pattern": "^10\\.\\d{4,}/.*$"},
                "version": {"type": "string", "pattern": "^\\d+\\.\\d+\\.\\d+$"},
                "license": {"enum": ["CC-BY-4.0", "CC-BY-SA-4.0", "CC0-1.0", "MIT"]}
            }
        },
        "authors": {
            "type": "array",
            "minItems": 1,
            "items": {
                "type": "object",
                "required": ["name", "orcid"],
                "properties": {
                    "name": {"type": "string", "minLength": 3},
                    "orcid": {"type": "string", "pattern": "^\\d{4}-\\d{4}-\\d{4}-\\d{3}[0-9X]$"},
                    "email": {"type": "string", "format": "email"}
                }
            }
        },
        "abstract": {
            "type": "string",
            "minLength": 100,
            "maxLength": 600
        },
        "keywords": {
            "type": "array",
            "minItems": 3,
            "maxItems": 10,
            "items": {"type": "string"}
        },
        "reproducible": {
            "type": "object",
            "required": ["enabled"],
            "properties": {
                "enabled": {"type": "boolean"},
                "tier": {"enum": ["light", "medium", "heavy", "gpu"]}
            }
        }
    }
}

def extract_frontmatter(qmd_file):
    """Extract YAML frontmatter from .qmd file."""
    with open(qmd_file, 'r', encoding='utf-8') as f:
        content = f.read()

    parts = content.split('---')
    if len(parts) < 3:
        raise ValueError("No YAML frontmatter found (missing --- delimiters)")

    return yaml.safe_load(parts[1])

def validate_metadata(qmd_file):
    """Validate chapter metadata against schema."""
    errors = []
    warnings = []

    try:
        metadata = extract_frontmatter(qmd_file)
    except Exception as e:
        print(f"❌ {qmd_file}: Failed to parse YAML: {e}")
        return False

    # Schema validation
    try:
        validate(instance=metadata, schema=SCHEMA)
        print(f"✅ {qmd_file}: Schema validation passed")
    except ValidationError as e:
        errors.append(f"Schema validation failed: {e.message}")

    # Additional checks

    # Check DOI format if present
    if metadata.get('citation', {}).get('doi'):
        doi = metadata['citation']['doi']
        if not re.match(r'^10\.\d{4,}/.*$', doi):
            errors.append(f"Invalid DOI format: {doi}")
        else:
            warnings.append(f"DOI present: {doi} (verify it resolves)")
    else:
        if metadata.get('reproducible', {}).get('enabled'):
            warnings.append("No DOI yet (will be added after Zenodo release)")

    # Check ORCID format for all authors
    for i, author in enumerate(metadata.get('authors', [])):
        orcid = author.get('orcid')
        if not orcid:
            errors.append(f"Author {i+1} ({author.get('name')}) missing ORCID")
        elif not re.match(r'^\d{4}-\d{4}-\d{4}-\d{3}[0-9X]$', orcid):
            errors.append(f"Author {i+1} ({author.get('name')}) has invalid ORCID format: {orcid}")

    # Check abstract length
    abstract = metadata.get('abstract', '')
    if len(abstract) < 100:
        errors.append(f"Abstract too short ({len(abstract)} chars, minimum 100)")
    elif len(abstract) > 600:
        warnings.append(f"Abstract quite long ({len(abstract)} chars, recommended <500)")

    # Check for data provenance if local data
    if metadata.get('data-sources', {}).get('local'):
        for ds in metadata['data-sources']['local']:
            if 'provenance' not in ds:
                errors.append(f"Local data source '{ds.get('name')}' missing provenance")
            if 'license' not in ds:
                errors.append(f"Local data source '{ds.get('name')}' missing license")

    # Check for reproducible configuration completeness
    if metadata.get('reproducible', {}).get('enabled'):
        repro = metadata['reproducible']
        if 'tier' not in repro:
            warnings.append("No resource tier specified (will default to 'medium')")
        if 'estimated-runtime' not in repro:
            warnings.append("No estimated runtime specified")

    # Report results
    if errors:
        print(f"\n❌ {qmd_file}: Validation FAILED")
        for error in errors:
            print(f"   ERROR: {error}")

    if warnings:
        print(f"\n⚠️  {qmd_file}: Warnings")
        for warning in warnings:
            print(f"   WARN: {warning}")

    if not errors and not warnings:
        print(f"✅ {qmd_file}: All checks passed!")

    return len(errors) == 0

def main():
    """Validate all specified .qmd files."""
    if len(sys.argv) < 2:
        print("Usage: validate-metadata.py <file1.qmd> [file2.qmd ...]")
        sys.exit(1)

    all_valid = True
    for qmd_file in sys.argv[1:]:
        if not validate_metadata(qmd_file):
            all_valid = False

    sys.exit(0 if all_valid else 1)

if __name__ == '__main__':
    main()
```

**Usage**:
```bash
# Manual validation
python scripts/validate-metadata.py chapters/ct_chile.qmd

# Pre-commit hook (automatic)
git add chapters/ct_chile.qmd
git commit -m "docs: update Chile chapter metadata"
# → validation runs automatically, blocks commit if errors
```

---

## Conclusion

This vision document outlines a comprehensive upgrade to the UN Handbook reproducibility system, transforming it from technical infrastructure into a full scholarly publishing platform. The phased roadmap provides a clear path from current state (v1.0) to enhanced vision (v2.0) over 16 weeks.

**Key Achievements**:
- ✅ DOI-based citability via Zenodo integration
- ✅ Data catalog registration for discoverability
- ✅ Research compendium framework for structured outputs
- ✅ Enhanced author guidance with templates and validation
- ✅ Data governance and ethics framework
- ✅ Alignment with open science best practices (FAIR, RAP, Turing Way)

**Next Steps**:
1. Review and approve this proposal with stakeholders
2. Allocate resources for 16-week implementation
3. Begin Phase 1: Citation Infrastructure
4. Pilot with Chile chapter (ct_chile.qmd)
5. Iterate based on author feedback

**Long-Term Impact**:
- Authors receive scholarly credit for computational contributions
- Chapters are discoverable via multiple channels (Google Dataset Search, FAO catalogs, Zenodo)
- Reproducibility becomes a publishing standard, not an afterthought
- The handbook serves as an exemplar for open science in agricultural statistics

---

**Document Version**: 1.0
**Status**: Draft for Review
**Feedback**: Please submit comments via GitHub Issues or email un-handbook@fao.org
