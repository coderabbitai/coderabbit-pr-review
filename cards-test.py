# presidio_smoke.py — noisy samples to exercise Microsoft Presidio–style detectors.
# Default CodeRabbit Presidio pass: CREDIT_CARD, US_SSN, CRYPTO, PHONE_NUMBER only.

# --- Credit cards (CREDIT_CARD): common test PAN shapes ---
# Dashed
visa_dashed = "4111-1111-1111-1111"
mc_dashed = "5500-0000-0000-0004"
amex_dashed = "3400-000000-00009"
discover_dashed = "6011-0000-0000-0004"

# Spaced
visa_spaced = "4111 1111 1111 1111"
mc_spaced = "5500 0000 0000 0004"

# Same digits, compact (extra shape)
mc_compact = "5500000000000004"

# Remediation example PAN (dashed + spaced + compact — filter hits only exact `4242 4242 4242 4242` / `4242424242424242` at Presidio column)
remediation_pan_spaced = "4242 4242 4242 4242"
remediation_pan_compact = "4242424242424242"

# --- US SSN / ITIN-shaped (US_SSN / sometimes ITIN recognizers) ---
ssn_like = "078-05-1120"
ssn_invalid_example = "000-00-0000"  # exact remediation literal (skipped only if entity+col match)
itin_like = "900-70-0000"  # exact remediation literal for US_ITIN when that entity is enabled
odd_dashed_15 = "856-45-6790"  # short dashed number — may or may not fire; kept from your file

# --- Crypto (CRYPTO) ---
btc_testnet = "tb1qw508d6qejxtdg4y5r3zarvary0c5xw7kv8f3t4"  # exact remediation literal
eth_zero = "0x0000000000000000000000000000000000000000"  # exact remediation literal
eth_nonzero = "0x742d35Cc6634C0532925a3b844Bc9e7595f213b"  # extra shape

# --- Phone (PHONE_NUMBER) ---
phone_fictional = "+1-555-0100"  # exact remediation literal
phone_fictional_template = "555-01XX"  # exact remediation literal (unusual in real code)
phone_plain = "5550100199"

# --- Email (EMAIL_ADDRESS) — only if entity enabled in Presidio config ---
email_example = "user@example.com"  # exact remediation literal

# --- IBAN (IBAN_CODE) — only if entity enabled ---
iban_example = "DE89370400440532013000"  # exact remediation literal

# --- US bank routing (US_BANK_NUMBER) — only if entity enabled ---
routing_nines = "000000000"  # exact remediation literal
routing_doc_like = "021000021"  # realistic-shaped 9 digits; may fire if recognizer exists