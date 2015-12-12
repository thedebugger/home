function port_open -d "checks if some process is listening on this port"
  lsof -i -n -P | grep $argv[1]
end
