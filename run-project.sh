#!/usr/bin/env bash
set -euo pipefail

TOMCAT_HOME="/home/biswass101/Downloads/apache-tomcat-10.1.55"
APP_NAME="hospital-management"
WAR_FILE="target/${APP_NAME}.war"
DEPLOY_PATH="${TOMCAT_HOME}/webapps/${APP_NAME}.war"

echo "[1/5] Checking tools..."
command -v mvn >/dev/null 2>&1 || { echo "mvn not found in PATH"; exit 1; }
[[ -x "${TOMCAT_HOME}/bin/catalina.sh" ]] || { echo "Tomcat not found at ${TOMCAT_HOME}"; exit 1; }

echo "[2/5] Stopping Tomcat..."
"${TOMCAT_HOME}/bin/shutdown.sh" || true
sleep 2

echo "[3/5] Building WAR with Maven..."
mvn clean package -DskipTests

echo "[4/5] Deploying WAR..."
[[ -f "${WAR_FILE}" ]] || { echo "WAR not found: ${WAR_FILE}"; exit 1; }
rm -rf "${TOMCAT_HOME}/webapps/${APP_NAME}" "${DEPLOY_PATH}"
cp "${WAR_FILE}" "${DEPLOY_PATH}"

echo "[5/5] Starting Tomcat..."
"${TOMCAT_HOME}/bin/startup.sh"

echo
echo "Deploy complete."
echo "App URL: http://localhost:8080/${APP_NAME}/"
