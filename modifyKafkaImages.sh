#!/bin/bash

KAFKA_IMAGE_NAME='wurstmeister/kafka'
NEW_KAFKA_IMAGE_NAME='szczurmys/wurstmeister-kafka-with-nslookup'

kafkaTags=$(./dockertags.sh wurstmeister/kafka '(^[0-9]+\.[0-9]+-)|^latest$')

PUSH=${1:-noPush}
echo "PUSH options: ${PUSH}"

for tag in $kafkaTags
do
	kafkaNameWithTag=${KAFKA_IMAGE_NAME}:$tag
	newKafkaWithTag=${NEW_KAFKA_IMAGE_NAME}:$tag

	echo "PULL ORIGINAL IMAGE: ${kafkaNameWithTag}"
	docker pull ${kafkaNameWithTag}

	echo "PULL NEW IMAGE: ${newKafkaWithTag}"
	docker pull ${newKafkaWithTag}

	docker build --build-arg IMAGES="${kafkaNameWithTag}" -t ${newKafkaWithTag} .

	if [[ "${PUSH}" == "push" ]]; then
		echo "PUSH ${newKafkaWithTag}"
		docker push ${newKafkaWithTag}
	fi
done

