docker build -t mersock/simple-k8s-client -f ./client/Dockerfile ./client
docker build -t mersock/simple-k8s-server -f ./server/Dockerfile ./server
docker build -t mersock/simple-k8s-worker -f ./worker/Dockerfile ./worker
docker push mersock/simple-k8s-client 
docker push mersock/simple-k8s-server 
docker push mersock/simple-k8s-worker
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=mersock/simple-k8s-server