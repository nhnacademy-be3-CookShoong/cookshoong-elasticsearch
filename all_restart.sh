docker stop $(docker ps -a -q)

docker rm $(docker ps -a -q)

docker rmi $(docker images -q)

docker volume rm $(docker volume ls)

echo "[client]
user=cookshoong
password='d4@]UGI)iVXa/kG6'
host=133.186.244.96" > /home/shoong/.my.cnf

chmod 600 /home/shoong/.my.cnf

mysql -Dcookshoong_shop_dev -B --skip-column-names -e"SELECT word_dict.word_text FROM cookshoong_shop_dev.word_dict;" > /home/shoong/cookshoong-elasticsearch/elasticsearch/config/analysis/userdict.txt

mysql -Dcookshoong_shop_dev -B --skip-column-names -e"SELECT CONCAT(word_dict.word_text, ',', GROUP_CONCAT(wd.word_text ORDER BY wd.word_id)) as words
                               FROM cookshoong_shop_dev.word_dict
                               JOIN cookshoong_shop_dev.synonym_dict ON word_dict.word_id = synonym_dict.basic_word_id
                               JOIN cookshoong_shop_dev.word_dict AS wd ON wd.word_id = synonym_dict.synonym_word_id
                               GROUP BY word_dict.word_id;" > /home/shoong/cookshoong-elasticsearch/elasticsearch/config/analysis/synonym.txt

docker-compose up --build

until $(curl --output /dev/null --silent --head --fail http://kibana:5601); do
  printf 'Waiting for Kibana...\n'
  sleep 5
done

# Index Pattern 생성
curl -X POST "http://kibana:5601/api/saved_objects/index-pattern/my_index_pattern" \
    -H "Content-Type: application/json" \
    -H "kbn-version: 7.17.10" \ # Kibana 버전에 맞게 수정
    -d '{
      "attributes": {
        "title": "store*"
      }
    }'