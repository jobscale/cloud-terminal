# Cloud Console with Web

## Deployment

```
kubectl create deployment cloud-console --image jobscale/cloud-console
kubectl expose deployment cloud-console --name cloud-console --type LoadBalancer --port 80 --target-port 80
open http://d.d.d.d/wetty/ # user: buster password: buster
chpasswd # required
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
