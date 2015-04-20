FROM php:5.6-apache
MAINTAINER Nazar Mokrynskyi <nazar@mokrynskyi.com>

WORKDIR /var/www/html

# Set desired phpMyAdmin version

RUN PHPMYADMIN_VERSION=4.4.2 && \

# Install PHP Extension

	docker-php-ext-install mbstring && \
	docker-php-ext-install mysqli && \

# We'll need wget

	apt-get update && \
	apt-get install -y wget && \
	rm -rf /var/lib/apt/lists/* && \

# Download and extract phpMyAdmin

	wget -O pma.tar.gz http://sourceforge.net/projects/phpmyadmin/files/phpMyAdmin/${PHPMYADMIN_VERSION}/phpMyAdmin-${PHPMYADMIN_VERSION}-all-languages.tar.gz && \
	tar -xzf pma.tar.gz && \
	rm pma.tar.gz && \
	mv phpMyAdmin*/* . && \
	rm -rf phpMyAdmin* && \
	rm -rf examples && \
	rm -rf setup && \
	rm -rf sql

COPY .htaccess /var/www/html/.htaccess
COPY config.inc.php /var/www/html/config.inc.php
