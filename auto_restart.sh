docker stop $(docker ps -a -q)

docker rm $(docker ps -a -q)

docker-compose up

while true; do
    response=$(curl --write-out '%{http_code}' --silent --output /dev/null "http://localhost:9200")
    if [ "$response" -eq "200" ]; then
        echo "Elasticsearch is ready!"
        break
    else
        echo "Waiting for Elasticsearch..."
        sleep 5
    fi
done

curl -X DELETE "localhost:9200/store"