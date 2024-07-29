#!/usr/bin/env bash
function generate_markdown_link()
{
    local release=$1
    release_link=$(echo $patch | tr '[:upper:]' '[:lower:]' | sed -e 's/ /-/g' -e 's/\.//g' -e 's/+//g')
    echo "${release_link}"
}

function ghretry()
{
    until gh "$@"; do
	>&2 echo "Failure during gh command ($@), sleeping 10"
        sleep 10
    done
}

touch release-notes/README-rke.md
> release-notes/README-rke.md
echo "# RKE" >> release-notes/README-rke.md
for minor in v1.2 v1.3 v1.4 v1.5 v1.6 v1.7; do
    product=rke
    > release-notes/${product}-${minor}.md
    rkeversiontmp=$(mktemp)
    echo "| Version | Date | US date | EU date |" >> $rkeversiontmp
    echo "| ------- | ---- | ------- | ------- |" >> $rkeversiontmp
    for patch in $(ghretry release list -R "rancher/${product}" --exclude-drafts --exclude-pre-releases --limit=1000 | awk -F '\t' '{ print $3 }' | grep ^"${minor}"); do
        publish_date=$(ghretry release view "${patch}" -R "rancher/${product}" --json publishedAt -q '.publishedAt' | awk -F'T' '{ print $1 }')
        echo "| [${patch}](${product}-${minor}.md#release-$(generate_markdown_link $patch)) | $(date +"%b %d %Y" -d "${publish_date}") | $(date +"%D" -d "${publish_date}") | $(date +"%F" -d "${publish_date}") |" >> $rkeversiontmp
        ghretry release view "${patch}" -R "rancher/${product}" --json body -q '.body' >> release-notes/${product}-${minor}.md
        echo "-----" >> release-notes/${product}-${minor}.md
    done
    echo -e "\n\n" >> $rkeversiontmp
    rketmp=$(mktemp)
    cat $rkeversiontmp release-notes/${product}-${minor}.md > $rketmp && mv $rketmp release-notes/${product}-${minor}.md
    cat $rkeversiontmp >> release-notes/README-rke.md
done
