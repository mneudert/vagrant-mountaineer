#!/usr/bin/env bash

# change cwd to current script dir
cd "${0%/*}" || exit 127

# setup global configuration
export BUNDLE_GEMFILE='../../Gemfile'
export VAGRANT_I_KNOW_WHAT_IM_DOING_PLEASE_BE_QUIET='true'

# utility functions
setup() {
	echo 'Installing dependencies...'
	bundle install >/dev/null

	echo 'Starting containers...'
	bundle exec vagrant up >/dev/null

	trap teardown EXIT
}

teardown() {
	echo 'Destroying containers...'
	bundle exec vagrant destroy -f >/dev/null
}

trim() {
	sed -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//' <<<"${1}"
}

# run tests
setup

echo 'Running tests...'

result=$(trim "$(bundle exec vagrant ssh primary -c 'ls -la /test/project_a')")

[[ ${result} == *'file_a'* ]] || {
	echo 'Mountpoint invalid or missing...'
	echo "Got result: '${result}'"
	exit 1
}

result=$(trim "$(bundle exec vagrant ssh secondary -c 'ls -la /test/project_a')")

[[ ${result} == *'file_a'* ]] || {
	echo 'Mountpoint invalid or missing...'
	echo "Got result: '${result}'"
	exit 1
}

result=$(trim "$(bundle exec vagrant mountaineer info)")

[[ ${result} == *'/test/project_a'*'(Host:'*'/test/acceptance/project_a)' ]] || {
	echo 'Info not listing correct mountpoints...'
	echo "Got result: '${result}'"
	exit 1
}

echo 'Success!'
