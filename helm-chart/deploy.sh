### Local Setup #### 
helm uninstall dataflow-studio -n dataflow-studio
kubectl delete namespace dataflow-studio
helm upgrade --install  dataflow-studio  . -n dataflow-studio --create-namespace -f values.yaml -f environments/local.yaml
kubectl config set-context --current --namespace=dataflow-studio
kubectl get all