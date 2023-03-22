#!/usr/bin/env bash
for minor in v1.2 v1.3 v1.4; do
    product=rke
    > release-notes/${product}-${minor}.md
    for patch in $(gh release list -R "rancher/${product}" --exclude-drafts --exclude-pre-releases --limit=1000 | awk -F '\t' '{ print $3 }' | grep ^"${minor}"); do
        gh release view "${patch}" -R "rancher/${product}" --json body -q '.body' >> release-notes/${product}-${minor}.md
        echo "-----" >> release-notes/${product}-${minor}.md
    done
done

for minor in v2.5 v2.6 v2.7; do
    product=rancher
    > release-notes/${product}-${minor}.md
    for patch in $(gh release list -R "rancher/${product}" --exclude-drafts --exclude-pre-releases --limit=1000 | awk -F '\t' '{ print $3 }' | grep ^"${minor}"); do
        gh release view "${patch}" -R "rancher/${product}" --json body -q '.body' >> release-notes/${product}-${minor}.md
        echo "-----" >> release-notes/${product}-${minor}.md
    done
done
