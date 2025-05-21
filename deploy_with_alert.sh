#!/bin/bash

# Use existing release name to avoid ownership conflicts
RELEASE_NAME="webapp-release"
CHART_PATH="./webapp"
EMAIL_FROM="mdkhairin1999@gmail.com"
EMAIL_TO="mdkhairin1999@gmail.com"
ALERT_FILE="/tmp/helm_alert.txt"
HISTORY_LOG="/tmp/deployment_history.json"

echo "🚀 Deploying with Helm..."
helm upgrade --install "$RELEASE_NAME" "$CHART_PATH" --atomic --wait --debug
DEPLOY_STATUS=$?

TIMESTAMP=$(date)

if [ $DEPLOY_STATUS -ne 0 ]; then
  echo "🚨 ALERT: Helm deployment failed and rolled back!" | tee "$ALERT_FILE"

  echo "{\"timestamp\":\"$TIMESTAMP\", \"event\":\"rollback\"}" >> "$HISTORY_LOG"

  cat <<EOF | msmtp "$EMAIL_TO"
Subject: 🚨 Helm Rollback Alert
From: $EMAIL_FROM
To: $EMAIL_TO

Helm deployment failed and was rolled back!
Timestamp: $TIMESTAMP

Check the cluster for details.
EOF

  echo "📧 Alert email sent to $EMAIL_TO."
else
  echo "{\"timestamp\":\"$TIMESTAMP\", \"event\":\"success\"}" >> "$HISTORY_LOG"
  echo "✅ Deployment succeeded."
fi
