FROM gitpod/workspace-full

ARG MYSQL_SERVER_PACKAGE=mysql-community-server-minimal-8.0.17
ARG MYSQL_SHELL_PACKAGE=mysql-shell-8.0.17

##
## -- Install MySQL server on top of the basic Docker Container
##    ---------------------------------------------------------
USER root

## -- get the apt repo
RUN wget https://dev.mysql.com/get/mysql-apt-config_0.8.13-1_all.deb -O /usr/mysql-apt-config_0.8.13-1_all.deb \
  && echo 4 | dpkg -i /usr/mysql-apt-config_0.8.13-1_all.deb \
  && rm /usr/mysql-apt-config_0.8.13-1_all.deb
  
## -- install mysql
RUN apt-get update 
RUN echo 'mysql-community-server mysql-community-server/root-pass password root' | debconf-set-selections
RUN echo 'mysql-community-server mysql-community-server/re-root-pass password root' | debconf-set-selections
RUN echo 'mysql-community-server mysql-server/default-auth-override select Use Legacy Authentication Method (Retain MySQL 5.x Compatibility)' | debconf-set-selections
RUN apt-get install mysql-server mysql-shell -y
RUN apt-get upgrade -y
  
## RUN apt-key adv --keyserver pgp.mit.edu --recv-keys 5072E1F5                           
# RUN apt-get -y install https://dev.mysql.com/get/mysql-apt-config_0.8.13-1_all.deb   
# RUN echo "deb http://repo.mysql.com/apt/ubuntu/ disco mysql-8.0" >  /etc/apt/sources.list.d/mysql.list 


# give control back for the IDE to run
USER root
