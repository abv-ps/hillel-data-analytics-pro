import os

from dotenv import load_dotenv


# Load environment variables from .env file
load_dotenv()

POSTGRES_USER = os.getenv("POSTGRES_USER")
POSTGRES_PASS = os.getenv("POSTGRES_PASS")
POSTGRES_HOST = os.getenv("POSTGRES_HOST", "localhost")
POSTGRES_PORT = os.getenv("POSTGRES_PORT", "5432")
POSTGRES_AB_DBNAME = os.getenv("POSTGRES_AB_DBNAME")

# Validate required settings
required_settings = {
    "POSTGRES_USER": POSTGRES_USER,
    "POSTGRES_PASS": POSTGRES_PASS,
    "POSTGRES_AB_DBNAME": POSTGRES_AB_DBNAME,
}

missing_settings = [
    name for name, value in required_settings.items()
    if not value
]

if missing_settings:
    raise ValueError(
        "Missing required environment variables: "
        + ", ".join(missing_settings)
    )