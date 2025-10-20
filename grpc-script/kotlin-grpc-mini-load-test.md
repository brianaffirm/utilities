# Mini Load Test for test-kotlin-dt for grpc endpoint


1. scc -r us-east-1 -c stage-live-main
2. ssh into a pod, choose one that is not grpc
3. kubectl get pods -n test-kotlin-dt | grep test-kotlin-dt-rpc
4. kubectl -n test-kotlin-dt exec -it test-kotlin-dt-rpc-6cdb77654c-wtx2m -c app -- bash
5. apt install vim
6. vim example.proto
7. paste the content of the `example.proto` from this repo into the newly created file
8. vim mini_load_test.sh
9. paste the content of `mini_grpc_load_test.sh` from this repo into the newly created file
10. chmod +x mini_load_test.sh
11. ./mini_load_test.sh 1000 20

repeat this in another k8s pod to have higher load