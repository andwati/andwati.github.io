#!/bin/bash

# Check if a title argument was passed
if [ -z "$1" ]; then
  echo "Usage: $0 <slugified-title>"
  exit 1
fi

# Get the current date
DATE=$(date +"%Y-%m-%d")
TIMEZONE="+0300"
TITLE_SLUG="$1"
FILENAME="${DATE}-${TITLE_SLUG}.md"
POST_PATH="_posts/${FILENAME}"

# Convert slugified title to a proper title
TITLE=$(echo "$TITLE_SLUG" | sed 's/-/ /g' | sed -E 's/\b(.)/\U\1/g')

# Create the post file with frontmatter
cat <<EOF > "$POST_PATH"
---
title: "${TITLE}"
description: ""
date: ${DATE} ${TIMEZONE}
tags: []
---
EOF

echo "New post created at $POST_PATH"
