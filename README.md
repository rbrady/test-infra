# Anchore CI/Test Harness

This repository provides an entry point and set of shared tasks for testing and CI.  It allows any provided task to be easily overridden.  Currently this is for use with Python.

## Installation

To install this library, use pip directly or add this to the requirements-test.txt file.

```shell
# Example install from pip
python -m pip install git+https://github.com/anchore/test-infra.git@v0.0.1

# Example of installing via pip and a requirements file
# contents of requirements-test.txt
git+https://github.com/anchore/test-infra.git@v0.0.1#egg=test-infra

# install requirements via pip
python -m pip install -r requirements-test.txt
```

## Usage Example

To use the provided task `clean`, clone this repo into your project's root directory, and create the following variables and targets in your makefile:

```
TEST_IMAGE_NAME := my_image:latest
TEST_HARNESS_REPO := https://github.com/anchore/test-infra.git
CI_CMD := ci_harness


.PHONY: clean
clean: ## Clean up the project directory and delete dev image
  @$(CI_CMD) clean $(TEST_IMAGE_NAME)
```

To override the provided task with your own `clean`, provide an executable in `./scripts/ci/clean`, and the test harness entry point will invoke your task instead.

The following tasks are provided (run `./anchore-ci/ci_harness` to see a current list in case this has changed):

```
clean
cluster-down
cluster-up
install-cluster-deps
lint
push-dev-image
push-prod-image-rebuild
push-prod-image-release
push-rc-image
test-functional
test-unit
```
## Provided Task Required Parameters

Most of the provided tasks require some parameters to execute; some also require a virtual environment to be activated already - otherwise, your local/system Python is required to be configured 'correctly'.  These are listed below.  Please see the sample makefile provided in this repo for a full example.

Task | Required Parameters | Virtual environment activation required
---- | --------- | --------
clean | TEST_IMAGE_NAME | No
lint | None | Yes
test-unit | None | Yes
test-functional | None | Yes
install-cluster-deps | VENV | No
cluster-up | CLUSTER_NAME, CLUSTER_CONFIG,<br/>KUBERNETES_VERSION | Yes
cluster-down | CLUSTER_NAME  | Yes
push-dev-image | COMMIT_SHA, DEV_IMAGE_REPO,<br/>GIT_BRANCH, TEST_IMAGE_NAME | No
push-rc-image | COMMIT_SHA, DEV_IMAGE_REPO,<br/>GIT_TAG | No
push-prod-image-rebuild | DEV_IMAGE_REPO, GIT_BRANCH,<br/>GIT_TAG, PROD_IMAGE_REPO | No
push-prod-image-reelase | DEV_IMAGE_REPO, GIT_BRANCH,<br/>GIT_TAG, PROD_IMAGE_REPO | No
