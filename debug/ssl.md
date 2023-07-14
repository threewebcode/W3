**Procedures**

1. ssl command to view certificate content;
2. make build to verify by go codes

**Troubleshooting**

1. gmsm

```
git clone https://github.com/tjfoc/gmsm
find gmsm -type f -name *.cer
openssl version
openssl x509 -text -noout -in gmsm/gmtls/websvr/certs/SM2_CA.cer
gmssl x509 -text -noout -in gmsm/gmtls/websvr/certs/SM2_CA.cer
```

```
        Subject Public Key Info:
            Public Key Algorithm: id-ecPublicKey
                Public-Key: (256 bit)
                pub:
                    04:ba:38:50:8d:ca:0a:07:d9:fe:0e:9c:f6:d5:e7:
                    bd:2b:c9:db:55:71:3b:c0:51:83:a8:fc:c9:3d:75:
                    c2:ac:bc:4c:03:bb:e5:99:d8:bc:3c:11:fe:0f:09:
                    ca:a0:9b:a0:7a:fa:aa:3c:eb:1e:00:29:78:e6:a5:
                    3c:d7:bd:77:fd
                ASN1 OID: SM2
```

2. gmssl

```
git clone https://github.com/guanzhi/GmSSL.git
sudo cp /usr/local/lib/libgmssl.so.3 /usr/lib/ && sudo ldconfig
gmssl certparse -in gmsm/gmtls/websvr/certs/SM2_CA.cer
```

```
        subjectPulbicKeyInfo
            algorithm
                algorithm: ecPublicKey
                namedCurve: sm2p256v1
            subjectPublicKey
                ECPoint: 04BA38508DCA0A07D9FE0E9CF6D5E7BD2BC9DB55713BC05183A8FCC93D75C2ACBC4C03BBE599D8BC3C11FE0F09CAA09BA07AFAAA3CEB1E002978E6A53CD7BD77FD            
```
