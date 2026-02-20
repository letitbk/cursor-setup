# Claude Code + Cursor Setup for E-commerce Product Managers

AI-executable setup guide. An LLM agent can clone this repo and run the install script to configure a complete PM workstation with Claude Code CLI + Cursor.

**Target user:** Non-technical Product Manager in e-commerce. Korean + English bilingual. Uses Figma + MS Office 365.

**What this installs:** 17-20 Cursor extensions, 10 Claude Code plugins, 24 custom skills, 7 custom agents, 5 slash commands, 1 hook, global CLAUDE.md instructions, and multi-AI tools (Gemini CLI + Codex CLI).

---

## Quick Start

```bash
# 1. Clone the repo
git clone https://github.com/bklee/claude-setup.git
cd claude-setup

# 2. Run the install script
bash install.sh
```

Or follow the manual steps below.

---

## Table of Contents

1. [Prerequisites](#1-prerequisites)
2. [Cursor Extensions](#2-cursor-extensions)
3. [Claude Code Settings & Plugins](#3-claude-code-settings--plugins)
4. [Skills, Agents, Commands & Hook](#4-skills-agents-commands--hook)
5. [Global Instructions (CLAUDE.md)](#5-global-instructions-claudemd)
6. [Multi-AI Setup](#6-multi-ai-setup)
7. [Verification](#7-verification)

---

## 1. Prerequisites

```bash
which cursor && which claude && which node && which python3 && which jq
```

- If `cursor` is not in PATH: open Cursor, run **Shell Command: Install 'cursor' command in PATH** from command palette (`Cmd+Shift+P`).
- If `claude` is missing: `npm install -g @anthropic-ai/claude-code`
- If `jq` is missing: `brew install jq` (required by the PRD completeness hook)

---

## 2. Cursor Extensions

Install PM-relevant extensions (17 core + 3 optional):

```bash
# Core extensions (verified on Cursor's Open VSX registry)
cursor --install-extension anthropic.claude-code \
  && cursor --install-extension google.gemini-cli-vscode-ide-companion \
  && cursor --install-extension openai.chatgpt \
  && cursor --install-extension shd101wyy.markdown-preview-enhanced \
  && cursor --install-extension bierner.markdown-mermaid \
  && cursor --install-extension hediet.vscode-drawio \
  && cursor --install-extension mechatroner.rainbow-csv \
  && cursor --install-extension grapecity.gc-excelviewer \
  && cursor --install-extension redhat.vscode-yaml \
  && cursor --install-extension cweijan.vscode-office \
  && cursor --install-extension eamodio.gitlens \
  && cursor --install-extension streetsidesoftware.code-spell-checker \
  && cursor --install-extension usernamehw.errorlens \
  && cursor --install-extension oderwat.indent-rainbow \
  && cursor --install-extension alefragnani.project-manager \
  && cursor --install-extension pkief.material-icon-theme \
  && cursor --install-extension ms-ceintl.vscode-language-pack-ko

# Optional (may need manual VSIX install from VS Code Marketplace)
cursor --install-extension ms-python.python
cursor --install-extension ms-toolsai.jupyter
cursor --install-extension figma.figma-vscode-extension
```

> **Note:** `github.copilot` is not needed — Cursor has built-in AI assistance. `mohsen1.prettify-json` is removed — Cursor has built-in JSON formatting. The 3 optional extensions are VS Code Marketplace exclusives that may require downloading the `.vsix` file manually from [marketplace.visualstudio.com](https://marketplace.visualstudio.com) and installing via `cursor --install-extension path/to/file.vsix`.

| Group | Extensions | Purpose |
|-------|-----------|---------|
| AI Copilots (3) | claude-code, gemini, chatgpt | Multi-AI assistance |
| Markdown/PRD (2) | markdown-preview-enhanced, markdown-mermaid | PRD authoring with diagrams |
| Diagrams (1) | vscode-drawio | Flow diagrams and wireframes |
| Figma (1) | figma-vscode-extension *(optional)* | Design integration |
| Data (3) | rainbow-csv, gc-excelviewer, vscode-yaml | Data file handling |
| Office (1) | vscode-office | MS Office file preview |
| Python/Data (2) | python, jupyter *(optional)* | Data analysis notebooks |
| QoL (6) | gitlens, spell-checker, errorlens, indent-rainbow, project-manager, material-icon-theme | Editor quality of life |
| Korean (1) | vscode-language-pack-ko | Korean language support |

---

## 3. Claude Code Settings & Plugins

### Copy settings

```bash
# Backup existing settings
[ -f ~/.claude/settings.json ] && cp ~/.claude/settings.json ~/.claude/settings.json.backup.$(date +%Y%m%d)

# Copy PM settings
cp settings.json ~/.claude/settings.json
```

The [settings.json](settings.json) configures:
- **Permissions:** Read/Edit/Write, git, python, npm/npx, open — with deny rules blocking secrets, sudo, force-push
- **Hooks:** PRD completeness checker (Stop), JSON syntax validator (PostToolUse)
- **10 plugins** (see below)
- **Mode:** `acceptEdits` with `alwaysThinkingEnabled`

### Install plugins

Run these inside Claude Code CLI:

```
/plugin install superpowers@obra
/plugin install context7@claude-plugins-official
/plugin install figma@claude-plugins-official
/plugin install playwright@claude-plugins-official
/plugin install frontend-design@claude-code-plugins
/plugin install plannotator@plannotator
/plugin install feature-dev@claude-plugins-official
/plugin install github@claude-plugins-official
/plugin install ralph-loop@claude-plugins-official
/plugin install claude-notifications-go@claude-notifications-go
```

| Plugin | Purpose |
|--------|---------|
| **superpowers** | Core workflow: brainstorming, TDD, planning, git worktrees |
| **context7** | Library documentation lookup via MCP |
| **figma** | Figma design integration via MCP |
| **playwright** | Browser automation via MCP |
| **frontend-design** | UI/design quality review |
| **plannotator** | Visual planning and annotation |
| **feature-dev** | Feature development workflow |
| **github** | GitHub API integration |
| **ralph-loop** | Development loop automation |
| **claude-notifications-go** | Desktop notifications when tasks complete |

---

## 4. Skills, Agents, Commands & Hook

### Copy all files to Claude Code

```bash
# Skills (24 total)
mkdir -p ~/.claude/skills
cp -r skills/* ~/.claude/skills/

# Agents (7 total)
mkdir -p ~/.claude/agents
cp agents/*.md ~/.claude/agents/

# Commands (5 total)
mkdir -p ~/.claude/commands
cp commands/*.md ~/.claude/commands/

# Hook (1 total)
mkdir -p ~/.claude/hooks
cp hooks/check-prd-completeness.sh ~/.claude/hooks/
chmod +x ~/.claude/hooks/check-prd-completeness.sh
```

### Skills (24)

#### PM-specific skills (9 custom)

| Skill | Purpose | Key tools |
|-------|---------|-----------|
| [prd-writer](skills/prd-writer/SKILL.md) | Draft structured PRDs | AskUserQuestion, Korean support |
| [ecommerce-analyst](skills/ecommerce-analyst/SKILL.md) | Analyze CSV/Excel metrics | pandas, plotnine, scipy.stats |
| [stakeholder-update](skills/stakeholder-update/SKILL.md) | Status reports, exec summaries | 4 templates |
| [user-story-writer](skills/user-story-writer/SKILL.md) | User stories with acceptance criteria | Persona library, sizing |
| [competitive-analysis](skills/competitive-analysis/SKILL.md) | Research competitors | WebSearch, Gemini, Playwright |
| [website-analyzer](skills/website-analyzer/SKILL.md) | Deep e-commerce site analysis | Playwright, beautifulsoup4, advertools |
| [ux-design-brainstorm](skills/ux-design-brainstorm/SKILL.md) | UX patterns & wireframes | Baymard, Mermaid, ASCII |
| [python-viz](skills/python-viz/SKILL.md) | E-commerce chart templates | plotnine (primary), plotly |
| [site-to-skill](skills/site-to-skill/SKILL.md) | Auto-generate audit skills from websites | Playwright, CSS selectors |

#### Utility skills (15 general-purpose)

| Skill | Purpose |
|-------|---------|
| [brainstorming](skills/brainstorming/SKILL.md) | Structured creative ideation before any work |
| [catch-up](skills/catch-up/SKILL.md) | Resume context after time away |
| [doc](skills/doc/SKILL.md) | Create/edit .docx Word documents |
| [pdf](skills/pdf/SKILL.md) | Read, create, review PDF files |
| [marp-slide](skills/marp-slide/SKILL.md) | Create Marp presentations with 7 themes |
| [imagegen](skills/imagegen/SKILL.md) | Generate images via OpenAI API |
| [gemini](skills/gemini/SKILL.md) | Web search + URL analysis via Gemini CLI |
| [codex](skills/codex/SKILL.md) | Code review + second opinions via Codex CLI |
| [humanizer](skills/humanizer/SKILL.md) | Remove AI writing patterns from text |
| [stop-slop](skills/stop-slop/SKILL.md) | Quality control for AI-generated text |
| [screenshot](skills/screenshot/SKILL.md) | Capture desktop/app screenshots |
| [figma](skills/figma/SKILL.md) | Figma design context and screenshots |
| [playwright](skills/playwright/SKILL.md) | Browser automation from terminal |
| [datacheck](skills/datacheck/SKILL.md) | Validate data files (CSV/Excel/JSON) |
| [skill-creator](skills/skill-creator/SKILL.md) | Create new custom skills interactively |

### Agents (7)

| Agent | Purpose |
|-------|---------|
| [product-strategist](agents/product-strategist.md) | Roadmap prioritization (RICE, Kano, JTBD), OKR setting |
| [data-analyst](agents/data-analyst.md) | Business metrics, A/B test evaluation, Python/pandas |
| [prd-reviewer](agents/prd-reviewer.md) | PRD completeness, clarity, feasibility review |
| [presentation-builder](agents/presentation-builder.md) | Business presentations using Marp |
| [ux-researcher](agents/ux-researcher.md) | Research synthesis, personas, journey maps, heuristics |
| [ecommerce-domain-expert](agents/ecommerce-domain-expert.md) | E-commerce concepts in plain language |
| [korean-english-translator](agents/korean-english-translator.md) | Korean <> English with e-commerce terminology |

### Commands (5)

| Command | Invocation | Purpose |
|---------|-----------|---------|
| [prd](commands/prd.md) | `/prd [topic]` | Draft a PRD with brainstorming |
| [metrics](commands/metrics.md) | `/metrics [file]` | Analyze e-commerce data file |
| [deck](commands/deck.md) | `/deck [topic]` | Create a Marp presentation |
| [search-prompts](commands/search-prompts.md) | `/search-prompts [query]` | Search conversation history |
| [page](commands/page.md) | `/page` | Dump session to disk before /compact |

### Hook

| Hook | Trigger | Purpose |
|------|---------|---------|
| [check-prd-completeness.sh](hooks/check-prd-completeness.sh) | Stop (after response) | Validates PRD files have required sections |

---

## 5. Global Instructions (CLAUDE.md)

```bash
cp CLAUDE.md ~/.claude/CLAUDE.md
```

The [CLAUDE.md](CLAUDE.md) sets behavioral guidelines:
1. **Think Before Acting** — Surface tradeoffs, ask when uncertain
2. **Simplicity First** — Minimum output, no filler
3. **Surgical Changes** — Match existing style
4. **Goal-Driven Execution** — Define success criteria, loop until verified
5. **Data Handling** — Check encoding, confirm columns before analysis
6. **Visualization** — plotnine primary, plotly for interactive
7. **Communication** — Lead with bottom line, bold key takeaways
8. **Language** — Korean input accepted, English output for official documents

---

## 6. Multi-AI Setup

### Gemini CLI (web search + image analysis)

```bash
npm install -g @google/gemini-cli
gemini  # authenticate via Google account
```

### Codex CLI (code review + second opinions)

```bash
npm install -g @openai/codex
codex   # authenticate via OpenAI account
```

### Python packages

```bash
pip3 install pandas plotnine plotly kaleido matplotlib scipy openpyxl beautifulsoup4 advertools Pillow
```

### Playwright (website analysis)

```bash
pip3 install playwright && python3 -m playwright install chromium
```

---

## 7. Verification

```bash
echo "=== Claude Code PM Setup Verification ==="
echo ""

EXT_COUNT=$(cursor --list-extensions 2>/dev/null | wc -l | tr -d ' ')
echo "1. Cursor extensions: $EXT_COUNT (expected: >= 22)"

if python3 -c "import json; json.load(open('$HOME/.claude/settings.json'))" 2>/dev/null; then
    PLUGIN_COUNT=$(python3 -c "import json; d=json.load(open('$HOME/.claude/settings.json')); print(len(d.get('enabledPlugins', {})))")
    echo "2. Settings.json: valid, $PLUGIN_COUNT plugins (expected: 10)"
else
    echo "2. Settings.json: INVALID or missing"
fi

echo "3. Skills: $(ls -d ~/.claude/skills/*/ 2>/dev/null | wc -l | tr -d ' ') (expected: 24)"
echo "4. Agents: $(ls ~/.claude/agents/*.md 2>/dev/null | wc -l | tr -d ' ') (expected: 7)"
echo "5. Commands: $(ls ~/.claude/commands/*.md 2>/dev/null | wc -l | tr -d ' ') (expected: 5)"

test -x ~/.claude/hooks/check-prd-completeness.sh \
  && echo "6. Hook: executable" \
  || echo "6. Hook: MISSING"

test -f ~/.claude/CLAUDE.md \
  && echo "7. CLAUDE.md: present" \
  || echo "7. CLAUDE.md: MISSING"

which gemini > /dev/null 2>&1 \
  && echo "8. Gemini CLI: installed" \
  || echo "8. Gemini CLI: NOT INSTALLED"

which codex > /dev/null 2>&1 \
  && echo "9. Codex CLI: installed" \
  || echo "9. Codex CLI: NOT INSTALLED"

python3 -c "import plotnine; import plotly; import advertools" 2>/dev/null \
  && echo "10. Python packages: OK" \
  || echo "10. Python packages: SOME MISSING"

echo ""
echo "=== Done ==="
```

### Expected output

```
1. Cursor extensions: 17+ (expected: 17 core, up to 20 with optional)
2. Settings.json: valid, 10 plugins (expected: 10)
3. Skills: 24 (expected: 24)
4. Agents: 7 (expected: 7)
5. Commands: 5 (expected: 5)
6. Hook: executable
7. CLAUDE.md: present
8. Gemini CLI: installed
9. Codex CLI: installed
10. Python packages: OK
```

---

## Repo Structure

```
claude-setup/
├── README.md                           # This file (install guide)
├── install.sh                          # Automated install script
├── settings.json                       # Claude Code settings
├── CLAUDE.md                           # Global instructions
├── skills/                             # 24 skills
│   ├── prd-writer/SKILL.md             #   PM: PRD drafting
│   ├── ecommerce-analyst/SKILL.md      #   PM: Metrics analysis
│   ├── stakeholder-update/SKILL.md     #   PM: Status reports
│   ├── user-story-writer/SKILL.md      #   PM: User stories
│   ├── competitive-analysis/SKILL.md   #   PM: Competitor research
│   ├── website-analyzer/SKILL.md       #   PM: Site audits
│   ├── ux-design-brainstorm/SKILL.md   #   PM: UX patterns
│   ├── python-viz/SKILL.md             #   PM: Chart templates
│   ├── site-to-skill/SKILL.md          #   PM: Auto-generate audit skills
│   ├── brainstorming/SKILL.md          #   Utility: Creative ideation
│   ├── catch-up/SKILL.md               #   Utility: Resume context
│   ├── doc/SKILL.md                    #   Utility: Word documents
│   ├── pdf/SKILL.md                    #   Utility: PDF handling
│   ├── marp-slide/SKILL.md             #   Utility: Presentations
│   ├── imagegen/SKILL.md               #   Utility: Image generation
│   ├── gemini/SKILL.md                 #   Utility: Web search
│   ├── codex/SKILL.md                  #   Utility: Second opinions
│   ├── humanizer/SKILL.md              #   Utility: Remove AI patterns
│   ├── stop-slop/SKILL.md              #   Utility: Text quality
│   ├── screenshot/SKILL.md             #   Utility: Screenshots
│   ├── figma/SKILL.md                  #   Utility: Figma integration
│   ├── playwright/SKILL.md             #   Utility: Browser automation
│   ├── datacheck/SKILL.md              #   Utility: Data validation
│   └── skill-creator/SKILL.md          #   Utility: Create new skills
├── agents/                             # 7 agents
│   ├── product-strategist.md
│   ├── data-analyst.md
│   ├── prd-reviewer.md
│   ├── presentation-builder.md
│   ├── ux-researcher.md
│   ├── ecommerce-domain-expert.md
│   └── korean-english-translator.md
├── commands/                           # 5 commands
│   ├── prd.md                          #   /prd [topic]
│   ├── metrics.md                      #   /metrics [file]
│   ├── deck.md                         #   /deck [topic]
│   ├── search-prompts.md               #   /search-prompts [query]
│   └── page.md                         #   /page
└── hooks/                              # 1 hook
    └── check-prd-completeness.sh
```
