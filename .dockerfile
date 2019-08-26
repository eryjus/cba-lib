FROM gitpod/workspace-full

ARG MYSQL_SERVER_PACKAGE=mysql-community-server-minimal-8.0.17
ARG MYSQL_SHELL_PACKAGE=mysql-shell-8.0.17

##
## -- Install MySQL server on top of the basic Docker Container
##    ---------------------------------------------------------
USER root

RUN apt-key adv --keyserver pgp.mit.edu --recv-keys 5072E1F5                            \
    && apt-get -y install https://dev.mysql.com/get/mysql-apt-config_0.8.13-1_all.deb   \
    && echo deb http://repo.mysql.com/apt/ubuntu/ disco mysql-8.0 >  /etc/apt/sources.list.d/mysql.list \
    && apt-get update
    && apt-get upgrade
    && apt-get -y install $MYSQL_SERVER_PACKAGE



# give control back for the IDE to run
USER root
