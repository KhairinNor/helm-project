#!/bin/bash

# Deployment settings
RELEASE_NAME="webapp-release"
CHART_PATH="./webapp"
ALERT_FILE="/tmp/helm_alert.txt"
HISTORY_LOG="/tmp/deployment_history.json"

echo "🚀 Deploying with Helm..."
helm upgrade --install "$RELEASE_NAME" "$CHART_PATH" --atomic --wait --debug
DEPLOY_STATUS=$?

TIMESTAMP=$(date)

if [ $DEPLOY_STATUS -ne 0 ]; then
  echo "🚨 ALERT: Helm deployment failed and rolled back!" | tee "$ALERT_FILE"
  echo "{\"timestamp\":\"$TIMESTAMP\", \"event\":\"rollback\"}" >> "$HISTORY_LOG"
  exit 1
else
  echo "{\"timestamp\":\"$TIMESTAMP\", \"event\":\"success\"}" >> "$HISTORY_LOG"
  echo "✅ Deployment succeeded."
fi
