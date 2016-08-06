# Builds a docker gui image
#FROM hurricane/dockergui:xvnc
FROM hurricane/dockergui:x11rdp1.3

#########################################
##        ENVIRONMENTAL CONFIG         ##
#########################################

# Set environment variables

# User/Group Id gui app will be executed as default are 99 and 100
ENV USER_ID=99
ENV GROUP_ID=100

# Gui App Name default is "GUI_APPLICATION"
ENV APP_NAME="MediaElch"

# Default resolution, change if you like
ENV WIDTH=1280
ENV HEIGHT=720

ENV TERM="xterm"

# Use baseimage-docker's init system
CMD ["/sbin/my_init"]

RUN \
#########################################
##    REPOSITORIES AND DEPENDENCIES    ##
#########################################
echo 'deb http://archive.ubuntu.com/ubuntu trusty main universe restricted' > /etc/apt/sources.list && \
echo 'deb http://archive.ubuntu.com/ubuntu trusty-updates main universe restricted' >> /etc/apt/sources.list

#########################################
##          GUI APP INSTALL            ##
#########################################

# Install steps for X app
ADD ./files/ /tmp/
RUN chmod +x /tmp/install/install.sh; sleep 1; /tmp/install/install.sh
#; sleep 1; rm -r /tmp/install

#########################################
##         EXPORTS AND VOLUMES         ##
#########################################

# Place whater volumes and ports you want exposed here:
VOLUME ["/config"]
EXPOSE 3389 8080