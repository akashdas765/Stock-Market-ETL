import React, { useEffect, useState } from 'react';
import axios from 'axios';
import { Line } from 'react-chartjs-2';
import {
  Container,
  Typography,
  MenuItem,
  Select,
  FormControl,
  InputLabel,
  Card,
  CardContent,
} from '@mui/material';
import { Chart, CategoryScale, LinearScale, PointElement, LineElement, Title, Tooltip, Legend } from 'chart.js';

// Register chart components
Chart.register(CategoryScale, LinearScale, PointElement, LineElement, Title, Tooltip, Legend);

const StockGraphApp = () => {
  const [symbols, setSymbols] = useState([]);
  const [selectedSymbol, setSelectedSymbol] = useState('');
  const [graphData, setGraphData] = useState(null);

  // Fetch symbols from backend
  useEffect(() => {
    axios.get('http://127.0.0.1:5000/symbols')
      .then((response) => {
        setSymbols(response.data.symbols);
      })
      .catch((error) => {
        console.error('Error fetching symbols:', error);
      });
  }, []);

  // Fetch stock data and trend line
  const fetchData = (symbol) => {
    axios.get(`http://127.0.0.1:5000/data?symbol=${symbol}`)
      .then((response) => {
        const data = response.data.data;
        const timestamps = data.map(item => item.timestamp);
        const closes = data.map(item => item.close);
        const trends = data.map(item => item.trend);

        setGraphData({
          labels: timestamps,
          datasets: [
            {
              label: `${symbol} Closing Prices`,
              data: closes,
              borderColor: 'rgba(75, 192, 192, 1)',
              fill: false,
              tension: 0.1,
            },
            {
              label: `${symbol} Trend Line`,
              data: trends,
              borderColor: 'rgba(255, 99, 132, 1)',
              borderDash: [5, 5], // Dashed trendline
              fill: false,
              tension: 0.1,
            }
          ]
        });
      })
      .catch((error) => {
        console.error('Error fetching stock data:', error);
      });
  };

  const handleSymbolChange = (event) => {
    const symbol = event.target.value;
    setSelectedSymbol(symbol);
    fetchData(symbol);
  };

  return (
    <Container maxWidth="md" style={{ marginTop: '50px' }}>
      <Card style={{ padding: '20px', borderRadius: '20px', boxShadow: '0 4px 8px rgba(0, 0, 0, 0.2)' }}>
        <CardContent>
          <Typography variant="h4" align="center" gutterBottom>
            📈 Stock Market Trend Visualizer
          </Typography>

          <FormControl fullWidth style={{ marginBottom: '20px' }}>
            <InputLabel>Select Stock Symbol</InputLabel>
            <Select
              value={selectedSymbol}
              onChange={handleSymbolChange}
              label="Select Stock Symbol"
            >
              {symbols.map((symbol) => (
                <MenuItem key={symbol} value={symbol}>
                  {symbol}
                </MenuItem>
              ))}
            </Select>
          </FormControl>

          {graphData && (
            <>
              <Line data={graphData} />
            </>
          )}
        </CardContent>
      </Card>
    </Container>
  );
};

export default StockGraphApp;