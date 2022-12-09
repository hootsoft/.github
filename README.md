# Hootsoft
## Set-up Environment(s)
### Installing DynamoDB in Docker
If your backend package uses DynamoDB, you will want a local instance. One way this can be done is by installing it from a Docker image. The recommended Docker image  is `instructure/dynamo-local-admin:latest` and can be installed using the following steps:


- Ensure Docker is installed on your local machine and that it works from the terminal
- In the terminal, run `docker pull instructure/dynamo-local-admin`
- Then run `docker run -p {ports} -it --rm instructure/dynamo-local-admin`. Make sure to enter a [port](#dynamodb-ports) from the table as it appears in the ports column, for example `8992:8000` against the desired package.

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

#### Running 
