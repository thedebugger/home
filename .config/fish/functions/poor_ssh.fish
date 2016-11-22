function poor_ssh -d "run's a command on all the servers"
    set -l __hosts (echo -n $argv[1] | tr ' ' \n)
    for h in $__hosts
        ssh $h "$argv[2]"
    end
end
