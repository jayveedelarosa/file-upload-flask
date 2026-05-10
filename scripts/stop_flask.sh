#!/bin/bash
# Stop Flask if it is running
pkill -f "flask --app main" || true
pkill -f "start-flask.sh" || true
echo "Flask stopped"

# Remove the old application folder completely
# This is CRITICAL: without this, CodeDeploy fails with "file already exists"
# because the file-upload-flask folder was baked into the AMI from Lab 5
rm -rf /home/ec2-user/file-upload-flask || true
echo "Old application folder removed"