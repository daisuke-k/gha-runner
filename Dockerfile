FROM ubuntu:24.04

ARG RUNNER_VER="2.333.1"
ARG RUNNER_HASH="18f8f68ed1892854ff2ab1bab4fcaa2f5abeedc98093b6cb13638991725cab74"

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
