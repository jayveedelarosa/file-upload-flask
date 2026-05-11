#!/bin/bash
# Load the environment variables (database credentials, paths)
# This file lives at /home/ec2-user/flask-env.sh and was baked into the AMI
source /home/ec2-user/flask-env.sh

# Go to the application directory
# CodeDeploy has already copied the new code here by this point
cd /home/ec2-user/file-upload-flask

# Activate the Python virtual environment
# IMPORTANT: venv lives at /home/ec2-user/venv (OUTSIDE file-upload-flask)
# This is intentional: CodeDeploy deletes file-upload-flask on every deployment
# If venv were inside that folder, it would be deleted every time
source /home/ec2-user/venv/bin/activate

# Install any new Python packages
# If requirements.txt changed in this commit, new packages get installed here
pip install -r requirements.txt

# Make sure the EFS uploads directory exists
mkdir -p /home/ec2-user/efs/uploads

# Start Flask
# nohup: keeps Flask running after this script's shell closes
# The & runs it in the background so the script can finish
# >> flask.log appends all output to a log file for debugging
nohup /home/ec2-user/venv/bin/flask --app main run --host 0.0.0.0 >> /home/ec2-user/flask.log 2>&1 &

echo "Flask started with PID $!"