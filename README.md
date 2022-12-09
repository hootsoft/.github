# Hootsoft
## Set-up Environment(s)
### Installing DynamoDB in Docker
If your backend package uses DynamoDB, you will want a local instance. One way this can be done is by installing it from a Docker image. The recommended Docker image  is `instructure/dynamo-local-admin:latest` and can be installed using the following steps:


- Ensure Docker is installed on your local machine and that it works from the terminal
- In the terminal, run `docker pull instructure/dynamo-local-admin`
- Then run `docker run -p {ports} -it --name {name} instructure/dynamo-local-admin`. Make sure to replace `{port}` and `{name}` with the corresponding [port and name](#dynamodb-ports) from the table as it appears in the corresponding columns, for example `8992:8000` for the port and `dynamodb_testhoot` for the name. 

#### DynamoDB Ports
When setting up DynamoDB within docker, please use the following configuration to ensure that problems aren't caused by different local instances not being aligned. 

| Package | Name | Port(s) |
| ----------- | ----------- | ----------- |
| Flyhoot | dynamodb_flyhoot | 8998:8000 |
| Camphoot | dynamodb_camphoot | 8999:8000 |

## Running your Environment(s) Locally
### @hootsoft/backend
@hootsoft/backend is the repo containing all main backend applications within the hootsoft family. These consist of applications such as Flyhoot, Dayhoot, etc. When working locally, these applications will need to be run along with associated services (such as Docker). 

#### Running the Application
To run the backend package locally, simply navigate to the root of the relevant package (so Flyhoot, Dayhoot, etc.) and run a `yarn start`. 

It will look something like:

- `cd .\packages\{package}\` if navigating from within the backend directory
- `cd .\backend\packages\{package}\` if navigating from the "hootsoft" directory

You will need to change the `{package}` out for the package name. So, for example, it would look like `cd .\backend\packages\flyhoot\`.

#### Running a DynamoDB Database
If the application that you are running requires a DynamoDB Database, ensure that you have carried out the required steps from [Installing DynamoDB in Docker](#installing-dynamodb-in-docker) before continuing. 

Once you have this set up, the relevant container should be configured to run automatically when you run `yarn start` on the package. If it doesn't, you should be able to run `docker start {name}` to run the container locally. The name should match the [name in the table](#dynamodb-ports). If successful, you will be able to access your database through a GUI at `http://localhost:{port}/`, for example `http://localhost:8992/`. 

If you need to troubleshoot the Docker container not running on `yarn start`, take a look at the `package.json` file within the package you want to start. It should say something like `"start": "yarn g:dynamo:{package} && yarn g:start",`. What this is doing is looking at the root/global `package.json` file in @hootsoft/backend, running the script `"g:dynamo:{package}": "docker start dynamodb_{package}"` first, then running `yarn start`. 
