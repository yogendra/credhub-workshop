--

# Credhub Workshop

[Slide Deck](credhub-workshop.pdf)

## Requirement

- PCF Environment
- Credhub Cli
- Java Development Environment (JDK, IDE, etc.)
- Git client

## Setup

First, login to the PCF environment.

- Set API endpoint

  ```
  cf api api.sys.havana.cf-app.com
  ```

  **Output**

  ```
  Setting api endpoint to api.sys.havana.cf-app.com...
  OK
    api endpoint: https://api.sys.havana.cf-app.com
  api version: 2.125.0
  Not logged in. Use 'cf login' to log in.
  ```

- Login to environment using credentials provided

  ```
  cf login
  ```

  **Output**

  ```
  API endpoint: https://api.sys.havana.cf-app.com

  Email> admin

  Password>
  Authenticating...
  OK

  Select an org (or press enter to skip):
  1. credhub-service-broker-org
  2. demo
  3. system

  Org> 2
  Targeted org demo

  Targeted space demo

  API endpoint: https://api.sys.havana.cf-app.com (API version: 2.125.0)
  User: admin
  Org: demo
  Space: demo

  ```

## Secured Service Binding

- Build `spring-music` application
  ```
  cd spring-music
  ./gradlew assemble
  ```
- Push it to Cloud Foundry
  ```
  cf push
  ```
- Create a service instance for Mysql service

  ```
  cf create-service p.mysql db-small db
  ```

- Bind this service to our app and restage application

  ```bash
  cf bind-service spring-music db
  cf restage spring-music
  ```

- SSH into the container to check application environment
- Check the `/envs` endpoint to see whats in the actual envuronment

## Credhub Service Instance

- First lets create a credhub service instance with credentials

  ```
  cf create-service credhub default twitter -c '{
    "consumerKey":"CONSUMER KEY",
    "consumerSecret":"CONSUMER SECRET",
    "accessToken":"ACCESS TOKEN",
    "accessTokenSecret":"ACCESS TOKEN SECRET"
  }'
  ```

- Build twitter streaming app

  ```
  cd ../spring-twitter-stream
  ./mvnw clean install
  ```

- Push it
  ```
  cf push
  ```
- SSH into the container to check application environment
- Check the `/envs` endpoint to see whats in the actual envuronment

## Links

- [Credhub usage in secured service instance](https://content.pivotal.io/blog/enterprise-architects-its-time-to-learn-how-the-credhub-service-broker-applies-the-principle-of-least-privilege-to-your-secrets)

- [Using Credhub Broker for Custom Service Credentials](https://docs.pivotal.io/credhub-service-broker/using.html)

- [Credhub as an Opinionated Service](https://medium.com/@srinivasan.surprise/credhub-as-an-opinionated-service-8336442fb2bc)
