FROM ubuntu:20.04

ENV WORDPRESS_HOME=/var/www/wordpress
ENV DEBIAN_FRONTEND=noninteractive

RUN ln -s /usr/share/zoneinfo/Asia/Yekaterinburg /etc/localtime && \
    apt-get -y update && \
    apt-get -y install apache2 php libapache2-mod-php php-mysql php-curl php-gd php-mbstring php-xml php-xmlrpc php-soap php-intl php-zip && \
    apt autoremove

COPY ./wordpress.conf /etc/apache2/sites-available

RUN a2ensite wordpress && \
    a2dissite 000-default && \
    a2enmod rewrite

COPY ./wordpress $WORDPRESS_HOME

RUN chown -R www-data:www-data $WORDPRESS_HOME

CMD ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]