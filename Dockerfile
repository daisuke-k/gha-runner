FROM ubuntu:24.04

ARG RUNNER_VER="2.337.0"
ARG RUNNER_HASH="70920811a4f8ad4328818682bca5c6469c1c942fab52448868071d0063816613"

RUN apt update && apt install -y \
  curl \
  coreutils \
  jq \
  libkrb5-3 zlib1g \
  liblttng-ust1 \
  libssl3t64$ libssl3$ \
  libicu74 \
  && rm -fr /var/lib/apt/lists/*

RUN useradd -r -m runner
RUN mkdir /actions-runner && chown -R runner:runner /actions-runner
USER runner

WORKDIR /actions-runner
RUN curl -o actions-runner-linux-x64-${RUNNER_VER}.tar.gz -L https://github.com/actions/runner/releases/download/v${RUNNER_VER}/actions-runner-linux-x64-${RUNNER_VER}.tar.gz
RUN echo ${RUNNER_HASH} actions-runner-linux-x64-${RUNNER_VER}.tar.gz | sha256sum -c
RUN tar zxf ./actions-runner-linux-x64-${RUNNER_VER}.tar.gz

COPY entrypoint.sh ./
CMD ["/bin/bash", "./entrypoint.sh"]
