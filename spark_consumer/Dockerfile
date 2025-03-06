FROM bitnami/spark:latest

# Set working directory
WORKDIR /app

# Copy all necessary files into the container
COPY . .

# Install Python dependencies
RUN pip install pyspark kafka-python psycopg2-binary pandas

# Download required Kafka connector JARs for Spark
RUN curl -o /opt/bitnami/spark/jars/spark-sql-kafka-0-10_2.12-3.3.0.jar https://repo1.maven.org/maven2/org/apache/spark/spark-sql-kafka-0-10_2.12/3.3.0/spark-sql-kafka-0-10_2.12-3.3.0.jar \
 && curl -o /opt/bitnami/spark/jars/kafka-clients-2.8.0.jar https://repo1.maven.org/maven2/org/apache/kafka/kafka-clients/2.8.0/kafka-clients-2.8.0.jar \
 && curl -o /opt/bitnami/spark/jars/spark-token-provider-kafka-0-10_2.12-3.3.0.jar https://repo1.maven.org/maven2/org/apache/spark/spark-token-provider-kafka-0-10_2.12/3.3.0/spark-token-provider-kafka-0-10_2.12-3.3.0.jar

# Run the consumer script and keep the container alive for debugging
CMD ["sh", "-c", "spark-submit --master local[*] --packages org.apache.spark:spark-sql-kafka-0-10_2.12:3.3.0 /app/spark_consumer.py || tail -f /dev/null"]