# Educational Vulnerable Application

**WARNING: This application is intentionally vulnerable and meant for educational purposes only. DO NOT deploy this in any production environment.**

## Overview
This application demonstrates common security vulnerabilities based on OWASP Top 10 (2021). It consists of two microservices:
- Auth Service: Handles user authentication with intentional vulnerabilities
- Profile Service: Manages user profile data with intentional vulnerabilities

## Intentional Vulnerabilities

### 1. Broken Access Control (A01:2021)
- No role-based access control implementation
- Direct object references without verification
- Location: `auth_service/routes.py` - endpoint `/api/user/<id>`

### 2. Cryptographic Failures (A02:2021)
- Passwords stored with weak hashing (MD5)
- Sensitive data transmitted without encryption
- Location: `auth_service/utils.py` - `hash_password()` function

### 3. Injection (A03:2021)
- SQL injection vulnerability in login query
- NoSQL injection in profile lookup
- Location: `auth_service/routes.py` - `/login` endpoint
- Location: `profile_service/routes.py` - `/profile` endpoint

### 4. Insecure Design (A04:2021)
- No rate limiting on login attempts
- Password reset without verification
- Location: `auth_service/routes.py` - all endpoints

### 5. Security Misconfiguration (A05:2021)
- Debug mode enabled
- Default/weak credentials
- Location: `config.py` - all configuration settings

### 6. Vulnerable Components (A06:2021)
- Outdated dependencies in requirements.txt
- Known vulnerable versions of packages

### 7. Authentication Failures (A07:2021)
- Weak password requirements
- Session tokens without expiry
- Location: `auth_service/utils.py` - `validate_password()` function

### 8. Software and Data Integrity Failures (A08:2021)
- No integrity checks on uploaded files
- Unsecured deserialization
- Location: `profile_service/routes.py` - `/upload` endpoint

### 9. Security Logging Failures (A09:2021)
- No logging of security events
- Sensitive data in logs
- Location: Both services lack proper logging

### 10. Server-Side Request Forgery (A10:2021)
- Unvalidated URL inputs
- Location: `profile_service/routes.py` - `/fetch-avatar` endpoint

## Setup Instructions

1. Create virtual environment:
```bash
python -m venv venv
source venv/bin/activate  # Linux/Mac
venv\Scripts\activate     # Windows
```

2. Install dependencies:
```bash
pip install -r requirements.txt
```

3. Set up MongoDB:
   - Use local MongoDB instance or
   - Create free MongoDB Atlas cluster

4. Configure environment:
```bash
cp .env.example .env
# Edit .env with your MongoDB URI
```

5. Run services:
```bash
# Terminal 1
python auth_service/app.py

# Terminal 2
python profile_service/app.py
```

## Testing Vulnerabilities

1. SQL Injection:
```
Username: admin' OR '1'='1
Password: anything
```

2. NoSQL Injection:
```javascript
{"$gt": ""} in username field
```

3. Weak Passwords:
```
Any password with length > 1 is accepted
```

4. SSRF Test:
```
/fetch-avatar?url=file:///etc/passwd
```

## Automated Testing
Run security scanners against http://localhost:5000 and http://localhost:5001 to detect vulnerabilities.

## Disclaimer
This application is for educational purposes only. It contains intentional security vulnerabilities to demonstrate common security issues. DO NOT use any of this code in production environments.
