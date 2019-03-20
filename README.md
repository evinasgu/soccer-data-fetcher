# soccer-data-fetcher

### Description

The following project contains the sources need to launch an api that fetches data about soccer results.

### Requirements

The requirements to run the service are pretty simple:

- [Docker](https://www.docker.com/)
- [Docker compose](https://docs.docker.com/compose/)

### Running the service

In order to run the service, you have to run the following commands in the console:

```ruby
docker-compose up coordinator
```
```ruby
docker-compose up soccer_data_fetcher
```

### API documentation

For more information about the api documentation please go to the file located in ./resources/swagger.yaml.
This file contains all the api description needed to undertand the different routes. You can view this 
information in [Swagger Editor](https://editor.swagger.io/) for more readability.


