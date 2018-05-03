#!/bin/sh
cd ${WORKSPACE}/src
docker build -t rancherapps.com:5000/python-redis-demo:b${BUILD_NUMBER} .
docker push rancherapps.com:5000/python-redis-demo:b${BUILD_NUMBER}

cd ${WORKSPACE}/test-build
sed -i 's/\$\$BUILD_NUMBER\$\$/'${BUILD_NUMBER}'/g' docker-compose.yml
sed -i 's/\$\$PORT_NUMBER\$\$/'`expr 5000 + ${BUILD_NUMBER}`'/g' docker-compose.yml

#!rancher-compose --url http://rancherapps.com:8080 --access-key 4DCAF192184584173F1C --secret-key 3NzEi7hia1DtGFsqgZdYEGELb2b7hq1UqxXys3fU -p Demo-CICD up -d --upgrade pyapp
rancher-compose --url http://rancherapps.com:8080 --access-key 4DCAF192184584173F1C --secret-key 3NzEi7hia1DtGFsqgZdYEGELb2b7hq1UqxXys3fU -p python-redis-demo-build${BUILD_NUMBER} up -d
