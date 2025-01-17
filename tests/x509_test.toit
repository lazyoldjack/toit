// Copyright (C) 2019 Toitware ApS.
// Use of this source code is governed by a Zero-Clause BSD license that can
// be found in the tests/LICENSE file.

import expect show *

import net.x509 as net

main:
  cert := net.Certificate.parse TEST_USERTRUST_CERTIFICATE
  expect_equals "USERTrust RSA Certification Authority" cert.common_name

  cert = net.Certificate.parse TEST_CA_CERT
  expect_equals "Toitware Test Root CA" cert.common_name

  cert = net.Certificate.parse TEST_CLIENT_CERT
  expect_equals "1ba80669-5c3f-4587-91c8-4a8689e9f838" cert.common_name

// Ebay.de sometimes uses this trusted root certificate.
// Serial number 01:FD:6D:30:FC:A3:CA:51:A8:1B:BC:64:0E:35:03:2D
TEST_USERTRUST_CERTIFICATE ::= """\
-----BEGIN CERTIFICATE-----
MIIF3jCCA8agAwIBAgIQAf1tMPyjylGoG7xkDjUDLTANBgkqhkiG9w0BAQwFADCB
iDELMAkGA1UEBhMCVVMxEzARBgNVBAgTCk5ldyBKZXJzZXkxFDASBgNVBAcTC0pl
cnNleSBDaXR5MR4wHAYDVQQKExVUaGUgVVNFUlRSVVNUIE5ldHdvcmsxLjAsBgNV
BAMTJVVTRVJUcnVzdCBSU0EgQ2VydGlmaWNhdGlvbiBBdXRob3JpdHkwHhcNMTAw
MjAxMDAwMDAwWhcNMzgwMTE4MjM1OTU5WjCBiDELMAkGA1UEBhMCVVMxEzARBgNV
BAgTCk5ldyBKZXJzZXkxFDASBgNVBAcTC0plcnNleSBDaXR5MR4wHAYDVQQKExVU
aGUgVVNFUlRSVVNUIE5ldHdvcmsxLjAsBgNVBAMTJVVTRVJUcnVzdCBSU0EgQ2Vy
dGlmaWNhdGlvbiBBdXRob3JpdHkwggIiMA0GCSqGSIb3DQEBAQUAA4ICDwAwggIK
AoICAQCAEmUXNg7D2wiz0KxXDXbtzSfTTK1Qg2HiqiBNCS1kCdzOiZ/MPans9s/B
3PHTsdZ7NygRK0faOca8Ohm0X6a9fZ2jY0K2dvKpOyuR+OJv0OwWIJAJPuLodMkY
tJHUYmTbf6MG8YgYapAiPLz+E/CHFHv25B+O1ORRxhFnRghRy4YUVD+8M/5+bJz/
Fp0YvVGONaanZshyZ9shZrHUm3gDwFA66Mzw3LyeTP6vBZY1H1dat//O+T23LLb2
VN3I5xI6Ta5MirdcmrS3ID3KfyI0rn47aGYBROcBTkZTmzNg95S+UzeQc0PzMsNT
79uq/nROacdrjGCT3sTHDN/hMq7MkztReJVni+49Vv4M0GkPGw/zJSZrM233bkf6
c0Plfg6lZrEpfDKEY1WJxA3Bk1QwGROs0303p+tdOmw1XNtB1xLaqUkL39iAigmT
Yo61Zs8liM2EuLE/pDkP2QKe6xJMlXzzawWpXhaDzLhn4ugTncxbgtNMs+1b/97l
c6wjOy0AvzVVdAlJ2ElYGn+SNuZRkg7zJn0cTRe8yexDJtC/QV9AqURE9JnnV4ee
UB9XVKg+/XRjL7FQZQnmWEIuQxpMtPAlR1n6BB6T1CZGSlCBst6+eLf8ZxXhyVeE
Hg9j1uliutZfVS7qXMYoCAQlObgOK6nyTJccBz8NUvXt7y+CDwIDAQABo0IwQDAd
BgNVHQ4EFgQUU3m/WqorSs9UgOHYm8Cd8rIDZsswDgYDVR0PAQH/BAQDAgEGMA8G
A1UdEwEB/wQFMAMBAf8wDQYJKoZIhvcNAQEMBQADggIBAFzUfA3P9wF9QZllDHPF
Up/L+M+ZBn8b2kMVn54CVVeWFPFSPCeHlCjtHzoBN6J2/FNQwISbxmtOuowhT6KO
VWKR82kV2LyI48SqC/3vqOlLVSoGIG1VeCkZ7l8wXEskEVX/JJpuXior7gtNn3/3
ATiUFJVDBwn7YKnuHKsSjKCaXqeYalltiz8I+8jRRa8YFWSQEg9zKC7F4iRO/Fjs
8PRF/iKz6y+O0tlFYQXBl2+odnKPi4w2r78NBc5xjeambx9spnFixdjQg3IM8WcR
iQycE0xyNN+81XHfqnHd4blsjDwSXWXavVcStkNr/+XeTWYRUc+ZruwXtuhxkYze
Sf7dNXGiFSeUHM9h4ya7b6NnJSFd5t0dCy5oGzuCr+yDZ4XUmFF0sbmZgIn/f3gZ
XHlKYC6SQK5MNyosycdiyA5d9zZbyuAlJQG03RoHnHcAP9Dc1ew91Pq7P8yF1m9/
qS3fuQL39ZeatTXaw2ewh0qpKJ4jjv9cJ2vhsE/zB+4ALtRZh8tSQZXq9EfX7mRB
VXyNWQKV3WKdwrnuWih0hKWbt5DHDAff9Yk2dDLWKMGwsAvgnEzDHNb842m1R0aB
L6KCq9NjRHDEjf8tM7qtj3u1cIiuPhnPQCjY/MiQu12ZIvVS5ljFH4gxQ+6IHdfG
jjxDah2nGN59PRbxYvnKkKj9
-----END CERTIFICATE-----"""

