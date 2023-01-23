# rm -rf ~/.kube/config
# aws eks --region ap-south-1 update-kubeconfig --name eks --profile terraform2
kubectl create secret generic ecart-secret --from-env-file=ecart-secrets
# kubectl describe secret ecart-secret
kubectl apply -f app.yaml
# kubectl get pods
# kubectl get svc
# kubectl describe svc external-ecart-service
# kubectl get node -o wide