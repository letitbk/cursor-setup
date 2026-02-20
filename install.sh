#!/bin/bash
set -euo pipefail

echo "=== Claude Code + Cursor PM Setup ==="
echo ""

# Colors
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

ok()   { echo -e "  ${GREEN}✓${NC} $1"; }
warn() { echo -e "  ${YELLOW}!${NC} $1"; }
fail() { echo -e "  ${RED}✗${NC} $1"; }

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

# ---------- 1. Prerequisites ----------
echo "1. Checking prerequisites..."

MISSING=0
for cmd in claude node python3 jq; do
  if command -v "$cmd" > /dev/null 2>&1; then
    ok "$cmd found"
  else
    fail "$cmd not found"
    MISSING=1
  fi
done

HAS_CURSOR=0
if command -v cursor > /dev/null 2>&1; then
  ok "cursor found"
  HAS_CURSOR=1
else
  warn "cursor not in PATH — open Cursor and run: Shell Command: Install 'cursor' command in PATH"
fi

if [ "$MISSING" -eq 1 ]; then
  fail "Missing required tools. Install them and re-run."
  exit 1
fi
echo ""

# ---------- 2. Cursor Extensions ----------
echo "2. Installing Cursor extensions (22)..."

EXTENSIONS=(
  anthropic.claude-code
  github.copilot
  google.gemini-cli-vscode-ide-companion
  openai.chatgpt
  shd101wyy.markdown-preview-enhanced
  bierner.markdown-mermaid
  hediet.vscode-drawio
  figma.figma-vscode-extension
  mechatroner.rainbow-csv
  grapecity.gc-excelviewer
  mohsen1.prettify-json
  redhat.vscode-yaml
  cweijan.vscode-office
  ms-python.python
  ms-toolsai.jupyter
  eamodio.gitlens
  streetsidesoftware.code-spell-checker
  usernamehsu.errorlens
  oderwat.indent-rainbow
  alefragnani.project-manager
  pkief.material-icon-theme
  ms-ceintl.vscode-language-pack-ko
)

if command -v cursor > /dev/null 2>&1; then
  for ext in "${EXTENSIONS[@]}"; do
    cursor --install-extension "$ext" 2>/dev/null && ok "$ext" || warn "Failed: $ext"
  done
else
  warn "Skipping extensions — cursor not in PATH"
fi
echo ""

# ---------- 3. Claude Code Settings ----------
echo "3. Copying settings.json..."

mkdir -p ~/.claude

if [ -f ~/.claude/settings.json ]; then
  BACKUP=~/.claude/settings.json.backup.$(date +%Y%m%d%H%M%S)
  cp ~/.claude/settings.json "$BACKUP"
  ok "Backed up existing settings to $BACKUP"
fi

cp "$SCRIPT_DIR/settings.json" ~/.claude/settings.json
ok "settings.json installed"
echo ""

# ---------- 3b. Backup existing Claude Code files ----------
BACKUP_DIR=~/.claude/backup.$(date +%Y%m%d%H%M%S)
NEED_BACKUP=0
for check_dir in ~/.claude/skills ~/.claude/agents ~/.claude/commands ~/.claude/hooks; do
  [ -d "$check_dir" ] && NEED_BACKUP=1
done
[ -f ~/.claude/CLAUDE.md ] && NEED_BACKUP=1

if [ "$NEED_BACKUP" -eq 1 ]; then
  mkdir -p "$BACKUP_DIR"
  [ -d ~/.claude/skills ] && cp -r ~/.claude/skills "$BACKUP_DIR/"
  [ -d ~/.claude/agents ] && cp -r ~/.claude/agents "$BACKUP_DIR/"
  [ -d ~/.claude/commands ] && cp -r ~/.claude/commands "$BACKUP_DIR/"
  [ -d ~/.claude/hooks ] && cp -r ~/.claude/hooks "$BACKUP_DIR/"
  [ -f ~/.claude/CLAUDE.md ] && cp ~/.claude/CLAUDE.md "$BACKUP_DIR/"
  ok "Backed up existing files to $BACKUP_DIR"
fi
echo ""

# ---------- 4. Skills ----------
echo "4. Copying skills (24)..."

