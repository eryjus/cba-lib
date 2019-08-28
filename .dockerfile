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
VOLUME  /var/lib/mysql
#RUN     chown +R gitpod:gitpod /var/lib/mysql


##
## -- give control back for the IDE to run
##    ------------------------------------
USER    root

