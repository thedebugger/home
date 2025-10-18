function print_x509 -d "print x509 pem"
    cat $argv[1] | openssl x509 -noout -text
end
