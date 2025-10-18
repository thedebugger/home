function git-grep-sed -d "Git grep and sed"
  argparse "h/help" "f/find=" "r/replace=" "p/path=" -- $argv
  or return # Exit if argparse fails

  if set -q _flag_help
    echo "Usage: git-grep-sed [--path <path>] [--find <string>] [--replace <string>]"
    echo ""
    echo "This function finds and replaces a string in files tracked by Git."
    echo ""
    echo "Options:"
    echo "  -f, --find <string>      The string to find."
    echo "  -r, --replace <string>   The string to replace with."
    echo "  -p, --path <path>        The path to search in (default: current directory)."
    echo "  -h, --help               Show this help message."
    echo ""
    echo "Examples:"
    echo "  git-grep-sed --find 'old_text' --replace 'new_text'"
    echo "  git-grep-sed --find 'test' --replace 'dev' --path src/components"
    return 0
  end

  # Assigning values from flags
  set -l find_string $_flag_find
  set -l replace_string $_flag_replace
  set -l search_path "."

  if set -q _flag_path; and test -n "$_flag_path"
    set search_path "$_flag_path"
  end

  if test -z "$find_string" -o -z "$replace_string"
    echo "Error: Both --find and --replace arguments are required." >&2
    git-grep-sed --help
    return 1
  end

  echo "Searching for '$find_string' and replacing with '$replace_string' in '$search_path'..."

  # The -- is important to separate git grep's arguments from the path.
  git grep "$find_string" -- "$search_path" | awk -F ":" '{print $1}' | xargs sed -i "s/$find_string/$replace_string/g"
end
