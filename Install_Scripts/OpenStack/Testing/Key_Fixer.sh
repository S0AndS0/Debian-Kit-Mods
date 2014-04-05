#!/bin/bash

# from the following link
# http://bryars.eu/2010/09/how-to-get-rid-of-gpg-no_pubkey-errors-when-doing-apt-get/
for KEY in `apt-get update 2>&1 |grep NO_PUBKEY|awk  '{print $NF}'`; do
 gpg --keyserver subkeys.pgp.net --recv $KEY; gpg --export --armor $KEY|apt-key add -;
done
