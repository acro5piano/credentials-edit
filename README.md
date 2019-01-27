# credentials-edit

credential editor like rails `credentials:edit`

# Features

- Only depends on Openssl
- No need to install tools in almost all environments

# Install

```
curl -L https://raw.githubusercontent.com/acro5piano/credentials-edit/master/credentials-edit.sh > /usr/local/bin/credentials-edit
chmod +x /usr/local/bin/credentials-edit
```

# Usage

```
Usage: credentials-edit COMMAND FILE

Available commands:

    create - create encrypted file from non-encrypted file
    edit - decrypt file, edit, then encrypt again
```
