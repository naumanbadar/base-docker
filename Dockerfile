FROM ubuntu:16.04

# set correct time zone. In my case it is Stockholm. This is a temporary fix until docker fixes the issue of always getting container with UTC timezone.
ENV TZ=Europe/Stockholm
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone \

# some usefull command aliases
&& echo "alias ll='ls -la'" >> /root/.bashrc \
&& echo "alias l=ls" >> /root/.bashrc \

#  default openjdk
#~~~~~~~~~~~~~~~~~
&& apt-get update \
&& apt-get install -y default-jdk \


# curl for installation of other tools later
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
&& apt-get update \
&& apt-get install -y curl \

# ping for checking connectivity in docker-compose between containers
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
&& apt-get update \
&& apt-get install -y iputils-ping \

# sbt
#~~~~

# this is required otherwise it will give the error 'E: The method driver /usr/lib/apt/methods/https could not be found.'
# when trying to install sbt in next step.
&& apt-get update \
&& apt-get install -y apt-transport-https \
# now install sbt as per intructions on its website.
&& echo "deb https://dl.bintray.com/sbt/debian /" | tee -a /etc/apt/sources.list.d/sbt.list \
&& apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 2EE0EA64E40A89B84B2DF73499E82A75642AC823 \
&& apt-get update \
&& apt-get install -y sbt

WORKDIR project
