#!/usr/bin/env bash
set -euo pipefail

required_vars=(
  "INSTANCE_NAME"
  "NOTESNOOK_API_SECRET"
  "DISABLE_SIGNUPS"
  "SMTP_USERNAME"
  "SMTP_PASSWORD"
  "SMTP_HOST"
  "SMTP_PORT"
  "AUTH_SERVER_PUBLIC_URL"
  "NOTESNOOK_APP_PUBLIC_URL"
  "MONOGRAPH_PUBLIC_URL"
  "ATTACHMENTS_SERVER_PUBLIC_URL"
)

missing=()

for var in "${required_vars[@]}"; do
  value="${!var:-}"
  if [ "${DEBUG_VALIDATE:-0}" = "1" ]; then
    echo "$var=$value"
  fi
  if [ -z "$value" ]; then
    missing+=("$var")
  fi
done

if [ "${#missing[@]}" -gt 0 ]; then
  echo "Error: Required environment variables are not set: ${missing[*]}" >&2
  exit 1
fi

echo "All required environment variables are set."
