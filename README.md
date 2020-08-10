# Checkinar

## Ruby and Ruby on Rails version

- Ruby 2.6.2
- Ruby on Rails 6.0.0

## System requeriments

- Ruby 2.6.2
- Rails 6.0.0
- Node 8.11.0+ (there is a bug with Node 10)
- Yarn

## Dependencies

### Ruby

    bundle install
    
### Javascript

    yarn install
    
### Redis

    redis-server
    
## Database Management

To setup database you either run:

    bin/rails db:setup

or:

    bin/rails db:create
    bin/rails db:migrate
    bin/rails db:seed
    
## Build API Documentation

To build API Documentation you need to run the following command:

    bin/rails api:documentation
   
If you want to see API Documentation only visit to `/api/documentation` from your server that you are running.
    
## Tests

You should run the tests with the following command:

    bin/rails test test:system

## Linting

You can lint the code running Rubocop:

    rubocop

## Running the application

The application now uses Webpacker to compile assets (images, stylesheets and javascripts). You can run the server as
usual with `bin/rails s` but if you make changes to assets Webpack will take a few seconds to compile and continue
with the request.

If you want to avoid this wait time, then install foreman and run the following command `PORT=3200 foreman start`. This
will start Webpack as a separate process which will be faster to compile assets. For `PORT` variable you can use any
port that is suitable for you.

## API Documentation

API is being documented using [API Blueprint](https://apiblueprint.org/documentation/tutorial.html) spec. Documentation can be found
in `docs/api`.

[aglio](https://github.com/danielgtaylor/aglio) is used to generate static HTML in `public/api`.
To view documentation point your browser to `/api/documentation`.

To generate a new version of documentation use `bin/aglio` stub or use `bin/rails api:documentation` rake task.

Additonal resources for API Blueprint documentation can be found at [API Blueprint examples](https://github.com/apiaryio/api-blueprint/tree/master/examples)
also, in [Markdown Syntax for Object Notation](https://github.com/apiaryio/mson) *MSON*.

### JSON schemas
With API Blueprint is also possible to generate JSON schemas for validation, just use `bin/rails api:schemas` rake task.
This task will create a file `test/schemas/schemas.json`.

[Understanding JSON schema](https://spacetelescope.github.io/understanding-json-schema/index.html) is a good reference resource.

