FROM ubuntu:16.04

MAINTAINER Gabriel Rissi <gabriel2012rissi@gmail.com>

ENV MY_DIR /home/webmaster

RUN apt-get update && \
    apt-get install -y apache2

RUN useradd -ms /bin/bash webmaster
RUN usermod -aG www-data webmaster

USER webmaster

RUN ln -s /var/www/html ${MY_DIR}/projects
WORKDIR ${MY_DIR}/projects

USER root

CMD ["apache2ctl", "-D", "FOREGROUND"]
