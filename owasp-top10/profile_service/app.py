from flask import Flask, request, jsonify
import requests
from pymongo import MongoClient
import pickle
from flask_cors import CORS  # Import CORS

import json

app = Flask(__name__)


# Enable CORS for all routes
CORS(app)


client = MongoClient('mongodb://localhost:27017/')
db = client.userprofiles

@app.route('/profile', methods=['GET'])
def get_profile():
    username = request.args.get('username')  # Get the username from the query parameter
    
    if not username:
        return jsonify({"error": "Username is required"}), 400  # Return error if username is missing
    
    query = {'username': username}  # Use the username directly in the query
    
    profile = db.profiles.find_one(query)
    if profile:
        return jsonify(profile)
    
    return jsonify({"error": "Profile not found"}), 404

    
@app.route('/upload', methods=['POST'])
def upload_file():
    if 'file' not in request.files:
        return jsonify({"error": "No file provided"}), 400

    file = request.files['file']

    # Check if the file is an image (basic check based on file extension)
    if file.filename.split('.')[-1].lower() not in ['jpg', 'jpeg', 'png']:
        return jsonify({"error": "Invalid file type. Only JPG, JPEG, and PNG are allowed."}), 400

    try:
        # Read the file content into memory (avoid using pickle)
        file_content = file.read()
        
        return jsonify({"message": "Image uploaded successfully", "file_size": len(file_content)}), 200

    except Exception as e:
        return jsonify({"error": f"An error occurred: {str(e)}"}), 400



@app.route('/fetch-avatar', methods=['GET'])
def fetch_avatar():
    url = request.args.get('url')
    
    try:
        response = requests.get(url)
        return response.content
    except Exception as e:
        return jsonify({"error": str(e)}), 400

if __name__ == '__main__':
    app.run(port=5001, debug=True)
