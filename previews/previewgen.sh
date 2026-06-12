#!/bin/bash

cd previews


images=($(find .. -maxdepth 1 -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.webp" \) | sort))

rm -f preview-*.md

page=1
count=0
current_file=""

for img in "${images[@]}"; do
    img="${img#../}"
    if [ $count -eq 0 ]; then
        current_file="preview-$page.md"
        echo "# Preview Page $page" > "$current_file"
        echo "" >> "$current_file"
    fi
    echo "![$img](../$img)" >> "$current_file"
    count=$((count + 1))
    if [ $count -eq 10 ]; then
        page=$((page + 1))
        count=0
    fi
done

echo "Generated $((page - 1)) preview pages"
