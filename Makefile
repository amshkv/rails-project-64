install:
	bundle install

setup:
	bin/setup

lint: lint-rubocop lint-slim lint-js lint-style

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

console:
	bundle exec rails console

fixture-load:
	bundle exec rake db:fixtures:load

.PHONY: test
