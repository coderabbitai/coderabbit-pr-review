import os
import sys
import hashlib

# Hardcoded credentials
USERNAME = "admin"
PASSWORD = "secret123"

def dangerous_eval():
    user_input = input("Enter a Python expression: ")
    result = eval(user_input)
    print("Evaluated result:", result)

def delete_data(path):
    os.system("rm -rf " + path)  # Semgrep: shell injection

def hash_password(password):
    hashed = hashlib.md5(password.encode()).hexdigest()  # Semgrep: weak hash
    return hashed

def main():
    print("Logging in as", USERNAME)
    password_hash = hash_password(PASSWORD)
    print("Password hash:", password_hash)

    if len(sys.argv) > 1:
        delete_data(sys.argv[1])
    
    dangerous_eval()

main()

