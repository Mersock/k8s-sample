docker build -t mersock/simple-k8s-client:latest -t mersock/simple-k8s-client:$SHA -f ./client/Dockerfile ./client
docker build -t mersock/simple-k8s-server:latest -t mersock/simple-k8s-server:$SHA -f ./server/Dockerfile ./server
docker build -t mersock/simple-k8s-worker:latest -t mersock/simple-k8s-worker:$SHA -f ./worker/Dockerfile ./worker

docker push mersock/simple-k8s-client:latest 
docker push mersock/simple-k8s-server:latest 
docker push mersock/simple-k8s-worker:latest

docker push mersock/simple-k8s-client:$SHA 
docker push mersock/simple-k8s-server:$SHA 
docker push mersock/simple-k8s-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=mersock/simple-k8s-server:$SHA
kubectl set image deployments/client-deployment client=mersock/simple-k8s-client:$SHA
kubectl set image deployments/worker-deployment worker=mersock/simple-k8s-worker:$SHA