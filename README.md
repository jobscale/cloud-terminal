# Cloud Console with Web

## Deployment

```
kubectl create deployment cloud-terminal --image jobscale/cloud-terminal
kubectl expose deployment cloud-terminal --name cloud-terminal --type LoadBalancer --port 80 --target-port 3000
open https://127.0.0.1/wetty/ # user: buster password: buster
passwd # change password required
```

## GCP login
```
gcloud init
[[ ! -s ~/.kube ]] && mkdir ~/.kube
ln -sfn ~/.kube/config-gke ~/.kube/config
gcloud container clusters get-credentials ${CLUSTER_NAME} --project ${PROJECT_ID}
```

## Azure login
```
az login
[[ ! -s ~/.kube ]] && mkdir ~/.kube
ln -sfn ~/.kube/config-aks ~/.kube/config
az aks get-credentials --resource-group ${RESOURCE_GROUP} --name ${CLUSTER_NAME}
```

## AWS login
```
aws configure
[[ ! -s ~/.kube ]] && mkdir ~/.kube
ln -sfn ~/.kube/config-eks ~/.kube/config
aws eks update-kubeconfig --name ${CLUSTER_NAME}
```
