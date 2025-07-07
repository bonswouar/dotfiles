#!/bin/sh
## battery-graph custom script
# Set --from and --to to the best values (first and last one from the battery-stats logs)

FROM="`head -n 1 $1 | cut -d ' ' -f 4,5`"
TO="`tail -n 1 $1 | cut -d ' ' -f 4,5`"
battery-graph $1 --from "$FROM" --to "$TO"
