# EaaS-demo-application

A sample Java application to showcase ExplorViz as a Service, based on [Spring PetClinic](https://github.com/spring-projects/spring-petclinic). 

## What is this?

> [ExplorViz](https://www.explorviz.net/) is an open source research monitoring and visualization approach, which uses dynamic analysis techniques to provide a live trace visualization of large software landscapes. 

[ExplorViz as a Service](https://github.com/ExplorViz/EaaS-server) (EaaS) allows you to collect build artifacts and run them in ExplorViz instances on-demand.

When submitting builds to EaaS, they need to be wrapped inside a docker image that runs both the application and, if necessary, some load to create more interesting visualizations.

This repository serves as an example how to create such images (by using [EaaS-base-image](https://github.com/ExplorViz/EaaS-base-image)) and submit them to your EaaS instance.

## Building & Running locally

This will merely run Spring PetClinic; to see EaaS in action see below.

```
git clone https://github.com/ExplorViz/EaaS-demo-application.git
cd EaaS-demo-application
./mvnw package
java -jar target/*.jar --server.port=8090
```

You can then access the application here: http://localhost:8090/

Or you can run it from Maven directly using the Spring Boot Maven plugin. If you do this it will pick up changes that you make in the project immediately (changes to Java source files require a compile as well - most people use an IDE for this):

```
./mvnw spring-boot:run
```

## Using ExplorViz as a Service

First, run an instance of [ExplorViz as a Service](https://github.com/ExplorViz/EaaS-server) on a server reachable from the internet. Create a project using any name you want.

### Submit builds from GitHub Actions

Fork this repository on GitHub and enable GitHub Actions. A workflow is included (`.github/workflows/build.yml`) that will build this project and submit a build artifact to an EaaS instance whenever changes are pushed to the repository.

Then configure the workflow by creating secrets in the GitHub repository settings:

- `EAAS_URL`: Set this to the URL where your EaaS instance can be reached from the internet (Important: no trailing /)
- `EAAS_PROJECT`: Set this to the ID of the EaaS project, you can find it on the projects settings page
- `EAAS_SECRET`: You can obtain one from the projects secrets page

You can then make changes to the application and push them to the repository and the GitHub Action will automatically create a build and submit it to the configured EaaS instance. You can see and run these builds through the EaaS webinterface.

### Submit builds from Travis-CI

Fork this repository on GitHub and login on [Travis](https://travis-ci.org), make sure Travis can see the repository. A travis configuration is included (`.travis.yml`) that will build this project and submit a build artifact to an EaaS instance.

Then configure some environment variables in Travis:

- `EAAS_URL`: Set this to the URL where your EaaS instance can be reached from the internet (Important: no trailing /)
- `EAAS_PROJECT`: Set this to the ID of the EaaS project, you can find it on the projects settings page
- `EAAS_SECRET`: You can obtain one from the projects secrets page. This should be set to hidden

You can then make changes to the application and push them to the repository and Travis will automatically create a build and submit it to the configured EaaS instance. You can see and run these builds through the EaaS webinterface.

## License

EaaS-demo-application is released under version 2.0 of the [Apache License](https://www.apache.org/licenses/LICENSE-2.0).
