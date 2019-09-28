# datascience-toolbox
Container configuration for a custom data science environment.


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



