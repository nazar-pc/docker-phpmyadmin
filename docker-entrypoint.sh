#!/bin/bash

# Support for stopping container with `Ctrl+C`

set -e

# Support for UPLOAD_SIZE env var, if specified - will be used instead of default value 128M

test -z $UPLOAD_SIZE || sed -i "s/128M/$UPLOAD_SIZE/g" /var/www/html/.htaccess

# Start Apache as usual

exec apache2-foreground
