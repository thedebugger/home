function chk_key_pair -d "prints the md5 of the private and public key"
  openssl rsa -noout -modulus -in $argv[1] | openssl md5
  openssl x509 -noout -modulus -in $argv[2] | openssl md5
end
