from flask import Flask
import requests
import hvac
import time
 
app = Flask(__name__)
client = hvac.Client(url='http://vault:8200')
client.token = 'root-token'  # Use the root token for this example, not for production
@app.route('/')
def hello_world():
    token_response = client.create_token(policies=['default'], ttl='1h')
    # Create a token for the Flask app
    flask_app_token = token_response['auth']['client_token']
    print(flask_app_token)
    # Retrieve the secret from Vault
    try:
        secret_response = client.secrets.kv.v2.read_secret_version(path='flask-secrets')
    except:
        secret_response = client.secrets.transit.generate_data_key(
                        name='my-key-name',
                        context={'app': 'flask-app'},
                        key_type='plaintext',
                    )
         
    secret_value = secret_response['data']['data']['secret_value']

    return f'Welcome! Secret from Vault: {secret_value}'

if __name__ == '__main__':
    app.run(host='0.0.0.0')
