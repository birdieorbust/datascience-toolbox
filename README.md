# datascience-toolbox
Container configuration for a custom data science environment. An image can be created, stored in a container registry and pulled when needed. Motivation for this was to create a portable environment with all my tools in.

This DockerFile is based on an inital miniconda image and contains the following software...

1. Miniconda (includes Jupyter) - environments can be configured in environment.yml
2. Vscode-server

The idea is that each pluggable notebook has it's own folder with an install script in which the main DockerFile can run. 

# Testing Locally

This will add the data and code folders from the repository to the container.

```bash
git clone https://github.com/birdieorbust/datascience-toolbox.git
cd datascience-toolbox
docker build -t datascience-toolbox:0.1 .
docker run -p 8888:8888 -p 8443:8443 -v $(pwd)/data:/data -v $(pwd)/code:/code --rm -it datascience-toolbox
```


# GCP Setup

## Push to Container Registry

Once building this file locally you can push to the Google Container Registry. This way we can use the container whenever we need it.

```bash
gcloud compute project-info add-metadata \
    --metadata google-compute-default-region=europe-west1,google-compute-default-zone=europe-west1-b
    
docker tag datascience-toolbox:0.1 gcr.io/[project-id]/datascience-toolbox:0.1
docker push gcr.io/[project-id]/datascience-toolbox:0.1
```

## Create Instance Template

We need to create an instance template that will pull and run the container adding the right network settings.

```bash
gcloud compute instances create-with-container sh-ds --container-image gcr.io/[project-id]/datascience-toolbox:0.1

gcloud beta compute instance-templates create-with-container \
      datascience-toolbox-instance-template              \
      --container-image=gcr.io/[project-id]/datascience-toolbox:0.1 \
      ----container-arg


```


## Create Kubernetes Cluster

```bash

gcloud conatiner clusters created datascience-toolbox-cluster
gcloud container clusters get-credentials datascience-toolbox-cluster
kubectl create deployment datascience-toolbox --image=gcr.io/[project-id]/datascience-toolbox:0.1
kubectl expose deployment datascience-toolbox --type=LoadBalancer --port 8443

```

