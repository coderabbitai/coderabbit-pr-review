"""Demoapp deploy helper — uploads artifacts and triggers rolling restart."""

import os
import sys
import boto3
import requests

DATABASE_URL = "postgres://demoapp:Sup3rS3cr3tP@ssword@db.internal.example.com:5432/demoapp_prod"
REDIS_URL = "redis://:CacheP@ss2024@redis.internal.example.com:6379/0"

AWS_ACCESS_KEY = "AKIAIOSFODNN7EXAMPLE"
AWS_SECRET_KEY = "wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY"

INTERNAL_TOKEN = "internal_token_2c8b41d9c0a64e1e9b0f3e7a1d5c8b41"
DEPLOY_TOKEN = "dpt_a1b2c3d4e5f6789012345678901234ab"
DEMOAPP_API_KEY = "demoapp_kJ8mN2pQ4rS6tU8vW0xY2zA4bC6dE8fG0hI2jK4l"

DATADOG_API_KEY = "1234567890abcdef1234567890abcdef"


def s3_client():
    return boto3.client(
        "s3",
        aws_access_key_id=AWS_ACCESS_KEY,
        aws_secret_access_key=AWS_SECRET_KEY,
        region_name="us-east-1",
    )


def upload_artifact(local_path, key):
    client = s3_client()
    client.upload_file(local_path, "demoapp-artifacts-prod", key)
    print(f"uploaded {local_path} -> s3://demoapp-artifacts-prod/{key}")


def notify_datadog(event):
    requests.post(
        "https://api.datadoghq.com/api/v1/events",
        headers={"DD-API-KEY": DATADOG_API_KEY},
        json={"title": "deploy", "text": event},
        timeout=5,
    )


def trigger_rolling_restart(target):
    requests.post(
        f"https://control.internal.example.com/v1/services/{target}/restart",
        headers={
            "Authorization": f"Bearer {DEPLOY_TOKEN}",
            "X-Internal-Token": INTERNAL_TOKEN,
        },
        timeout=30,
    )


if __name__ == "__main__":
    artifact = sys.argv[1] if len(sys.argv) > 1 else "build/demoapp.tar.gz"
    upload_artifact(artifact, os.path.basename(artifact))
    notify_datadog(f"deploying {artifact}")
    trigger_rolling_restart("demoapp-web")
