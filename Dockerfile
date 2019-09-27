#Start with the miniconda base which uses alpine linxu
#https://github.com/ContinuumIO/docker-images/blob/master/miniconda3/alpine/Dockerfile
########################
#BASE CONDA & PYTHON3
########################
FROM continuumio/miniconda:3:latest

LABEL maintainer="Sam Hall <sam.dc.hall@gmail.com>"

ENV PATH /opt/conda/envs/venv/bin:${PATH}

# load in the environment.yml file - this file controls what Python packages we install
ADD environment.yml /

# install the Python packages we specified into the base environment
RUN conda update -n base conda -y && conda env update

COPY docker-entrypoint.sh /usr/local/bin/
 
ENTRYPOINT ["docker-entrypoint.sh"]