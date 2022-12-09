@echo off 

echo Creating Hootsoft directory
cd C:\
mkdir Hootsoft

echo ------------------------------------------------------

echo Changing to Hootsoft directory
cd C:\Hootsoft

echo ------------------------------------------------------

echo Cloning GitHub Repo 1/4: hootsoft/backend 
gh repo clone hootsoft/backend

echo ------------------------------------------------------

echo Cloning GitHub Repo 2/4: @hootsoft/backend_framework
gh repo clone hootsoft/backend_framework

echo ------------------------------------------------------

echo Cloning GitHub Repo 3/4: @hootsoft/frontend
gh repo clone hootsoft/frontend

echo ------------------------------------------------------

echo Cloning GitHub Repo 4/4: @hootsoft/frontend_framework
gh repo clone hootsoft/frontend_framework

echo ------------------------------------------------------

echo Cloning Docker Image 1/1: instructure/dynamo-local-admin
docker pull instructure/dynamo-local-admin

echo ------------------------------------------------------

echo Run Docker Container 1/2: dynamodb_camphoot
docker run -p 8999:8000 -it --name dynamodb_camphoot instructure/dynamo-local-admin

echo ------------------------------------------------------

echo Run Docker Container 2/2: dynamodb_flyhoot
docker run -p 8998:8000 -it --name dynamodb_flyhoot instructure/dynamo-local-admin

echo ------------------------------------------------------

echo Setup Complete

echo ------------------------------------------------------