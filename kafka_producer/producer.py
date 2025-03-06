import requests
import json
import time
import logging
from datetime import datetime, timedelta
from kafka import KafkaProducer

# Alpha Vantage API Configuration
ALPHA_VANTAGE_API_KEY = "T8AV36ZSFOL48C9A"
BASE_URL = "https://www.alphavantage.co/query"
STOCK_SYMBOLS = [
    'AAPL', 'MSFT', 'GOOGL', 'AMZN', 'TSLA', 'META', 'NVDA', 'BRK-B', 'JPM', 'JNJ'
]

# Kafka Configuration
KAFKA_TOPIC = "stock_data"
BROKER = "kafka:9092"  

# Configure Logging
logging.basicConfig(level=logging.INFO, format="%(asctime)s - %(levelname)s - %(message)s")

# Initialize Kafka Producer
producer = KafkaProducer(
    bootstrap_servers=BROKER,
    value_serializer=lambda v: json.dumps(v).encode("utf-8")
)

def fetch_historical_stock_data(symbol):
    """Fetch historical stock data for the past month from Alpha Vantage API."""
    params = {
        "function": "TIME_SERIES_DAILY",
        "symbol": symbol,
        "apikey": ALPHA_VANTAGE_API_KEY,
        "outputsize": "compact"
    }

    try:
        response = requests.get(BASE_URL, params=params)
        data = response.json()
        
        if "Time Series (Daily)" in data:
            daily_data = data["Time Series (Daily)"]

            # Filter only the last 30 days
            end_date = datetime.today()
            start_date = end_date - timedelta(days=30)

            stock_data = []
            for date_str in sorted(daily_data.keys(), reverse=True):
                date_obj = datetime.strptime(date_str, "%Y-%m-%d")
                if start_date <= date_obj <= end_date:
                    day_data = daily_data[date_str]
                    stock_data.append({
                        "timestamp": date_str,
                        "symbol": symbol,
                        "open": float(day_data["1. open"]),
                        "high": float(day_data["2. high"]),
                        "low": float(day_data["3. low"]),
                        "close": float(day_data["4. close"]),
                        "volume": int(day_data["5. volume"])
                    })

            return stock_data
        else:
            logging.warning(f"⚠️ No valid data found for {symbol}. API Response: {data}")
            return []
    except Exception as e:
        logging.error(f"❌ Error fetching data for {symbol}: {str(e)}")
        return []

# Fetch historical data and send to Kafka
for symbol in STOCK_SYMBOLS:
    historical_data = fetch_historical_stock_data(symbol)
    
    if historical_data:
        for record in historical_data:
            producer.send(KAFKA_TOPIC, record)
            logging.info(f"✅ Sent data to Kafka: {record}")
            time.sleep(1)  # Small delay to simulate real-time streaming
    else:
        logging.warning(f"⚠️ No historical data available for {symbol}")

# Close Kafka Producer
producer.close()
logging.info("✅ Producer has successfully completed execution.")