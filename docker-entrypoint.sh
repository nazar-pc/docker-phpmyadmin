#!/bin/bash
set -e

test -z $UPLOAD_SIZE || sed -i "s/128M/$UPLOAD_SIZE/g" /var/www/html/.htaccess

exec apache2-foreground
