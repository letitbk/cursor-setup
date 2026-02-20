Search across all your Claude Code conversation history for: $ARGUMENTS

## Multi-Source Prompt Search

Search through your Claude Code conversation history using multiple methods to find relevant prompts, discussions, and insights.

### Database Search (SQLite)
First, search the main conversation database:

```bash
# Search user messages for keywords
sqlite3 ~/.claude/__store.db "
SELECT
    b.session_id,
    datetime(b.timestamp, 'unixepoch') as date,
    substr(u.message, 1, 100) as preview
FROM user_messages u
JOIN base_messages b ON u.uuid = b.uuid
WHERE u.message LIKE '%$ARGUMENTS%'
ORDER BY b.timestamp DESC
LIMIT 10;"
```

### Session-Based Search
Find and resume specific conversation sessions:

```bash
sqlite3 ~/.claude/__store.db "
SELECT DISTINCT
    b.session_id,
    datetime(MIN(b.timestamp), 'unixepoch') as start_date,
    datetime(MAX(b.timestamp), 'unixepoch') as end_date,
    COUNT(*) as message_count,
    b.cwd as working_directory
FROM base_messages b
GROUP BY b.session_id
ORDER BY MAX(b.timestamp) DESC
LIMIT 10;"
```

### Conversation Summary Search
```bash
sqlite3 ~/.claude/__store.db "
SELECT
    cs.summary,
    datetime(cs.updated_at, 'unixepoch') as last_updated
FROM conversation_summaries cs
WHERE cs.summary LIKE '%$ARGUMENTS%'
ORDER BY cs.updated_at DESC;"
```

### Temporal Search
```bash
sqlite3 ~/.claude/__store.db "
SELECT
    b.session_id,
    datetime(b.timestamp, 'unixepoch') as date,
    substr(u.message, 1, 150) as preview
FROM user_messages u
JOIN base_messages b ON u.uuid = b.uuid
WHERE u.message LIKE '%$ARGUMENTS%'
AND b.timestamp > strftime('%s', 'now', '-7 days')
ORDER BY b.timestamp DESC;"
```

### Resume Sessions
```bash
claude --resume SESSION_ID
```

## Search Strategy
1. Start broad with general keywords
2. Narrow down with specific terms
3. Filter by time for current projects
4. Use session IDs to continue conversations
