function gen_pub_key -d "Generates the public key for a private key"
  ssh-keygen -y -f $argv[1]
end
