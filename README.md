# datascience-toolbox
Container configuration for a custom data science environment. An image can be created, stored in a container registry and pulled when needed. Motivation for this was to create a portable environment with all my tools in.

This DockerFile is based on an inital miniconda image and contains the following software...

1. Miniconda - environments can be configured in environment.yml
2. Vscode-server
3. Rstudio Server

The idea is that each pluggable notebook has it's own folder with an install script in which the main DockerFile can run. 

#Testing Locally

```bash
git clone {{repo}}
cd {{repo}}
docker build -t sh-ds .
docker run -p 8888:8888 -p 8443:8443 -v $(pwd)/data:/data -v $(pwd)/code:/code --rm -it sh-ds

```


#Setup
##Set default compute zone as London
gcloud compute project-info add-metadata \
    --metadata google-compute-default-region=europe-west1,google-compute-default-zone=europe-west1-b

##Build initial image
git clone {{repo}}
docker build -t sh-ds:0.1 .

##Tag and store on Google Cloud Registry
docker tag sh-ds:0.1 gcr.io/[project-id]/sh-ds:0.1
docker push gcr.io/[project-id]/sh-ds:0.1

##Set up 


##Deploy on Google Compute Engine

gcloud compute instances create-with-container sh-ds \
     --container-image gcr.io/[project-id]/sh-ds:0.1

gcloud compute firewall-rules create allow-http \
> --target-tags https-server \
> --allow tcp:8888

