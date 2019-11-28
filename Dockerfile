# the base miniconda3 image
FROM continuumio/miniconda3:latest

MAINTAINER Sam Hall <sam.dc.hall@gmail.com>

# load in the environment.yml file - this file controls what Python packages we install in the what virtual environments
# by default it has a base environment
ADD environment.yml /

# install the Python packages we specified into the base environment
RUN conda update -n base conda -y && conda env update

#install vscode server
COPY vscode/install.sh /usr/local/bin
RUN chmod 755 /usr/local/bin/install.sh
RUN /usr/local/bin/install.sh


#copy the docker-entrypoint 
COPY docker-entrypoint.sh /usr/local/bin/

#make docker-entrypoint.sh executable
RUN chmod 755 /usr/local/bin/docker-entrypoint.sh

#any code that is in the code folder of the repository will be copied to the container
ADD ./code /code
#ADD ./data /data

# call the entrypoint script with no arguments
ENTRYPOINT ["docker-entrypoint.sh"]
