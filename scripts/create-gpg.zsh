#!/usr/bin/env zsh

KEY_NAME="homelab.localhost"
KEY_COMMENT="HomeLab Key"

gpg --batch --full-generate-key <<EOF
%no-protection
Key-Type: 1
Key-Length: 4096
Subkey-Type: 1
Subkey-Length: 4096
Expire-Date: 0
Name-Comment: ${KEY_COMMENT}
Name-Real: ${KEY_NAME}
EOF

echo "GPG key created:"
gpg --list-secret-keys "${KEY_NAME}"