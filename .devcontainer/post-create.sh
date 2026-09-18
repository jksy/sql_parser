#!/usr/bin/env bash
# postCreateCommand for the dev container: install the gems, including the
# appraisal gemfiles for the Oracle connection tests.
set -eu

# The lockfiles are not tracked by git, so the ones in the workspace may have
# been generated on the host with another Ruby or Bundler and may not resolve
# here (e.g. an old lock pinning simplecov-cobertura 2.x, which conflicts with
# simplecov >= 1.0). Regenerate them inside the container instead.
rm -f Gemfile.lock gemfiles/*.gemfile.lock

bundle install
bundle exec appraisal install
