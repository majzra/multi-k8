docker build -t rabihmaj/multi-client:latest  -t rabihmaj/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t rabihmaj/multi-server:latest  -t rabihmaj/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t rabihmaj/multi-worker:latest  -t rabihmaj/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push rabihmaj/multi-client:latest
docker push rabihmaj/multi-server:latest
docker push rabihmaj/multi-worker:latest

docker push rabihmaj/multi-client:$SHA
docker push rabihmaj/multi-server:$SHA
docker push rabihmaj/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/client-deployment client=rabihmaj/multi-client:$SHA
kubectl set image deployments/server-deployment server=rabihmaj/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=rabihmaj/multi-worker:$SHA

