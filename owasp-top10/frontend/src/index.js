import React from 'react';
import ReactDOM from 'react-dom/client'; // React 18+
import './App.css'; // Import global CSS
import App from './App'; // Import main App component

const root = ReactDOM.createRoot(document.getElementById('root'));
root.render(
  <React.StrictMode>
    <App />
  </React.StrictMode>
);
