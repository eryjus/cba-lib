FROM    gitpod/workspace-full


##
## -- Set up the environment for a Docker build
##    -----------------------------------------
USER    root
RUN     apt-get update 
RUN     apt-get install debconf-utils -y -q
ENV     DEBIAN_FRONTEND=noninteractive


##
## -- Install the Oracle Repo for MySQL
##    ---------------------------------
USER    root
RUN     wget https://dev.mysql.com/get/mysql-apt-config_0.8.13-1_all.deb -O /usr/mysql-apt-config_0.8.13-1_all.deb \
  &&    echo 4 | dpkg -i /usr/mysql-apt-config_0.8.13-1_all.deb \
  &&    rm /usr/mysql-apt-config_0.8.13-1_all.deb
RUN     apt-get update 


##
## -- Install MySQL server on top of the basic Docker Container
##    ---------------------------------------------------------
USER    root
RUN     apt-get install mysql-server mysql-shell -y -q


##
## -- Freshen up all the other packages just in case
##    ----------------------------------------------
USER    root
RUN     apt-get upgrade -y -q


##
## -- Now, we need to prepare for MySQL
##    ---------------------------------
USER    root
RUN     mkdir /var/run/mysqld 
RUN     chown -R gitpod:gitpod /etc/mysql /var/run/mysqld /var/log/mysql /var/lib/mysql /var/lib/mysql-files /var/lib/mysql-keyring /var/lib/mysql-upgrade
COPY    mysql.cnf /etc/mysql/mysql.conf.d/mysqld.cnf
COPY    client.cnf /etc/mysql/mysql.conf.d/client.cnf
COPY    mysql-bashrc-launch.sh /etc/mysql/mysql-bashrc-launch.sh


##
## -- Set mysql to start under the gitpod user
##    ----------------------------------------
USER gitpod
RUN echo "/etc/mysql/mysql-bashrc-launch.sh" >> ~/.bashrc


##
## -- clean up and give control back for the IDE to run
##    -------------------------------------------------
RUN     apt-get clean
RUN     rm -rf /var/cache/apt/* /var/lib/apt/lists/* /tmp/* 
USER    root

