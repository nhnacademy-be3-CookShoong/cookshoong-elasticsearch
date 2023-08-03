docker stop $(docker ps -a -q)

docker-compose -f docker-compose-sub.yml up