#!/bin/bash
while getopts n:p:m:o: flag
do
  case "${flag}" in
    n) network=${OPTARG};;
    p) pmaport=${OPTARG};;
    m) mariaport=${OPTARG};;
    o) marianame=${OPTARG};;
  esac
done

docker build -t mariadb .
docker network create $network
docker run -d --network $network -p $mariaport:3306 --name $marianame --restart=always mariadb
docker run -d --network $network -p $pmaport:80 -e PMA_HOST=$marianame -e PMA_USER=myMariadbUser -e PMA_PASSWORD=myMariadbPassword --restart=always phpmyadmin
You have new mail in /var/mail/pi
