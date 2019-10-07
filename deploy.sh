docker build  -t andrey1961/multi-client:latest -t andrey1961/multi-client:$SHA -f ./client/Dockerfile ./client
docker build  -t andrey1961/multi-server:latest -t andrey1961/multi-server:$SHA-f ./server/Dockerfile ./server
docker build  -t andrey1961/multi-worker:latest -t andrey1961/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push andrey1961/multi-client:latest
docker push andrey1961/multi-server:latest
docker push andrey1961/multi-worker:latest

docker push andrey1961/multi-client:$SHA
docker push andrey1961/multi-server:$SHA
docker push andrey1961/multi-worker:$SHA


kubectl apply -f k8s
kubectl set image deployments/server-deployment server=andrey1961/multi-server:$SHA
kubectl set image deployments/client-deployment client=andrey1961/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=andrey1961/multi-worker:$SHA
