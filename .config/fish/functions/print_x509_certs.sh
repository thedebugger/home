function print_x509_certs -d "print x509 pem cert chain"
    openssl crl2pkcs7 -nocrl -certfile $argv[1] | openssl pkcs7 -print_certs -noout
end
