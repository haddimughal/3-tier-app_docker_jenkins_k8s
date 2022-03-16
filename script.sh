kubectl apply -f /var/lib/jenkins/workspace/3-tier-pipeline/kubemanifests.yaml
kubectl patch service gateway-tcp -n default -p '{"spec": {"type": "LoadBalancer", "externalIPs":["137.184.226.30"]}}'