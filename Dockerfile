FROM golang:latest as compiler
RUN set -ex; \
    go get -u github.com/golang/dep/cmd/dep; \
    mkdir -p /go/src/github.com/anchore/test-infra/src

WORKDIR /go/src/github.com/anchore/test-infra

COPY . .

RUN set -ex; \
    dep ensure; \
    cd src/test/anchore-engine; \
    GOOS=linux GOARCH=amd64 go test -c .

FROM circleci/python:3.6

RUN sudo pip install --upgrade pip; \
    sudo pip install --upgrade tox; \
    sudo pip install --upgrade awscli; \
    sudo pip install --upgrade anchorecli

RUN sudo curl -o /usr/local/bin/aws-iam-authenticator https://amazon-eks.s3-us-west-2.amazonaws.com/1.12.7/2019-03-27/bin/linux/amd64/aws-iam-authenticator; \
    sudo chmod +x /usr/local/bin/aws-iam-authenticator

RUN curl https://raw.githubusercontent.com/helm/helm/master/scripts/get | bash; \
    sudo apt-get update && sudo apt-get install -y apt-transport-https; \
    curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add - ;\
    echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee -a /etc/apt/sources.list.d/kubernetes.list; \
    sudo apt-get update; \
    sudo apt-get install -y kubectl

COPY --from=compiler /go/src/github.com/anchore/test-infra/src/test/anchore-engine/anchore-engine.test /usr/local/bin/anchore-engine.test
COPY scripts/ci_utils.sh /usr/local/bin/ci_utils.sh