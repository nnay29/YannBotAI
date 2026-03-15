
# YannBotAI CI/CD pipeline

**Quick Note :** *_I wanted to understand the modern software lifecycle, so I built an end-to-end pipeline for a small chatbot web app. It taught me how to containerize applications with Docker and automate the flow. Now, I'm applying that same automation logic to Data Engineering._*



A Jenkins-powered CI/CD pipeline for a React.js chatbot that automates builds on GitHub updates, publishes Docker images to Docker Hub, and delivers deployment notifications via Slack — streamlining the release workflow.
## Goals and Objectives of the project
- Automate Docker builds on Jenkins
- Automatic triggering via GitHub webhooks
- Build Docker images from a Git repository.
- Push the built images automatically on the DockerHub
- Real-time Slack notifications with links.

## Technologies Used
- **Jenkins** - CI/CD automation server

- **Docker** Containerization

- **Reactjs** - Frontend framework

- **Vite** - Build Technologies

- **Github** - Source code management

- **Slack** - Notifications

- **ngrok** - secure tunnels for webhook
## Architecture
  GitHub → Webhook → Jenkins → Docker Build → Slack Notification → Docker Hub
## CI/CD Pipeline Flow

1. Trigger
Push or merge to main branch triggers GitHub webhook

Jenkins receives webhook via ngrok tunnel

2. Build
Jenkins clones the repository

Extracts Git information (commit SHA, branch)

Builds Docker image with tag: build-{number}-{commit-sha}

3. Deploy
Pushes Docker image to DockerHub

Sends success/failure notifications to Slack

4. Notify
Rich Slack messages with:

DockerHub image links

GitHub commit links

Build duration and status
## Prerequisites
1) Git and Github
- Git installed and a Github account → [how to ?]()
- Github Personal Access Token → [how to ?]()
- A fork of [this repo](https://github.com/nnay29/YannBotAI) on your account → [how to ?]()

2) Docker and Docker Hub
- Docker installed and a Docker hub account → [how to ?]()

3) Jenkins Installation (preferably via docker-compose)
- Jenkins installed with access to Docker for DinD.( You might use [this]() to install Jenkins using Docker compose and enabling Docker in Docker. )
- Slack Notifications plugins installed in Jenkins


4) Slack
- Download slack, create an account, a workspace and a channel. Take note of your workspace and channel names.


5) Others
- Install ngrok
<!-- - Github Webhooks set up → [Youtube Video](https://youtu.be/TMieCcTrujw?si=yTJnWTbwnOp_-x1d) -->


## Authors


- [nnay29](https://github.com/nnay29)


## Acknowledgements
 - [Legeni07](https://github.com/Legeni07/devops_keyce)
 - [React Tutorial Full Course - Beginner to Pro (React 19, 2025) by Supersimpledev](https://youtu.be/TtPXvEcE11E?si=7672ohBl0xWI1l0i)
 - [Setting Up GitHub Webhooks with Jenkins Using Ngrok by DevOps World](https://youtu.be/TMieCcTrujw?si=4RA96eMfgG5l5yqx)
 - [Into the Unknown ;)](https://chat.deepseek.com/)
 - [Awesome Readme Templates](https://awesomeopensource.com/project/elangosundar/awesome-README-templates)
 - [Awesome README](https://github.com/matiassingers/awesome-readme)
 - [How to write a Good readme](https://bulldogjob.com/news/449-how-to-write-a-good-readme-for-your-github-project)
 


## Running the project locally
###  Phase 1:  On premise project setup
- Clone or Fork the project

```bash
  git clone https://github.com/nnay29/YannBotAI.git
```

- Go to the project directory

```bash
  cd YannBotAI
```
 _You might start the project if you want using ```npm run dev``` and modify to your convinience._

- Build the image from the provided Dockerfile

```bash
  docker build -t my_image_name:tag_version .
```
_You can replace the image name and tag version to your convinience, for example:_ 
```bash
  docker build -t my_chatbot:v1 .
```

- Check if the image has been built correctly. Your built image should appear in the list.
```bash
  docker images
```

- Run the image into a container (replace my_chatbot with the image)

```bash
  docker run -d -p 3600:3500 my_chatbot
```
replace 3600 by another port number if it is used by another service on your computer.


Open the chatbot in your browser on

```bash
  http://localhost:3600/
```

## Phase 2: Jenkins project setup

#### 1 Install required plugins:

Docker Pipeline

Slack Notification

GitHub Integration

#### 2 Setup credentials:

DockerHub credentials (dockerhub-creds)

Slack webhook (slack-bot-token)

GitHub credentials (if private repo)

####  3 Create pipeline job:

Select "Pipeline script from SCM"

Point to your GitHub repository

Set branch to main

## Phase 3: Slack Configuration


## Phase 4: Github Webhook setup
- Start ngrok for Webhooks ```ngrok http 8185``` if your jenkins-server runs on port 8185. Note the returned ngrok url.
- Go to your GitHub repo → Settings → Webhooks → Add webhook
- add webhook url ```https://your-ngrok-url.ngrok.io/github-webhook/```

- Content type: application/json

- Which events: Push events and Merges

- Active: ✅

## Phase 5: Testing

## Features
✅ Build automatique sur push Git

✅ Notifications Slack en temps réel

✅ Construction d'images Docker

✅ Paramétrisation des builds

✅ Push automatique sur le Docker Hub

## Debugging inquiries
In case of any issue, check the following:
- logs Jenkins logs

- Les deliveries of the Github webhook on github or the ngrok terminal.

- The Slack notifications in the channel

- Docker permissions

- Authorize ngrok as a safe program to your Antivirus Software
- Verify ngrok terminal is still running
- Check if the link on ngrok is exactly the one found on Github actions followed by /github-webhook/
## Lessons Learned

What did you learn while building this project? What challenges did you face and how did you overcome them?

1) I discovered webhooks and their purpose.  
2) I understood the actual use of PATs. Now I know they help us launch apps on our behalf. 
3) I discovered tunneling with ngrok now it is easier for me to show projects while still in development. Sending tunnel links to another device also eases the evaluation of the Responsive web designs



## Support

If you have any questions or run into issues, please:

+ Check the troubleshooting section above

+ Review Jenkins console logs

+ Open an issue on GitHub, I'll be glad to check it out

## About Me
Your future SuperEngineer, [nnay29](https://github.com/nnay29) 🚀🧠


_Last updated December 27th 2025_

