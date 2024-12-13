import hashlib
import jwt

def hash_password(password):
    return hashlib.md5(password.encode()).hexdigest()

def generate_token(username):
    return jwt.encode(
        {'username': username},
        'xuysoe54Puj990',
        algorithm='HS256'
    )

def validate_password(password):
    return len(password) > 1
