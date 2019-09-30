# the base miniconda3 image
FROM continuumio/miniconda3:latest

# load in the environment.yml file - this file controls what Python packages we install in the what virtual environments
# by default it has a base environment
ADD environment.yml /

# install the Python packages we specified into the base environment
RUN conda update -n base conda -y && conda env update

# download the coder binary, untar it, and allow it to be executed
RUN wget https://github.com/codercom/code-server/releases/download/1.1156-vsc1.33.1/code-server1.1156-vsc1.33.1-linux-x64.tar.gz \
    && tar -xzvf code-server1.1156-vsc1.33.1-linux-x64.tar.gz && chmod +x code-server1.1156-vsc1.33.1-linux-x64/code-server

# copy the docker-entrypoint 
COPY docker-entrypoint.sh /usr/local/bin/

# any code that is in the code folder of the repository will be copied to the container
ADD ./code /code

# call the entrypoint script with no arguments
ENTRYPOINT ["docker-entrypoint.sh"]
