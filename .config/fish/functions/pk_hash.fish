function pk_hash -d "prints the md5 hash of the public key inside the x509 certification"
  openssl x509 -pubkey -noout -in $argv[1] | openssl md5
end
