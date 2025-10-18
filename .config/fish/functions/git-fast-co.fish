function git-fast-co -d "Git fast co"
    set branch master
    if git rev-parse --verify main 2>/dev/null
        set branch main
    end
    git co $branch; git ffwd; git co -b $argv[1]
end
