echo "[client]
user=cookshoong
password='d4@]UGI)iVXa/kG6'
host=133.186.244.96" > /home/shoong/.my.cnf

chmod 600 /home/shoong/.my.cnf

mysql -Dcookshoong_shop_prod -B --skip-column-names -e"SELECT word_dict.word_text FROM cookshoong_shop_prod.word_dict;" > /home/shoong/cookshoong-elasticsearch/elasticsearch/config/analysis/userdict.txt

mysql -Dcookshoong_shop_prod -B --skip-column-names -e"SELECT CONCAT(word_dict.word_text, ',', GROUP_CONCAT(wd.word_text ORDER BY wd.word_id)) as words
                               FROM cookshoong_shop_prod.word_dict
                               JOIN cookshoong_shop_prod.synonym_dict ON word_dict.word_id = synonym_dict.basic_word_id
                               JOIN cookshoong_shop_prod.word_dict AS wd ON wd.word_id = synonym_dict.synonym_word_id
                               GROUP BY word_dict.word_id;" > /home/shoong/cookshoong-elasticsearch/elasticsearch/config/analysis/synonym.txt

nodes=("es01" "es02" "es03")

for node in "${nodes[@]}"; do
  echo "Stopping $node..."
  docker stop $node

  echo "Starting $node..."
  docker start $node

  sleep 30
done

echo "Elasticsearch nodes update completed."