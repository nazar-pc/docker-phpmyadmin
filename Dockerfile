FROM php:7.2-apache
LABEL maintainer "Nazar Mokrynskyi <nazar@mokrynskyi.com>"

# Set desired phpMyAdmin version

RUN PHPMYADMIN_VERSION=4.8.5 && \

# Install libbz2-dev and zlib1g-dev packages to support *.sql.bz2 and *.sql.zip compressed files during imports

	apt-get update && \
	apt-get install -y --no-install-recommends libbz2-dev zlib1g-dev && \
	apt-get clean && \
	rm -rf /var/lib/apt/lists/* && \

# Install PHP Extensions

	docker-php-ext-install bz2 mbstring mysqli zip && \

# Download and extract phpMyAdmin

	curl https://files.phpmyadmin.net/phpMyAdmin/${PHPMYADMIN_VERSION}/phpMyAdmin-${PHPMYADMIN_VERSION}-all-languages.tar.gz | tar --extract --gunzip --file - --strip-components 1 && \
	rm -rf examples && \
	rm -rf setup && \
	rm -rf sql

COPY .htaccess /var/www/html/.htaccess
COPY config.inc.php /var/www/html/config.inc.php

# Enable the container to be run by OpenShift with a non-privileged user. For details see
# https://docs.openshift.com/container-platform/3.7/creating_images/guidelines.html#use-uid

RUN chgrp -R 0 /tmp /etc/apache2 /var/run/apache2 /var/www/html && \
	chmod -R g=u /tmp /etc/apache2 /var/run/apache2 /var/www/html

COPY docker-entrypoint.sh /home/entrypoint.sh

ENTRYPOINT ["/home/entrypoint.sh"]
