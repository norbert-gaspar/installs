#!/bin/bash
while getopts n:p:mp:mn: flag
do
  case "${flag}" in
    n) network=${OPTARG};;
    p) pmaport=${OPTARG};;
    mp) mariaport=${OPTARG};;
    mn) marianame=${OPTARG};;
  esac
done

docker build -t mariadb .
docker network create $network
docker run -d --network $network -p $mariaport:3306 --name $marianame --restart=always mariadb
docker run -d --network $network -p $pmaport:80 -e PMA_HOST=$marianame -e PMA_USER=myMariadbUser -e PMA_PASSWORD=myMariadbPassword --restart=always phpmyadmin
