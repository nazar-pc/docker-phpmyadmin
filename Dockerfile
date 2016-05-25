FROM php:5.6-apache
MAINTAINER Nazar Mokrynskyi <nazar@mokrynskyi.com>

# Set desired phpMyAdmin version

RUN PHPMYADMIN_VERSION=4.6.2 && \

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

COPY docker-entrypoint.sh /home/entrypoint.sh

ENTRYPOINT ["/home/entrypoint.sh"]

