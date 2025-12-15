#!/usr/bin/env bash

# Set the file name
filename="$1"

# Use awk to process the file and remove consecutive newlines
awk 'NF { n = 2 } n-- > 0' "$filename" > temp_file.txt && mv temp_file.txt "$filename"
sed -i 's/[[:space:]]*$//' $filename
