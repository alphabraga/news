FROM php:8.2-apache

#Dependências que Codeigniter precisa para funcionar
RUN apt-get update -y && apt-get install -y libpng-dev ca-certificates curl libzip-dev zip

RUN apt-get install -y build-essential libssl-dev zlib1g-dev libpng-dev libjpeg-dev libfreetype6-dev

#Dependências que Codeigniter precisa para funcionar
RUN \
    docker-php-ext-configure pdo_mysql --with-pdo-mysql=mysqlnd \
    && docker-php-ext-configure mysqli --with-mysqli=mysqlnd \
    && docker-php-ext-install pdo_mysql \ 
    && docker-php-ext-install mysqli \
    && docker-php-ext-install zip

#Dependências que Codeigniter precisa para funcionar
RUN apt-get update && \
    apt-get install -y -qq git \
        libjpeg62-turbo-dev \
        apt-transport-https \
        libfreetype6-dev \
        libmcrypt-dev \
        libssl-dev \
        unzip



#Removendo o limite de memoria para o ambinete de dev
RUN cd /usr/local/etc/php/conf.d/ && \
  echo 'memory_limit = -1' >> /usr/local/etc/php/conf.d/docker-php-memlimit.ini

#Guardando os logs de erro nesse arquivo
RUN cd /usr/local/etc/php/conf.d/ && \
  echo 'log_errors = On' >> /usr/local/etc/php/conf.d/docker-php-log_errors.ini  

#Faendo q=com que o cache tenha um lifetime
RUN cd /usr/local/etc/php/conf.d/ && \
  echo 'session.cache_expire = 1' >> /usr/local/etc/php/conf.d/docker-cache_expire.ini  

#Esse trecho esta comemntado mas em breve vamos remover os comantarios eu quero o xdebug funcionando corretamente
RUN yes | pecl install xdebug-3.1.5 ast-1.1.0 \
    && echo "zend_extension=$(find /usr/local/lib/php/extensions/ -name xdebug.so)" > /usr/local/etc/php/conf.d/xdebug.ini \
    && echo "xdebug.remote_enable=on" >> /usr/local/etc/php/conf.d/xdebug.ini \
    && echo "xdebug.remote_autostart=off" >> /usr/local/etc/php/conf.d/xdebug.ini \
    && echo "xdebug.var_display_max_depth = -1 " >> /usr/local/etc/php/conf.d/xdebug.ini \ 
    && echo "xdebug.var_display_max_children = -1" >> /usr/local/etc/php/conf.d/xdebug.ini \
    && echo "xdebug.var_display_max_data = -1 " >> /usr/local/etc/php/conf.d/xdebug.ini

RUN docker-php-ext-enable ast

# Instalando o composer para gerenciar as depencias do projeto PHP
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Copiando os arquivos do diretório corrente para a pasta html do apache
COPY . /var/www/html

# Definindo esse diretorio html como o diretorio corrente
WORKDIR /var/www/html

# Vamos expor a porta 80 do apache para a maquina host
EXPOSE 80

# Iniciando o apache
CMD ["apache2-foreground"]