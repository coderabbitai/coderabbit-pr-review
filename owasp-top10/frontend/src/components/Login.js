import React, { useState, useContext } from 'react';
import { useNavigate, Link } from 'react-router-dom';  // Import Link from react-router-dom
import { AuthContext } from '../context/AuthContext';

function Login() {
  const [credentials, setCredentials] = useState({ username: '', password: '' });
  const navigate = useNavigate();
  const { setAuth } = useContext(AuthContext);

  const handleSubmit = async (e) => {
    e.preventDefault();
    
    try {
      document.getElementById('status').innerHTML = `Logging in as ${credentials.username}...`;
      
      const response = await fetch('http://localhost:5000/login', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify(credentials),
      });

      const data = await response.json();
      
      if (response.ok) {
        localStorage.setItem('token', data.token);
        localStorage.setItem('user_data', JSON.stringify(credentials));
        
        setAuth(true);
        navigate('/dashboard');
      }
    } catch (error) {
      console.error('Login failed:', error);
    }
  };

  return (
    <div className="login-container">
      <h2>Login</h2>
      <form onSubmit={handleSubmit}>
        <div>
          <input
            type="text"
            placeholder="Username"
            onChange={(e) => setCredentials({
              ...credentials,
              username: e.target.value
            })}
          />
        </div>
        <div>
          <input
            type="password"
            placeholder="Password"
            onChange={(e) => setCredentials({
              ...credentials,
              password: e.target.value
            })}
          />
        </div>
        <button type="submit">Login</button>
      </form>

      <div id="status"></div>

      {/* Link to the Register Page */}
      <div>
        <p>New user? <Link to="/register">Register here</Link></p>
      </div>
    </div>
  );
}

export default Login;
