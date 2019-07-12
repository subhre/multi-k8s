docker build -t subhre/multi-client:latest -t subhre/multi-client:$GIT_SHA -f ./client/Dockerfile ./client
docker build -t subhre/multi-server:latest -t subhre/multi-server:$GIT_SHA -f ./server/Dockerfile ./server
docker build -t subhre/multi-worker:latest -t subhre/multi-worker:$GIT_SHA -f ./worker/Dockerfile ./worker

docker push subhre/multi-client:latest
docker push subhre/multi-server:latest
docker push subhre/multi-worker:latest

docker push subhre/multi-client:$GIT_SHA
docker push subhre/multi-server:$GIT_SHA
docker push subhre/multi-worker:$GIT_SHA

kubectl apply -f k8s

kubectl set image deployments/client-deployment client=subhre/multi-client:$GIT_SHA
kubectl set image deployments/server-deployment server=subhre/multi-server:$GIT_SHA
kubectl set image deployments/worker-deployment worker=subhre/multi-worker:$GIT_SHA
