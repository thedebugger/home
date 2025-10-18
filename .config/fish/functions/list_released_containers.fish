function list_released_containers -d "lists the released containers version"
    set image $argv[1]
    set namespace (set -q argv[2]; and echo $argv[2]; or echo 'ise')
    set repo (set -q argv[3]; and echo $argv[3]; or echo 'gold')
    gcloud artifacts docker tags list --limit 4 --sort-by ~tag us-docker.pkg.dev/ck-corp-artifact-registry/ckdocker-$repo/$namespace/$image
end