mkdir -p ~/.claude/skills
for skill_dir in "$SCRIPT_DIR"/skills/*/; do
  skill_name=$(basename "$skill_dir")
  mkdir -p ~/.claude/skills/"$skill_name"
  cp -r "$skill_dir"* ~/.claude/skills/"$skill_name"/
  ok "$skill_name"
done
echo ""

# ---------- 5. Agents ----------
echo "5. Copying agents (7)..."

mkdir -p ~/.claude/agents
for agent in "$SCRIPT_DIR"/agents/*.md; do
  cp "$agent" ~/.claude/agents/
  ok "$(basename "$agent")"
done
echo ""

# ---------- 6. Commands ----------
echo "6. Copying commands (5)..."

mkdir -p ~/.claude/commands
for cmd_file in "$SCRIPT_DIR"/commands/*.md; do
  cp "$cmd_file" ~/.claude/commands/
  ok "$(basename "$cmd_file")"
done
echo ""

# ---------- 7. Hooks ----------
echo "7. Copying hooks..."

mkdir -p ~/.claude/hooks
cp "$SCRIPT_DIR/hooks/check-prd-completeness.sh" ~/.claude/hooks/
chmod +x ~/.claude/hooks/check-prd-completeness.sh
ok "check-prd-completeness.sh (executable)"
echo ""

# ---------- 8. CLAUDE.md ----------
echo "8. Copying CLAUDE.md..."

cp "$SCRIPT_DIR/CLAUDE.md" ~/.claude/CLAUDE.md
ok "CLAUDE.md installed"
echo ""

# ---------- 9. Multi-AI & Python packages ----------
echo "9. Installing multi-AI tools and Python packages..."

# Gemini CLI
if command -v gemini > /dev/null 2>&1; then
  ok "Gemini CLI already installed"
else
  echo "   Installing Gemini CLI..."
  npm install -g @google/gemini-cli 2>/dev/null && ok "Gemini CLI installed" || warn "Gemini CLI install failed — run: npm install -g @google/gemini-cli"
fi

# Codex CLI
if command -v codex > /dev/null 2>&1; then
  ok "Codex CLI already installed"
else
  echo "   Installing Codex CLI..."
  npm install -g @openai/codex 2>/dev/null && ok "Codex CLI installed" || warn "Codex CLI install failed — run: npm install -g @openai/codex"
fi

# Python packages
echo "   Installing Python packages..."
pip3 install --quiet pandas plotnine plotly kaleido matplotlib scipy openpyxl beautifulsoup4 advertools Pillow 2>/dev/null \
  && ok "Python packages installed" \
  || warn "Some Python packages failed — run: pip3 install pandas plotnine plotly kaleido matplotlib scipy openpyxl beautifulsoup4 advertools Pillow"

# Playwright
echo "   Installing Playwright..."
pip3 install --quiet playwright 2>/dev/null && python3 -m playwright install chromium 2>/dev/null \
  && ok "Playwright + Chromium installed" \
  || warn "Playwright install failed — run: pip3 install playwright && python3 -m playwright install chromium"

echo ""

# ---------- 10. Plugins reminder ----------
echo "10. Plugin installation (manual step)"
echo ""
echo "   Open Claude Code CLI and run these commands:"
echo ""
echo "   /plugin install superpowers@claude-plugins-official"
echo "   /plugin install context7@claude-plugins-official"
echo "   /plugin install figma@claude-plugins-official"
echo "   /plugin install playwright@claude-plugins-official"
echo "   /plugin install frontend-design@claude-code-plugins"
echo "   /plugin install plannotator@plannotator"
echo "   /plugin install feature-dev@claude-plugins-official"
echo "   /plugin install github@claude-plugins-official"
echo "   /plugin install ralph-loop@claude-plugins-official"
echo "   /plugin install claude-notifications-go@claude-notifications-go"
echo ""

# ---------- 11. Verification ----------
echo "=== Verification ==="
echo ""

if [ "$HAS_CURSOR" -eq 1 ]; then
  EXT_COUNT=$(cursor --list-extensions 2>/dev/null | wc -l | tr -d ' ')
  echo "1. Cursor extensions: $EXT_COUNT (expected: >= 22)"
else
  echo "1. Cursor extensions: SKIPPED (cursor not in PATH)"
fi

if python3 -c "import json; json.load(open('$HOME/.claude/settings.json'))" 2>/dev/null; then
    PLUGIN_COUNT=$(python3 -c "import json; d=json.load(open('$HOME/.claude/settings.json')); print(len(d.get('enabledPlugins', {})))")
    echo "2. Settings.json: valid, $PLUGIN_COUNT plugins (expected: 10)"
else
    echo "2. Settings.json: INVALID or missing"
fi

echo "3. Skills: $(ls -d ~/.claude/skills/*/ 2>/dev/null | wc -l | tr -d ' ') (expected: >= 24)"
echo "4. Agents: $(ls ~/.claude/agents/*.md 2>/dev/null | wc -l | tr -d ' ') (expected: >= 7)"
echo "5. Commands: $(ls ~/.claude/commands/*.md 2>/dev/null | wc -l | tr -d ' ') (expected: >= 5)"

test -x ~/.claude/hooks/check-prd-completeness.sh \
  && echo "6. Hook: executable" \
  || echo "6. Hook: MISSING"

test -f ~/.claude/CLAUDE.md \
  && echo "7. CLAUDE.md: present" \
  || echo "7. CLAUDE.md: MISSING"

command -v gemini > /dev/null 2>&1 \
  && echo "8. Gemini CLI: installed" \
  || echo "8. Gemini CLI: NOT INSTALLED"

command -v codex > /dev/null 2>&1 \
  && echo "9. Codex CLI: installed" \
  || echo "9. Codex CLI: NOT INSTALLED"

python3 -c "import plotnine; import plotly; import advertools" 2>/dev/null \
  && echo "10. Python packages: OK" \
  || echo "10. Python packages: SOME MISSING"

echo ""
echo "=== Setup complete ==="
echo ""
echo "Next steps:"
echo "  1. Install plugins (step 10 above) inside Claude Code CLI"
echo "  2. Authenticate Gemini: run 'gemini' and sign in"
echo "  3. Authenticate Codex: run 'codex' and sign in"
echo "  4. Try: /prd [topic], /metrics [file], /deck [topic]"
