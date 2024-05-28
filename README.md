# Cat and Dog Classifier using a Docker
A Docker Image contains a model that classifies images as Cat or Dog, along with a probability, is hosted on GCP. A Flutter app is used to send HTTP GET and POST requests to this URL.

## Demo

https://github.com/VelvetThunder1/Cat-Dog-Classifier-Flutter-GCP-Hosted/assets/74422927/4f5e3af0-5296-4813-9b04-9b77e2e03ab9


## Instructions 

1. go to google cloud console at https://console.cloud.google.com/
2. open navigation menu on left side
3. click on "cloud run"
4. click on "create service"
5. enter container image url, such as "velvett/cat-dog-classifier-using-flask:latest"
6. set "Authentication" to "Allow unauthorized invocations"
7. expand "Container(s), Volumes, Networking, Security"
8. change container port to "5000"
9. set memory to 4 GiB
10. set maximum number of instances, under "Revision autoscaling", to 5
11. click "create"
12. in the service's page, copy the url at the top, next to region, ex. if it shows "URL: https://cat-dog-classifier-using-flask-xisi3zlsna-uc.a.run.app", copy "https://cat-dog-classifier-using-flask-xisi3zlsna-uc.a.run.app"
13. in a new tab, paste the url, followed by "/upload", ex. "https://cat-dog-classifier-using-flask-xisi3zlsna-uc.a.run.app/upload"

## Resources
H5 model link: https://huggingface.co/spaces/Sa-m/Dogs-vs-Cats/blob/main/best_model.h5

Docker Hub Page: https://hub.docker.com/repository/docker/velvett/cat-dog-classifier-using-flask/general

GCP URL: https://cat-dog-classifier-using-flask-xisi3zlsna-el.a.run.app/upload
