# Everything will be stored in "tls" directory
mkdir -p tls

# Generate CA key
if [[ $1 == "rsa" ]]; then
    openssl genpkey -algorithm RSA -pkeyopt rsa_keygen_bits:2048 -out tls/ca.key
else
    openssl genpkey -algorithm ED25519 -out tls/ca.key
fi

# Generate self-signed CA certificate
openssl req -x509 -new -key tls/ca.key -out tls/ca.crt -days 3650 -subj "/C=US/ST=California/L=San Francisco/O=MyCompany/CN=MyCA"

# Generate server key
if [[ $1 == "rsa" ]]; then
    openssl genpkey -algorithm RSA -pkeyopt rsa_keygen_bits:2048 -out tls/server.key
else
    openssl genpkey -algorithm ED25519 -out tls/server.key
fi

# Create server.cnf for CSR
cat > tls/server.cnf <<EOF
[req]
default_bits = 2048
distinguished_name = req_distinguished_name
req_extensions = req_ext
prompt = no

[req_distinguished_name]
C = US
ST = California
L = San Francisco
O = MyCompany
CN = osu.ppy.sh

[req_ext]
subjectAltName = @alt_names

[alt_names]
DNS.1 = osu.ppy.sh
EOF

# Generate CSR for server certificate
openssl req -new -key tls/server.key -out tls/server.csr -config tls/server.cnf

# Create v3.ext for server certificate
cat > tls/v3.ext <<EOF
authorityKeyIdentifier=keyid,issuer
basicConstraints=CA:FALSE
keyUsage = digitalSignature, nonRepudiation, keyEncipherment, dataEncipherment
extendedKeyUsage = serverAuth
subjectAltName = @alt_names

[alt_names]
DNS.1 = osu.ppy.sh
EOF

# Generate server certificate signed by the CA
openssl x509 -req -in tls/server.csr -CA tls/ca.crt -CAkey tls/ca.key -CAcreateserial -out tls/server.crt -days 3650 -sha256 -extfile tls/v3.ext
