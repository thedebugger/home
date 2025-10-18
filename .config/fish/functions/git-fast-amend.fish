function git-fast-amend -d "Git fast amend"
    git add --all; git commit --amend --no-edit; git push --force
end
