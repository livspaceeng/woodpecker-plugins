#!/bin/sh

threshold="${PLUGIN_THRESHOLD:-20}"
minTokens="${PLUGIN_MIN_TOKENS:-50}"
pattern="${PLUGIN_PATTERN:-**/*}"
ignore="${PLUGIN_IGNORE:-**/*.min.js,**/*.map,**/*.yaml,**/*.json}"
scanDir="${PLUGIN_SCAN_DIR:-.}"

echo '{
        "threshold": '"${threshold}"',
        "minTokens": '"${minTokens}"',
        "reporters": [
          "consoleFull"
        ],
        "pattern": "'"${pattern}"'",
        "ignore": "'"${ignore}"'"
      }' > /tmp/.jscpd.json
cat /tmp/.jscpd.json
jscpd --exitCode 1 --config /tmp/.jscpd.json "${scanDir}"

