# README

[Task](https://gist.github.com/lawitschka/063f2e28bd6993cac5f8b40b991ae899)

* Ruby version: `2.7.0`
* Nodejs version: `12.0.0`

### Run specs:
 * `bundle exec rspec`
 * `bundle exec rubocop`

### Run rails server:
  * `API_SPACE_ID= API_ACCESS_TOKEN= bundle exec rails s`
  * `open http://localhost:3000`

### Docker:
  * `doker build . -t marley_spoon`
  * `docker run -e RAILS_SERVE_STATIC_FILES=1 -e API_SPACE_ID= -e API_ACCESS_TOKEN= -p 3000:80 marley_spoon`

### What is good to improve:
 * Add cache for http requests
 * Add endpoint for filters (by chef / tags / title)
 * Handle api errors in more human way (show some message)
 * Add HELM chart for deployment
 * Create ci config
 * Fix styles inside docker (i don't known how you want to deploy)
