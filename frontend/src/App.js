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

// Register necessary Chart.js components
Chart.register(CategoryScale, LinearScale, PointElement, LineElement, Title, Tooltip, Legend);

const App = () => {
  const [symbols, setSymbols] = useState([]);
  const [selectedSymbol, setSelectedSymbol] = useState('');
  const [graphData, setGraphData] = useState(null);
  const [trend, setTrend] = useState(null);

  // Fetch stock symbols from backend
  useEffect(() => {
    axios.get('/symbols')
      .then((response) => {
        setSymbols(response.data.symbols);
      })
      .catch((error) => {
        console.error('Error fetching symbols:', error);
      });
  }, []);

  // Fetch data for the selected symbol
  const fetchData = (symbol) => {
    axios.get(`/data?symbol=${symbol}`)
      .then((response) => {
        const data = response.data.data;
        const timestamps = data.map(item => item.timestamp);
        const closes = data.map(item => item.close);

        setGraphData({
          labels: timestamps,
          datasets: [
            {
              label: `${symbol} Closing Prices`,
              data: closes,
              borderColor: 'rgba(75, 192, 192, 1)',
              fill: false,
              tension: 0.1,
            }
          ]
        });

        setTrend(response.data.trend);
      })
      .catch((error) => {
        console.error('Error fetching stock data:', error);
      });
  };

  // Handle symbol selection
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
            📈 Stock Market Data Visualizer
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
              <Typography variant="h6" align="center" style={{ marginTop: '20px' }}>
                📊 Trend Analysis: {trend}
              </Typography>
            </>
          )}
        </CardContent>
      </Card>
    </Container>
  );
};

export default App;