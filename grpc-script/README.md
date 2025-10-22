# Mini Load Test for test-kotlin-dt for grpc endpoint


1. `scc -r us-east-1 -c stage-live-main`
2. ssh into a `test-kotlin-dt` pod, choose one that is not grpc
3. `kubectl get pods -n test-kotlin-dt | grep test-kotlin-dt-rpc`
```bash
test-kotlin-dt-rpc-6cdb77654c-5xcq7                            3/3     Running            0              2d22h
test-kotlin-dt-rpc-6cdb77654c-wtx2m                            3/3     Running            0              4d11h
```
4. `kubectl -n test-kotlin-dt exec -it test-kotlin-dt-rpc-6cdb77654c-wtx2m -c app -- bash`
5. `apt install vim`
6.  install grpcurl
```bash
# 2a. check which architecture the pod is to figure out which grpcurl binary to install
dpkg --print-architecture
# 2b. install the proper grpcurl release https://github.com/fullstorydev/grpcurl/releases
curl -sSL "https://github.com/fullstorydev/grpcurl/releases/download/v1.8.6/grpcurl_1.8.6_linux_x86_64.tar.gz" | tar -xz -C /usr/local/bin
```
7. `vim example.proto`
8. paste the content of the `example.proto` from this repo into the newly created file
9. `vim mini_load_test.sh`
10. paste the content of `mini_grpc_load_test.sh` from this repo into the newly created file
11. `chmod +x mini_load_test.sh`
12. `./mini_load_test.sh 1000 20`

repeat this in another k8s pod to have higher load