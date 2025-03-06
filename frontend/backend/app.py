from flask import Flask, request, jsonify
from flask_cors import CORS
import psycopg2
import pandas as pd
from datetime import datetime, timedelta
import numpy as np

# Initialize Flask app
app = Flask(__name__)
CORS(app)

# PostgreSQL Configuration
POSTGRES_USER = "postgres"
POSTGRES_PASSWORD = "1234"
POSTGRES_DB = "stock_db"
POSTGRES_HOST = "20.241.222.32"
POSTGRES_PORT = "5432"

# Establish connection to PostgreSQL
def get_db_connection():
    return psycopg2.connect(
        database=POSTGRES_DB,
        user=POSTGRES_USER,
        password=POSTGRES_PASSWORD,
        host=POSTGRES_HOST,
        port=POSTGRES_PORT
    )

# Endpoint to fetch stock symbols
@app.route('/symbols', methods=['GET'])
def get_symbols():
    connection = get_db_connection()
    cursor = connection.cursor()
    cursor.execute("SELECT DISTINCT symbol FROM stock_data;")
    symbols = [row[0] for row in cursor.fetchall()]
    cursor.close()
    connection.close()
    return jsonify({'symbols': symbols})

# Endpoint to fetch stock data
@app.route('/data', methods=['GET'])
def get_data():
    symbol = request.args.get('symbol')
    if not symbol:
        return jsonify({"error": "Symbol is required"}), 400

    end_date = datetime.now() - timedelta(days=1)
    start_date = end_date - timedelta(days=30)

    connection = get_db_connection()
    query = """
        SELECT timestamp, close
        FROM stock_data
        WHERE symbol = %s AND timestamp BETWEEN %s AND %s
        ORDER BY timestamp ASC
    """
    df = pd.read_sql(query, connection, params=(symbol, start_date, end_date))
    connection.close()

    if df.empty:
        return jsonify({"data": []})

    # Generate numeric representation for linear regression
    df['timestamp_numeric'] = (pd.to_datetime(df['timestamp']) - pd.to_datetime(df['timestamp']).min()).dt.days
    coef = np.polyfit(df['timestamp_numeric'], df['close'], 1)
    trend = np.poly1d(coef)(df['timestamp_numeric'])

    response_data = [
        {"timestamp": str(ts), "close": close, "trend": tr}
        for ts, close, tr in zip(df['timestamp'], df['close'], trend)
    ]
    return jsonify({"data": response_data})

# Run Flask app
if __name__ == '__main__':
    app.run(host = '0.0.0.0', port = 5000)