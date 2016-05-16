#!/bin/sh

# setup locale
BASH_PROFILE="/home/vagrant/.bash_profile"
echo "export LANGUAGE=ja_JP.UTF-8" >> "$BASH_PROFILE"
echo "export LANG=ja_JP.UTF-8" >> "$BASH_PROFILE"
echo "export LC_ALL=ja_JP.UTF-8" >> "$BASH_PROFILE"

# yum update
sudo yum -y update

# repos(epel)
sudo rpm -ivh http://ftp-srv2.kddilabs.jp/Linux/distributions/fedora/epel/6/x86_64/epel-release-6-8.noarch.rpm
# repos(remi)
sudo rpm -Uvh http://rpms.famillecollet.com/enterprise/remi-release-6.rpm
# repos(mysql)
sudo yum install -y http://dev.mysql.com/get/mysql-community-release-el6-5.noarch.rpm

# php packages
# sudo yum install -y --enablerepo=remi --enablerepo=remi-php55 php php-opcache php-devel php-mbstring php-mcrypt php-mysqlnd php-phpunit-PHPUnit php-pecl-xdebug php-pear php-xml php-pecl-apcu php-gd 
sudo yum install -y --enablerepo=remi --enablerepo=remi-php56 php php-mcrypt php-mbstring php-pdo php-mysqlnd php-tokenizer php-xml

# mysql packages
sudo yum install -y --enablerepo=epel openssl-devel perl-DBI libmcrypt-devel libaio libaio-devel
sudo yum install -y --enablerepo=mysql56-community mysql-community-server mysql-community-devel

# installation
sudo yum install -y httpd vim 

# composer
curl -s https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin/
mv /usr/local/bin/composer.phar /usr/local/bin/composer

# set document root
sudo rm -rf /var/www/html
sudo ln -fs /vagrant/lomd/public /var/www/html

# apache
sudo service httpd start
sudo chkconfig httpd on
# mysql 
sudo service mysqld start
sudo chkconfig mysqld on