docker stop $(docker ps -a -q)

docker rm $(docker ps -a -q)

docker rmi $(docker images -q)

docker volume rm $(docker volume ls)

docker-compose -f docker-compose-sub.yml up