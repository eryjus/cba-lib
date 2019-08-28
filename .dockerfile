FROM gitpod/workspace-full


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
#RUN echo 'mysql-community-server mysql-community-server/root-pass password password' | debconf-set-selections
#RUN echo 'mysql-community-server mysql-community-server/re-root-pass password password' | debconf-set-selections
#RUN echo 'mysql-community-server mysql-server/default-auth-override select Use Legacy Authentication Method (Retain MySQL 5.x Compatibility)' | debconf-set-selections
RUN DEBIAN_FRONTEND=noninteractive apt-get install mysql-server mysql-shell -y -q
RUN DEBIAN_FRONTEND=noninteractive apt-get upgrade -y -q

## -- start mysql
VOLUME /var/lib/mysql
CMD ["mysqld"]


##
## -- give control back for the IDE to run
##    ------------------------------------
USER root

