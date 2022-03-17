# This script is for Minikubes Service Loadbalancer Patch
kubectl patch service gateway-tcp -n default -p '{"spec": {"type": "LoadBalancer", "externalIPs":["137.184.226.30"]}}'