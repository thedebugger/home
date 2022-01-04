function list_released_containers -d "lists the released containers version"
    set image $argv[1]
    # valid repo values are bronze, gold. also we use this sometimes  -- https://artifactory.corp.creditkarma.com/api/storage/ckdocker/$namespace/$image
    set namespace (set -q argv[2]; and echo $argv[2]; or echo 'ise')
    set ver (set -q argv[4]; and echo $argv[4]; or echo '')
    set repo (set -q argv[3]; and echo $argv[3]; or echo 'gold')
    set base_url "https://artifactory.corp.creditkarma.com/api/storage/ckdocker-$repo/$namespace/$image"
    if [ $ver = "" ]
        curl --silent $base_url -u sumit.vij:$ARTIFACTORY_TOKEN | jq .children[].uri
    else
        curl --silent "$base_url/$ver" -u sumit.vij:$ARTIFACTORY_TOKEN
    end
end
