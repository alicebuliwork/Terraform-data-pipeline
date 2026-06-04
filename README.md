# Terraform-data-pipeline

1.cd into the terrform repo
2.in the root main.tf change the bucket_name according to ypur needs
3.run terraform init, and then terraform apply to create a s3 bucket, name space and a table

4.in the docker-compose repo create .env based on the .env-sample provided
5.then run the commad: docker compose up -d --build

6.use chmod +x to give exec permissions to the scripts
7.run the create-topic.sh script
8.run the create-connectors.sh script

 kafka-console-consumer \
   --bootstrap-server localhost:9092 \
    --topic cdc.public.orders \
    --from-beginning 

kafka-console-consumer \
  --bootstrap-server localhost:9092 \
  --topic cdc.public.orders \
  --from-beginning 2>/dev/null
  ![alt text](image.png)
docker exec -it postgres-cdc psql -U postgres -d ordersdb
SELECT * FROM orders;

docker exec -it broker /bin/bash
