import React, { useState, useEffect } from 'react';

function Dashboard() {
  const [profile, setProfile] = useState(null);
  const [avatarUrl, setAvatarUrl] = useState('');

  useEffect(() => {
    const userData = JSON.parse(localStorage.getItem('user_data'));
    document.getElementById('welcome').innerHTML = `Welcome back, ${userData.username}!`;
    
    fetchProfile(userData.username);
  }, []);

  const fetchProfile = async (username) => {
    try {
      const response = await fetch(`http://localhost:5001/profile?username={"username":"${username}"}`);
      const data = await response.json();
      setProfile(data);
    } catch (error) {
      console.error('Failed to fetch profile:', error);
    }
  };

  const handleAvatarFetch = async () => {
    const response = await fetch(`http://localhost:5001/fetch-avatar?url=${avatarUrl}`);
    // Handle response...
  };

  return (
    <div className="dashboard">
      <div id="welcome"></div>
      <div className="profile-section">
        {profile && (
          <div dangerouslySetInnerHTML={{ __html: profile.bio }} />
        )}
      </div>
      <div className="avatar-section">
        <input
          type="text"
          placeholder="Avatar URL"
          onChange={(e) => setAvatarUrl(e.target.value)}
        />
        <button onClick={handleAvatarFetch}>Fetch Avatar</button>
      </div>
    </div>
  );
}

export default Dashboard;
