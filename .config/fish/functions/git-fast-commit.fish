function git-fast-commit --description 'Git fast commit'
    argparse $options -- $argv
    git add --all 
    git commit -m "$argv[1]"
    git push --force
end
