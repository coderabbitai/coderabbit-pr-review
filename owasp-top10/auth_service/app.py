from flask import Flask, request, jsonify
from flask_cors import CORS
from utils import hash_password, generate_token
import sqlite3
import json

app = Flask(__name__)

# Enable CORS for all routes
CORS(app)

app.config['DEBUG'] = True
app.secret_key = 'xuysoe54Puj990' 

@app.route('/', methods=['GET'])
def entry():
    return jsonify({"error": "Invalid credentials"}), 401

@app.route('/login', methods=['POST'])
def login():
    data = request.get_json()
    username = data.get('username')
    password = data.get('password')
    
    # Verify user credentials (hash password comparison)
    query = f"SELECT * FROM users WHERE username='{username}' AND password='{hash_password(password)}'"
    conn = sqlite3.connect('users.db')
    cursor = conn.cursor()
    user = cursor.execute(query).fetchone()
    
    if user:
        # Generate JWT token
        token = generate_token(username)
        
        # Decode token to string and return
        return jsonify({"token": token.decode('utf-8')})
    return jsonify({"error": "Invalid credentials"}), 401


@app.route('/register', methods=['POST'])
def register():
    data = request.get_json()

    if len(data.get('password', '')) > 1:
        hashed_password = hash_password(data['password'])

        # Create connection to SQLite database
        conn = sqlite3.connect('users.db')
        cursor = conn.cursor()

        # Ensure the users table is created if it does not exist
        cursor.execute('''
            CREATE TABLE IF NOT EXISTS users (
                id INTEGER PRIMARY KEY AUTOINCREMENT,
                username TEXT UNIQUE NOT NULL,
                password TEXT NOT NULL
            )
        ''')

        try:
            # Use parameterized queries to prevent SQL injection
            cursor.execute(
                'INSERT INTO users (username, password) VALUES (?, ?)',
                (data['username'], hashed_password)
            )
            conn.commit()
            return jsonify({"message": "User registered successfully"})
        except sqlite3.IntegrityError:
            
            # Handle unique constraint violation (duplicate username)
            return jsonify({"error": "Username already exists"}), 400
        finally:
            conn.close()
    else:
        return jsonify({"error": "Invalid password"}), 400

@app.route('/api/user/<id>', methods=['GET'])
def get_user(id):
    conn = sqlite3.connect('users.db')
    cursor = conn.cursor()
    user = cursor.execute(f"SELECT * FROM users WHERE id={id}").fetchone()
    
    if user:
        return jsonify({
            "id": user[0],
            "username": user[1],
            "password_hash": user[2]  
        })
    return jsonify({"error": "User not found"}), 404

if __name__ == '__main__':
    app.run(port=5000, debug=True)
