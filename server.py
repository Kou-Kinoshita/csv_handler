from flask import Flask, request, jsonify
import json
import base64
import pandas as pd
import io

response = ''

app = Flask(__name__)

# Set the maximum content length of requests
app.config['MAX_CONTENT_LENGTH'] = 500 * 1024 * 1024  # 500mb

@app.route('/', methods=['POST'])
def receive_csv():

    global response 

    # Get and decode data from client end
    request_data = request.data
    request_data = json.loads(request_data.decode('utf-8'))
    data = request_data['binaryData']
    decoded_data = base64.b64decode(data)
    response = f'Binary received: {decoded_data}'
    print(response)

    # Buil CSV
    csv_string = decoded_data.decode('utf-8')
    csv_file = io.StringIO(csv_string)
    df = pd.read_csv(csv_file)
    print(df)

    return " "

if __name__ == '__main__':
    app.run(debug=True)