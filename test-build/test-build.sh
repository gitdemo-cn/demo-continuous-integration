#!/bin/sh
cd ${WORKSPACE}/src
docker build -t rancherapps.com:5000/python-redis-demo:b${BUILD_NUMBER} .
docker push rancherapps.com:5000/python-redis-demo:b${BUILD_NUMBER}

cd ${WORKSPACE}/test-build
sed -i 's/\$\$BUILD_NUMBER\$\$/'${BUILD_NUMBER}'/g' docker-compose.yml
sed -i 's/\$\$PORT_NUMBER\$\$/'`expr 5000 + ${BUILD_NUMBER}`'/g' docker-compose.yml

rancher-compose --url http://rancherapps.com:8080 --access-key 8D3DF61DCC31774310CF --secret-key L5qR1bqcuyBxv1M9jVUMPo8tsATBosnzQ9KYUixx -p Demo-Continuous-Integration-Build${BUILD_NUMBER} up -d

