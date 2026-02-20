# Cursor Extension Recommendations by Role

## (A) Academic Researcher

Data analysis, paper writing, reproducible workflows, HPC.

### Core (must-install)

| Extension ID | What it does |
|---|---|
| `ms-python.python` | Python language support |
| `ms-python.isort` | Auto-sort Python imports |
| `ms-toolsai.jupyter` | Jupyter notebook support |
| `reditorsupport.r` | R language support |
| `kylebarron.stata-enhanced` | Stata syntax + runner |
| `james-yu.latex-workshop` | Write/compile LaTeX papers |
| `quarto.quarto` | Quarto documents (modern R Markdown) |
| `shd101wyy.markdown-preview-enhanced` | Rich markdown preview |
| `ms-vscode-remote.remote-ssh` | Connect to HPC clusters |

### Data handling

| Extension ID | What it does |
|---|---|
| `mechatroner.rainbow-csv` | Color-coded CSV columns |
| `grapecity.gc-excelviewer` | View Excel/CSV as spreadsheet |
| `mohsen1.prettify-json` | Format messy JSON |
| `redhat.vscode-yaml` | YAML validation (Snakemake, CI configs) |

### Writing & quality of life

| Extension ID | What it does |
|---|---|
| `streetsidesoftware.code-spell-checker` | Catch typos in papers/code comments |
| `tomoki1207.pdf` | View PDFs inside editor |
| `eamodio.gitlens` | Git history, blame, file changes |
| `usernamehsu.errorlens` | Show errors inline next to code |
| `christian-kohler.path-intellisense` | Autocomplete file paths |
| `pkief.material-icon-theme` | Visual file type icons |

### Install all at once

```bash
cursor \
  --install-extension ms-python.python \
  --install-extension ms-python.isort \
  --install-extension ms-toolsai.jupyter \
  --install-extension reditorsupport.r \
  --install-extension kylebarron.stata-enhanced \
  --install-extension james-yu.latex-workshop \
  --install-extension quarto.quarto \
  --install-extension shd101wyy.markdown-preview-enhanced \
  --install-extension ms-vscode-remote.remote-ssh \
  --install-extension mechatroner.rainbow-csv \
  --install-extension grapecity.gc-excelviewer \
  --install-extension mohsen1.prettify-json \
  --install-extension redhat.vscode-yaml \
  --install-extension streetsidesoftware.code-spell-checker \
  --install-extension tomoki1207.pdf \
  --install-extension eamodio.gitlens \
  --install-extension usernamehsu.errorlens \
  --install-extension christian-kohler.path-intellisense \
  --install-extension pkief.material-icon-theme
```

---

## (B) Product Manager

Specs/PRDs, GitHub issues/PRs, diagrams, reading (not writing) code.

### Core (must-install)

| Extension ID | What it does |
|---|---|
| `shd101wyy.markdown-preview-enhanced` | Rich markdown preview for PRDs/specs |
| `github.vscode-pull-request-github` | Review PRs, comment on code, manage issues |
| `eamodio.gitlens` | Understand who changed what and when |
| `streetsidesoftware.code-spell-checker` | Catch typos in docs |

### Diagrams & visuals

| Extension ID | What it does |
|---|---|
| `bierner.markdown-mermaid` | Render Mermaid flowcharts/sequence diagrams in markdown |
| `hediet.vscode-drawio` | Draw.io diagrams inside editor (architecture, flows) |

### Data & config review

| Extension ID | What it does |
|---|---|
| `mohsen1.prettify-json` | Format API responses / config files |
| `mechatroner.rainbow-csv` | Read CSVs without opening Excel |
| `redhat.vscode-yaml` | Read CI/CD and config files |

### Quality of life

| Extension ID | What it does |
|---|---|
| `alefragnani.project-manager` | Switch between repos quickly |
| `usernamehsu.errorlens` | See issues inline when reading code |
| `pkief.material-icon-theme` | Visual file type icons |
| `oderwat.indent-rainbow` | See code structure through indentation colors |

### Install all at once

```bash
cursor \
  --install-extension shd101wyy.markdown-preview-enhanced \
  --install-extension github.vscode-pull-request-github \
  --install-extension eamodio.gitlens \
  --install-extension streetsidesoftware.code-spell-checker \
  --install-extension bierner.markdown-mermaid \
  --install-extension hediet.vscode-drawio \
  --install-extension mohsen1.prettify-json \
  --install-extension mechatroner.rainbow-csv \
  --install-extension redhat.vscode-yaml \
  --install-extension alefragnani.project-manager \
  --install-extension usernamehsu.errorlens \
  --install-extension pkief.material-icon-theme \
  --install-extension oderwat.indent-rainbow
```

---

## Overlap (both roles benefit)

| Extension ID | Why universal |
|---|---|
| `eamodio.gitlens` | Everyone needs git history |
| `streetsidesoftware.code-spell-checker` | Everyone writes text |
| `shd101wyy.markdown-preview-enhanced` | Everyone reads/writes markdown |
| `usernamehsu.errorlens` | Everyone benefits from inline feedback |
| `pkief.material-icon-theme` | Everyone benefits from visual clarity |
