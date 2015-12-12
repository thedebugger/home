function auto_commit_id
   set gitdir (git rev-parse --git-dir); scp -p -P 29418 svij@gerrit.flexilis.local:hooks/commit-msg {$gitdir}/hooks/
end