TEST_CA_CERT ::= """\
-----BEGIN CERTIFICATE-----
MIICNjCCAbugAwIBAgIJAOar9RhshlboMAoGCCqGSM49BAMCMFcxCzAJBgNVBAYT
AkRLMREwDwYDVQQKDAhUb2l0d2FyZTEVMBMGA1UECwwMVGVzdCBSb290IENBMR4w
HAYDVQQDDBVUb2l0d2FyZSBUZXN0IFJvb3QgQ0EwHhcNMTkwNDA1MTIxNTUyWhcN
MzkwMzMxMTIxNTUyWjBXMQswCQYDVQQGEwJESzERMA8GA1UECgwIVG9pdHdhcmUx
FTATBgNVBAsMDFRlc3QgUm9vdCBDQTEeMBwGA1UEAwwVVG9pdHdhcmUgVGVzdCBS
b290IENBMHYwEAYHKoZIzj0CAQYFK4EEACIDYgAEhsBtjTS2o88U15qD3HxekFyo
+aAKnsAjVnOlkwGdpUcn/mOZRQlaZ10XS/N4jNWsIqyVM9c4b89x4pZ9Rje5ttLH
3Ws+ZFZALwagWsVIbOnQ5LxC4FDH/HCWfN31gNWuo1MwUTAdBgNVHQ4EFgQUWxQz
AcTUxQJwX9138uuXy3SC8UgwHwYDVR0jBBgwFoAUWxQzAcTUxQJwX9138uuXy3SC
8UgwDwYDVR0TAQH/BAUwAwEB/zAKBggqhkjOPQQDAgNpADBmAjEAynrABm0LWTyC
R+qrkVE17S8TRp3PbXaynGW3Xwaev51FWLGxobW5rEtKDik+IWyyAjEAue/xLVXl
iHQAyCot5IqtEuGGemy/8zO0Lx4yvTxwcDyWEzOv9kZ5yu0ltLQ3KOjl
-----END CERTIFICATE-----"""

TEST_CLIENT_CERT ::= """
-----BEGIN CERTIFICATE-----
MIIB1DCCAVugAwIBAgIQDv/WVGiicngermUbkudXETAKBggqhkjOPQQDAzAbMRkw
FwYDVQQKExBUb2l0d2FyZSB0ZXN0aW5nMB4XDTE5MDUwNjEyNDE0NloXDTIwMDUw
NTEyNDE0NlowSjEZMBcGA1UEChMQVG9pdHdhcmUgdGVzdGluZzEtMCsGA1UEAxMk
MWJhODA2NjktNWMzZi00NTg3LTkxYzgtNGE4Njg5ZTlmODM4MHYwEAYHKoZIzj0C
AQYFK4EEACIDYgAECYA4ExFxC+nhMhwZw4Y8/33dLTiEo10B9fNmdOaPINLwNzQ/
tRLA5Y28Hl2a32//AMRuWWM1B3iYoGNlP3ETkokjwSgf1Ex+bAg7rWCqFOfRQL8V
JUjaExHsNmF8Osb3ozUwMzAOBgNVHQ8BAf8EBAMCBaAwEwYDVR0lBAwwCgYIKwYB
BQUHAwEwDAYDVR0TAQH/BAIwADAKBggqhkjOPQQDAwNnADBkAjBBf0b5pJIV2IC7
CSdSRjJlx+bC3eo7MZMT08Em+xto3+xreoL4S8WQcfu8ug3inF0CMCb3RRIbE3Ni
giNLpsFPhHmVD8AmMstm6EUJTy25b/vUubKOFClRokYve2VjukoKRA==
-----END CERTIFICATE-----
"""
