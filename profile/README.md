# Hootsoft

## Table of Contents
1. [Hootsoft Packages](#packages)
2. [Set-up Environment](#set-up-environment)
3. [Running Environments Locally](#running-environments-locally)

## Hootsoft Packages
The @hootsoft application is built of multiple packages with multiple purposes. They are as follows:
| Name | Purpose |
| -- | -- |
| backend | This is a repo containing all backend applications such as Flyhoot, Dayhoot, etc. The purpose of this repo is to handle backend calls to the application through APIs. Some of this code is built using the @hootsoft/backend_framework. |
| backend_framework | This a repo containing all common backend functionality consumed within the @hootsoft/backend project. This repo is exposed as a library to NPM and should be used and updated to aid with code maintainability and reusability. |
| frontend | This is a repo containing all frontend applications such as Flyhoot, Dayhoot, etc. The purpose of this repo is to handle the frontend design code required for the user to interact with the application. Much of this code is build from the @hootsoft/frontend_framework. |
| frontend_framework | This is a repo containing common frontend functionality consumed within the @hootsoft/frontend project. This contains common functions, similar to the @hootsoft/backend_framework but also incorporates a frontend UI library, similar to popular libraries such as MUI & Bootstrap. In doing this, we can centrally maintain and visually align @hootsoft family applications. |
| hootsoft.github.io | This repo should not be manually modified. It contains the compiled JS files for the @hootsoft/frontend_framework and is used in conjunction with the exposed NPM typings. For this to work, we must import the @hootsoft/frontend_framework package from NPM and also point Module Federation to this repo's `remoteEntry.js` file.  |
| javaRestApis | This is a repo containing some REST API training Dan has been doing around Java. This is not currently implemented into hootsoft. |

## Set-up Environment
To set up your environment, you need to perform multiple steps. For any of the setup methods we can use, you will need to make sure you have a few things installed otherwise you will run into errors. The things to install are:
1. [Git](https://gitforwindows.org/) click yes to everything but double check you have it selected to use git in 3rd party applications.
2. [Node](https://nodejs.org/en/download/) and just click yes to everything.
2. [GitHub CLI](https://cli.github.com/)
3. [Docker Desktop](https://www.docker.com/products/docker-desktop/) and ensure Docker CLI is working.

Just a reminder that you may need to reboot your machine after installing for the changes to take effect.

Once you have installed these, you can go ahead and choose a method of setup. Either you can perform individual steps, as listed in the subheadings within this section. Alternatively, you can download and run the [Hootsoft Initial Setup](https://raw.githubusercontent.com/hootsoft/.github/main/hootsoft-initial-setup.bat) batch file and your environment should set itself up. To download the file, right-click the hyperlink and "Save As". Once downloaded, either edit the desired directory (it defaults to `C:\`) or just double-click it and run it. If all the steps are successful, you can skip the remaining info in this section and go straight to [Running Environments Locally](#running-environments-locally). 

### Installing Package Repos
To install package repos, ensure you have installed [GitHub CLI](https://cli.github.com/). Your machine might need a reboot before it starts working. For local manageability, I would recommend creating a folder (directory) called "Hootsoft" and cloning all of the repos into one place. This can be done through GUI or from the terminal, navigating to where you would like the new directory and running `mkdir "Hootsoft"`. 

#### @hootsoft/backend
- Open a terminal locally and `cd` into the "Hootsoft" directory you have created. For example `cd /Hootsoft/`;
- Once in the correct directory, run `gh repo clone hootsoft/backend`.

#### @hootsoft/backend_library
- Open a terminal locally and `cd` into the "Hootsoft" directory you have created. For example `cd /Hootsoft/`;
- Once in the correct directory, run `gh repo clone hootsoft/backend_library`.

#### @hootsoft/frontend
- Open a terminal locally and `cd` into the "Hootsoft" directory you have created. For example `cd /Hootsoft/`;
- Once in the correct directory, run `gh repo clone hootsoft/frontend`.

#### @hootsoft/frontend_library
- Open a terminal locally and `cd` into the "Hootsoft" directory you have created. For example `cd /Hootsoft/`;
- Once in the correct directory, run `gh repo clone hootsoft/frontend_library`.

#### @hootsoft/hootsoft.github.io
You do not need this GitHub repo locally. If you have it, cool, but you shouldn't be modifying it at all. All modifications are handled by GitHub Action Pipelines.

#### @hootsoft/javaRestApis
This repo is experimental at this point. There is no need to pull it down. 

### Installing DynamoDB in Docker
If your backend package uses DynamoDB, you will want a local instance. One way this can be done is by installing it from a Docker image. The recommended Docker image  is `instructure/dynamo-local-admin:latest` and can be installed using the following steps:

- Ensure Docker is installed on your local machine and that it works from the terminal
- In the terminal, run `docker pull instructure/dynamo-local-admin`
- Then run `docker run -p {ports} -it --name {name} instructure/dynamo-local-admin`. Make sure to replace `{port}` and `{name}` with the corresponding [port and name](#dynamodb-ports) from the table as it appears in the corresponding columns, for example `8992:8000` for the port and `dynamodb_testhoot` for the name. 

#### DynamoDB Ports
When setting up DynamoDB within docker, please use the following configuration to ensure that problems aren't caused by different local instances not being aligned. 

| Package | Name | Port(s) |
| ----------- | ----------- | ----------- |
| Camphoot | dynamodb_camphoot | 8999:8000 |
| Flyhoot | dynamodb_flyhoot | 8998:8000 |

## Running Environments Locally
### @hootsoft/backend
@hootsoft/backend is the repo containing all main backend applications within the hootsoft family. These consist of applications such as Flyhoot, Dayhoot, etc. When working locally, these applications will need to be run along with associated services (such as Docker). Whilst this app uses the @hootsoft/backend_framework package, because it is deployed to NPM, it doesn't need to be run at the same time. 

Once the @hootsoft/backend app is running, it should then be accessible from any consuming frontend app, such as Flyhoot, providing it is allowed within the CORS settings. To test any APIs, you may wish to use [Postman](https://www.postman.com/) but ensure you have Postman desktop installed and running to call localhost APIs.

#### Running the Application
When your selected repo has been cloned, you will need to run a `yarn install` in each one to make sure it pulls down the packages. If you have any issues with that, first run a `npm install yarn`, then run `yarn install`. Just make sure to remove `yarn` from `package.json` if it wasn't previously there, as can be seen in your change differences.

To run the backend app locally, simply navigate to the root of the relevant package (so Flyhoot, Dayhoot, etc.) and run a `yarn start`. 

It will look something like:

- `cd .\packages\{package}\` if navigating from within the backend directory
- `cd .\backend\packages\{package}\` if navigating from the "hootsoft" directory

You will need to change the `{package}` out for the package name. So, for example, it would look like `cd .\backend\packages\flyhoot\`.

#### Running a DynamoDB Database
If the application that you are running requires a DynamoDB Database, ensure that you have carried out the required steps from [Installing DynamoDB in Docker](#installing-dynamodb-in-docker) before continuing. 

Once you have this set up, the relevant container should be configured to run automatically when you run `yarn start` on the package. If it doesn't, you should be able to run `docker start {name}` to run the container locally. The name should match the [name in the table](#dynamodb-ports). If successful, you will be able to access your database through a GUI at `http://localhost:{port}/`, for example `http://localhost:8992/`. 

If you need to troubleshoot the Docker container not running on `yarn start`, take a look at the `package.json` file within the package you want to start. It should say something like `"start": "yarn g:dynamo:{package} && yarn g:start",`. What this is doing is looking at the root/global `package.json` file in @hootsoft/backend, running the script `"g:dynamo:{package}": "docker start dynamodb_{package}"` first, then running `yarn start`. 

### @hootsoft/backend_framework
@hootsoft/backend_framework is the repo containing all common functionality for the @hootsoft/backend app. Here we store common functions which we might need between apps for functionality such as accessing databases, performing calculations, sorting through data, etc. There is no need to run this app locally for the @hootsoft/backend to work, since it uses the latest deployed version from NPM. It will need running when developing the @hootsoft/backend_framework app though to test before checking in & deploying to NPM. 

To run the app, navigate to the root of the package you want to run. Due to the app being configured as a [Yarn Workspace](https://classic.yarnpkg.com/lang/en/docs/workspaces/) it will have nested "packages". Currently there is only one package `packages/framework` but we have scope to add more, for example `packages/sandbox` which we can use for testing out functionality before deployment or `packages/test` that we can use for automation testing.

To change to the relevant package, it will look something like:

- `cd .\packages\{package}\` if navigating from within the backend_framework directory
- `cd .\backend_framework\packages\{package}\` if navigating from the "hootsoft" directory

### @hootsoft/frontend
@hootsoft/frontend is the repo containing all the frontend apps for Hootsoft. These may consist of apps such as Flyhoot, Dayhoot, etc. The content that we expect to be within this repo is the individual frontend (UI) content specific to each application, often assembling components of the @hootsoft/frontend_framework UI library. When we are working on an app within the @hootsoft/frontend project locally, we will want to run it. 

To change to the relevant app, it will look something like:

- `cd .\packages\{package}\` if navigating from within the frontend directory
- `cd .\frontend\packages\{package}\` if navigating from the "hootsoft" directory
