#Note: this docker file is for running PHP7.1 in development, it does not package an app
FROM php:7.1-cli

WORKDIR /root

RUN apt-get update && apt-get install -y git libz-dev && docker-php-ext-install zip pdo pdo_mysql

RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" && \
    php -r "copy('https://composer.github.io/installer.sig', 'composer-setup.sig');" && \
    php -r "if (hash_file('SHA384', 'composer-setup.php') === trim(file_get_contents('composer-setup.sig'))) { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php');  die(-1); } echo PHP_EOL;"  && \
    php composer-setup.php  && \
    php -r "unlink('composer-setup.php');" && \
    cp composer.phar /usr/local/bin/composer
ENV COMPOSER_ALLOW_SUPERUSER 1

RUN mkdir /app
WORKDIR /app
CMD /bin/bash