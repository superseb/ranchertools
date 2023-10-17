#!/usr/bin/env bash
TMPFILE=$(mktemp)
echo "# Channels" > $TMPFILE

echo -e "\n## Latest, stable, testing\n" >> $TMPFILE
echo "| Channel | k3s version | RKE2 version |" >> $TMPFILE
echo "| ------- | ----------- | ------------ |" >> $TMPFILE

CHANNELS=$(echo -e "stable\nlatest\ntesting")
K3S=$(curl --retry 10 --retry-connrefused https://update.k3s.io/v1-release/channels | jq -r '.data[] | select(.name=="latest" or .name=="stable" or .name=="testing") | .latest')
RKE2=$(curl --retry 10 --retry-connrefused https://update.rke2.io/v1-release/channels | jq -r '.data[] | select(.name=="latest" or .name=="stable" or .name=="testing") | .latest')
paste -d'|' <(echo "$CHANNELS") <(echo "$K3S") <(echo "$RKE2") >> $TMPFILE

echo -e "\n## k3s\n" >> $TMPFILE
echo "| k3s channel | k3s version |" >> $TMPFILE
echo "| ----------- | ----------- |" >> $TMPFILE

curl --retry 10 --retry-connrefused https://update.k3s.io/v1-release/channels | jq -r '.data | sort_by(.name) | .[] | "| " + .name + " | " + .latest + " |"' >> $TMPFILE

echo -e "\n## RKE2\n" >> $TMPFILE
echo "| RKE2 channel | RKE2 version |" >> $TMPFILE
echo "| ------------ | ----------- |" >> $TMPFILE

curl --retry 10 --retry-connrefused https://update.rke2.io/v1-release/channels | jq -r '.data | sort_by(.name) | .[] | "| " + .name + " | " + .latest + " |"' >> $TMPFILE

mv $TMPFILE CHANNELS.md
