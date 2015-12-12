function echo_cert -d "Prints the cert contents"
    openssl x509 -noout -in $argv[1] -text
end
