from pyspark.sql import SparkSession
from pyspark.sql.functions import col, from_json
from pyspark.sql.types import StructType, StructField, StringType, DoubleType, IntegerType, TimestampType
import psycopg2

# Initialize Spark Session
spark = SparkSession.builder \
    .appName("KafkaStockConsumerOneTime") \
    .config("spark.jars.packages", "org.apache.spark:spark-sql-kafka-0-10_2.12:3.3.0") \
    .getOrCreate()

# Kafka Configuration
KAFKA_BROKER = "kafka:9092"
TOPIC_NAME = "stock_data"

# PostgreSQL Configuration
POSTGRES_USER = "postgres"
POSTGRES_PASSWORD = "1234"
POSTGRES_DB = "stock_db"
POSTGRES_HOST = "20.241.222.32"
POSTGRES_PORT = "5432"

# Define Schema for Incoming Kafka Messages
stock_schema = StructType([
    StructField("timestamp", StringType(), True),
    StructField("symbol", StringType(), True),
    StructField("open", DoubleType(), True),
    StructField("high", DoubleType(), True),
    StructField("low", DoubleType(), True),
    StructField("close", DoubleType(), True),
    StructField("volume", IntegerType(), True)
])

# Read Kafka Data (Single Batch)
df = spark.read.format("kafka") \
    .option("kafka.bootstrap.servers", KAFKA_BROKER) \
    .option("subscribe", TOPIC_NAME) \
    .option("startingOffsets", "earliest") \
    .option("endingOffsets", "latest") \
    .load()

# Parse Kafka Messages
stock_df = df.selectExpr("CAST(value AS STRING) as json_value")
stock_df = stock_df.withColumn("data", from_json(col("json_value"), stock_schema))

# Flatten JSON Fields
stock_df = stock_df.select(
    col("data.timestamp").cast(TimestampType()).alias("timestamp"),
    col("data.symbol").alias("symbol"),
    col("data.open").alias("open"),
    col("data.high").alias("high"),
    col("data.low").alias("low"),
    col("data.close").alias("close"),
    col("data.volume").alias("volume")
)

# Function to Insert Data into PostgreSQL
def write_to_postgres(df):
    if df.isEmpty():
        print("⚠️ No data to insert.")
        return

    connection = psycopg2.connect(
        database=POSTGRES_DB,
        user=POSTGRES_USER,
        password=POSTGRES_PASSWORD,
        host=POSTGRES_HOST,
        port=POSTGRES_PORT
    )
    cursor = connection.cursor()

    for row in df.collect():
        cursor.execute(
            """
            INSERT INTO stock_data (timestamp, symbol, open, high, low, close, volume)
            VALUES (%s, %s, %s, %s, %s, %s, %s)
            ON CONFLICT (timestamp, symbol) DO NOTHING
            """,
            (row.timestamp, row.symbol, row.open, row.high, row.low, row.close, row.volume)
        )

    connection.commit()
    cursor.close()
    connection.close()
    print(f"✅ Inserted {df.count()} records into PostgreSQL.")

# Process the Data
if stock_df.count() > 0:
    write_to_postgres(stock_df)
else:
    print("⚠️ No new data to process.")

# Stop Spark Session
spark.stop()
print("✅ Job finished, exiting.")