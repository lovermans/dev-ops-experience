[req]
default_bits = 2048
distinguished_name = req_distinguished_name
req_extensions = v3_req
prompt = no

[req_distinguished_name]
C  = ID
ST = "Jawa Timur"
L  = Mojokerto
O  = Semesta
OU = Singularity
CN = Semesta

[v3_req]
extendedKeyUsage = serverAuth
subjectAltName = @alt_names

[alt_names]
DNS.1 = localhost

# You can another DNS below. For example:
# DNS.2 = xxx
# DNS.3 = yyy