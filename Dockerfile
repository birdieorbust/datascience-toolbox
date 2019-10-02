# the base miniconda3 image
FROM continuumio/miniconda3:latest

MAINTAINER Sam Hall <sam.dc.hall@gmail.com>

# load in the environment.yml file - this file controls what Python packages we install in the what virtual environments
# by default it has a base environment
ADD environment.yml /

# install the Python packages we specified into the base environment
RUN conda update -n base conda -y && conda env update

#install R env with RStudio Server
RUN apt-get update && apt-get install -y r-base psmisc gdebi-core \
    && wget https://download2.rstudio.org/server/bionic/amd64/rstudio-server-1.2.5001-amd64.deb \
    && gdebi --non-interactive rstudio-server-1.2.5001-amd64.deb

# download the coder binary, untar it, and allow it to be executed
RUN wget https://github.com/codercom/code-server/releases/download/1.1156-vsc1.33.1/code-server1.1156-vsc1.33.1-linux-x64.tar.gz \
    && tar -xzvf code-server1.1156-vsc1.33.1-linux-x64.tar.gz && chmod +x code-server1.1156-vsc1.33.1-linux-x64/code-server

# copy configs
COPY config/rserver.conf /etc/rstudio/rserver.conf

# copy the docker-entrypoint 
COPY docker-entrypoint.sh /usr/local/bin/

# make docker-entrypoint.sh executable
RUN chmod 755 /usr/local/bin/docker-entrypoint.sh

# any code that is in the code folder of the repository will be copied to the container
ADD ./code /code

#Setup Rstudio User
RUN echo "creating new rstudio" \
    && useradd -m rstudio \
    && echo "rstudio:rstudio" | chpasswd \
    && chown -R rstudio /home/rstudio \
    && usermod -a -G staff rstudio \
    && adduser rstudio sudo \
    && echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers \
    && echo "rstudio added to sudoers"

# call the entrypoint script with no arguments
ENTRYPOINT ["docker-entrypoint.sh"]
