function check_logs -d "runs journalctl for logs for a unit"
    sudo journalctl -u $argv[1] --output cat
end
