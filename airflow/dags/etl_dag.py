from airflow import DAG
from airflow.operators.bash import BashOperator
from datetime import datetime, timedelta

default_args = {
    "owner": "airflow",
    "depends_on_past": False,
    "start_date": datetime(2024, 2, 1),
    "retries": 1,
    "retry_delay": timedelta(minutes=5),
}

dag = DAG(
    "stock_market_etl",
    default_args=default_args,
    schedule_interval="0 9 * * *"
)

extract_task = BashOperator(
    task_id="extract_stock_data",
    bash_command="python '/app/producer.py'",
    dag=dag,
)

transform_task = BashOperator(
    task_id="transform_stock_data",
    bash_command="spark-submit --packages org.apache.spark:spark-sql-kafka-0-10_2.12:3.3.0 --jars spark-sql-kafka-0-10_2.12-3.3.0.jar '/app/spark_consumer.py'",
    dag=dag,
)

extract_task >> transform_task