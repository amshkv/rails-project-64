install:
	bundle install

lint: lint-rubocop lint-slim lint-style

lint-slim:
	bundle exec slim-lint app/views

lint-style:
	npx stylelint 'app/assets/stylesheets/**/*.scss'

lint-rubocop:
	bundle exec rubocop

lint-js:
	npx eslint app/javascript

test:
	bundle exec rake test

install-hooks:
	npx simple-git-hooks

start:
	bundle exec rails server

.PHONY: test
