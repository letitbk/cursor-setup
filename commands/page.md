# Page - Session History Dump with Citations and Memory Management

Like OS paging for processes, this command saves the entire conversation state to disk by extracting it from Claude Code's local storage (~/.claude/projects/). After running this command, you can use `/compact` to free up Claude's context memory.

## Usage

```
/page [filename_prefix] [output_directory]
```

## Arguments

- `filename_prefix` (optional): Custom prefix for output files. Defaults to "session-dump"
- `output_directory` (optional): Directory to save files. Defaults to current working directory

## Description

This command implements a memory management strategy similar to OS paging:

1. **Page Out (Save to Disk)**:
   - Saves complete conversation state with full citations
   - Creates indexed source references for quick retrieval
   - Preserves all context before memory compaction

2. **Generated Files**:
   - **Full History File** (`{prefix}-{timestamp}-full.md`): Complete conversation transcript with timestamps, file operations, web resources, command executions, and citation index.
   - **Compact Memory File** (`{prefix}-{timestamp}-compact.md`): Executive summary, key decisions, code changes, quick reference links.

3. **Memory Management Workflow**:
   - First: Run `/page` to save everything to disk
   - Then: Run `/compact` to free up Claude's context memory
   - Result: Fresh context while preserving full history

## Implementation

### Phase 1: History Extraction
Extract from Claude Code's local storage (`~/.claude/projects/`). Find the current session file and extract all messages with formatting.

### Phase 2: Source Attribution
- **Local Files**: `file:///path/to/file.ext#L10-L20`
- **Web Pages**: `[Source Title](URL)` with content excerpt
- **Command Outputs**: `$ command` with full output
- **Tool Results**: Tool name, parameters, results

### Phase 3: Full History Generation
Create comprehensive markdown with compact summary at top, full timeline, and source index.

### Phase 4: Memory Compaction
Generate executive summary with key decisions, code changes, and quick reference links.

### Phase 5: Save Files
- Generate both files in current directory (or specified output_directory)
- Timestamp format: YYYY-MM-DD_HHMMSS
- Confirm save with paths and sizes
- Instruct user to run `/compact` afterward

## Output Files
1. `{prefix}-{timestamp}-full.md` - Complete history
2. `{prefix}-{timestamp}-compact.md` - Executive summary
