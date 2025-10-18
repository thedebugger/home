function git-fast-pr -d "Git fast push and create pr"
    # https://stackoverflow.com/questions/56511681/defining-new-fish-commands-in-a-script-and-parse-arguments
    set -l options (fish_opt -s s -l skipadd )
    argparse $options -- $argv
    if not set -q _flag_skipadd
        git add --all; 
    end
    git commit -m "$argv[1]"; 
    gh pr create --fill --label sync-to-base
    set pr_url (gh pr create --fill --label sync-to-base)
    gh pr merge -s -d $pr_url --auto
end
