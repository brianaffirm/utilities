# utilities

vim Dockerfile.grpcurl
AWS_PROFILE=affirm-stage aws ecr create-repository --region us-east-1 --repository-name test-kotlin-dt/grpcurl || true
docker tag grpcurl:1.8.6 448435121187.dkr.ecr.us-east-1.amazonaws.com/test-kotlin-dt/grpcurl:1.8.6
docker push 448435121187.dkr.ecr.us-east-1.amazonaws.com/test-kotlin-dt/grpcurl:1.8.6