import os
from flask import Flask, render_template, request, jsonify
from chatgpt import get_response, init_chatbot

app = Flask(__name__)
# Define a global variable to keep track of chatbot initialization
@app.route('/')
def index():
    return render_template('index.html')
chatbot_initialized = False
try:
    init_chatbot()
    chatbot_initialized = True
except Exception as e:
    print(f"Error initializing chatbot: {e}")



@app.route('/ask', methods=['POST'])
def ask():
    user_message = request.form['user_message']
    bot_response = get_response(user_message)  # This function will return the chatbot's response
    return jsonify({'message': bot_response})

if __name__ == "__main__":
    port = int(os.environ.get("PORT", 5000))  # Use provided port or default to 5000
    app.run(host='0.0.0.0', port=port, debug=False)
