from flask import Flask
import requests
import hvac

app = Flask(__name__)

# Initialize the Vault client
client = hvac.Client(url='http://vault:8200')
client.token = 'root-token'  # Use the root token for this example, not for production

@app.route('/')
def hello_world():
    # Create a token for the Flask app
    token_response = client.create_token(policies=['default'], ttl='1h')
    flask_app_token = token_response['auth']['client_token']

    # Store a secret in Vault
    client.secrets.kv.v2.create_or_update_secret(
        path='flask-secrets',
        secret=dict(secret_value='my-secret')
    )

    # Retrieve the secret from Vault
    secret_response = client.secrets.kv.v2.read_secret_version(path='flask-secrets')
    secret_value = secret_response['data']['data']['secret_value']

    return f'Welcome! Secret from Vault: {secret_value}'

if __name__ == '__main__':
    app.run(host='0.0.0.0')
