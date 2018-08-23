#!/bin/sh

# Support for stopping container with `Ctrl+C`

set -e

# Support for Apache web server custom ports: env vars HTTP_PORT (80) and HTTPS_PORT (443)

test -z $HTTP_PORT || sed -i "s/Listen 80/Listen $HTTP_PORT/" /etc/apache2/ports.conf
test -z $HTTPS_PORT || sed -i "s/Listen 443/Listen $HTTPS_PORT/" /etc/apache2/ports.conf

# Support for UPLOAD_SIZE env var, if specified - will be used instead of default value 128M

test -z $UPLOAD_SIZE || sed -i "s/128M/$UPLOAD_SIZE/g" /var/www/html/.htaccess

# Start Apache as usual

exec apache2-foreground
