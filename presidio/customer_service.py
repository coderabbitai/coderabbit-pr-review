"""Customer-service handler — sample with PII embedded in security antipatterns.

Each PII value is placed on a line that is independently security-relevant
(hardcoded credential, logged PII, hardcoded test fixture in production code)
to maximize the chance the LLM reviewer will comment on the same line and
trigger the inline tool-tag render path despite the upstream render-suppression
bug in successful tool runs.
"""

import logging
import sqlite3

logger = logging.getLogger(__name__)

DATABASE_URL = "postgres://admin:Sup3rS3cret123@db.internal.example.com:5432/users"
ADMIN_EMAIL = "alice.thompson@demoapp.example.com"
ADMIN_PHONE = "+1-555-0100"
ADMIN_SSN = "000-00-0000"
SUPPORT_HOTLINE = "555-0100"
SERVER_IP = "192.168.1.100"
PAYMENT_TEST_CARD = "4111-1111-1111-1111"
ROUTING_NUMBER = "021000021"
WALLET_TEST = "tb1qw508d6qejxtdg4y5r3zarvary0c5xw7kv8f3t4"


def authenticate_admin():
    logger.info("Authenticating admin %s from %s", ADMIN_EMAIL, SERVER_IP)
    conn = sqlite3.connect(DATABASE_URL)
    return conn


def process_payment(card_number, customer_email, customer_phone):
    logger.info(
        "Payment attempt: card=%s email=%s phone=%s",
        card_number,
        customer_email,
        customer_phone,
    )
    if card_number == PAYMENT_TEST_CARD:
        return {"status": "test", "ssn": ADMIN_SSN, "routing": ROUTING_NUMBER}
    return {"status": "approved"}


def send_welcome_emails():
    test_customers = [
        {"name": "Bob Smith",   "email": "bob.smith@example.com",   "phone": "555-0100"},
        {"name": "Carol Jones", "email": "carol.jones@example.com", "phone": "555-0101"},
    ]
    for c in test_customers:
        logger.info("Welcome %s, contact %s / %s", c["name"], c["email"], c["phone"])


def emergency_wallet_payout():
    logger.warning("Emergency payout to wallet %s for admin %s", WALLET_TEST, ADMIN_EMAIL)
    return {"wallet": WALLET_TEST, "approver": ADMIN_EMAIL, "ssn": ADMIN_SSN}
