from flask import Flask, jsonify, request
import requests
import os

app = Flask(__name__)

ELEVENLABS_API_KEY = os.getenv("ELEVENLABS_API_KEY")
ELEVENLABS_API_URL = "https://api.elevenlabs.io/v1"

@app.route('/api/voices/<voice_id>')
def get_voice(voice_id):
    url = f"{ELEVENLABS_API_URL}/voices/{voice_id}"
    headers = {
        "xi-api-key": ELEVENLABS_API_KEY
    }
    
    response = requests.get(url, headers=headers)
    
    if response.status_code == 200:
        return jsonify(response.json())
    else:
        return jsonify({"error": "Failed to fetch voice data"}), response.status_code


@app.route('/api/voices/add', methods=['POST'])
def add_voice():
    url = f"{ELEVENLABS_API_URL}/voices/add"
    headers = {
        "xi-api-key": ELEVENLABS_API_KEY
    }

    # Get form data
    name = request.form.get('name')
    description = request.form.get('description')
    files = request.files.getlist('files')

    # Prepare the data for the API request
    data = {
        'name': name,
        'description': description,
    }

    # Prepare the files
    files_data = [('files', (file.filename, file.read(), file.content_type)) for file in files]

    # Make the request to ElevenLabs API
    response = requests.post(url, headers=headers, data=data, files=files_data)

    if response.status_code == 200:
        return jsonify(response.json())
    else:
        return jsonify({"error": "Failed to add voice", "details": response.text}), response.status_code


if __name__ == '__main__':
    app.run(debug=True)