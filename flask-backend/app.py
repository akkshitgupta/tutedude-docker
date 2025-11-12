from flask import Flask, request, jsonify
from flask_cors import CORS

app = Flask(__name__)
CORS(app)

@app.route('/health')
def hello_world():
    return "<p>Backend is up and running on 8000</p>"

@app.route('/api', methods=['GET'])
def api():
    data = [
        { "id": 1, "name": 'Laptop', "price": 75000 },
        { "id": 2, "name": 'Headphones', "price": 2500 },
        { "id": 3, "name": 'Hello world', "price": 1500 }
    ]
    return data

@app.route("/api/todo", methods=['POST'])
def todo():
    form_data = request.get_json()
    print(form_data)
    # result = "<p>Hello " +name+ "</p>"
    return jsonify(form_data)

if __name__ == '__main__':
    app.run(port=8000, host='0.0.0.0', debug=True)