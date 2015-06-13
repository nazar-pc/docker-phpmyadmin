FROM php:5.6-apache
MAINTAINER Nazar Mokrynskyi <nazar@mokrynskyi.com>

WORKDIR /var/www/html

# Set desired phpMyAdmin version

ENV PHPMYADMIN_VERSION=4.4.9

# Install PHP Extension

RUN	docker-php-ext-install mbstring && \
	docker-php-ext-install mysqli && \

# We'll need wget

	apt-get update && \
	apt-get install -y wget && \
	apt-get autoremove -y && \
	apt-get clean && \
	rm -rf /var/lib/apt/lists/* && \

# Download and extract phpMyAdmin

  wget --no-verbose -O - http://sourceforge.net/projects/phpmyadmin/files/phpMyAdmin/${PHPMYADMIN_VERSION}/phpMyAdmin-${PHPMYADMIN_VERSION}-all-languages.tar.gz | tar --extract --gunzip --file - --strip-components 1 && \
	rm -rf phpMyAdmin* && \
	rm -rf examples && \
	rm -rf setup && \
	rm -rf sql

COPY .htaccess config.inc.php /var/www/html/
