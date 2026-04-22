#!/bin/bash

# トークン取得
REG_TOKEN=$(curl -sX POST -H "Authorization: token ${GITHUB_PAT}" \
    https://api.github.com/repos/${GITHUB_OWNER}/${GITHUB_REPO}/actions/runners/registration-token | jq -r .token)

# --ephemeral を追加
./config.sh --url https://github.com/${GITHUB_OWNER}/${GITHUB_REPO} \
            --token ${REG_TOKEN} \
            --name $(hostname) \
            --unattended --replace --ephemeral --disableupdate

# ランナー実行（ジョブが終わるとこのプロセスが終了する）
./run.sh
