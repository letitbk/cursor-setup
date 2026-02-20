Create a Marp presentation on: $ARGUMENTS

If no topic was provided above (blank after the colon), ask the user what topic the presentation should cover.

## Step 1: Content Planning

Suggest slide count based on format:
- **5-8 slides** for status update or standup
- **10-15 slides** for feature review or sprint demo
- **15-25 slides** for stakeholder pitch or quarterly review

Present the proposed outline with one-line descriptions per slide. Ask the user to confirm before proceeding.

## Step 2: Build the Marp Deck

Create a `.md` file with Marp front matter:

```yaml
---
marp: true
theme: default
paginate: true
backgroundColor: #ffffff
color: #333333
style: |
  section { font-family: 'Segoe UI', Arial, sans-serif; }
  h1 { color: #1a365d; }
  h2 { color: #2d5f8a; }
  table { font-size: 0.8em; width: 100%; }
---
```

Guidelines:
- Title slide with topic, presenter placeholder, date
- Use `---` to separate slides
- One key idea per slide, max 5 bullet points
- Include a data/metrics slide with markdown table where relevant
- End with "Next Steps" or "Discussion" slide
- Use speaker notes (`<!-- notes -->`) for talking points

Save as `deck-{topic-slug}.md` in the current working directory.
