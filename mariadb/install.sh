#!/bin/bash
while getopts n:p: flag
do
  case "${flag}" in
    n) network=${OPTARG};;
    p) pmaport=${OPTARG};;
  esac
done

docker build -t mariadb .
docker network create $network
docker run -d --network $network -p 3306:3306 --restart=always mariadb
docker run -d --network $network -p $pmaport:80 --restart=always phpmyadmin
