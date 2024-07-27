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

touch release-notes/README-rke2.md
> release-notes/README-rke2.md
echo "# RKE2" >> release-notes/README-rke2.md
for minor in v1.20 v1.21 v1.22 v1.23 v1.24 v1.25 v1.26 v1.27 v1.28 v1.29 v1.30; do
    product=rke2
    > release-notes/${product}-${minor}.md
    rke2table=$(mktemp)
    rke2versiontmp=$(mktemp)
    previous=""
    columns=""
    echo "| Version | Release date | US date | EU date | Upstream release date | US date | EU date | Days since upstream |" >> $rke2versiontmp
    echo "| ----- | ----- | ----- | ----- | ----- | ----- | ----- | ----- |" >> $rke2versiontmp
    for patch in $(ghretry release list -R "rancher/${product}" --exclude-drafts --exclude-pre-releases --limit=1000 | awk -F '\t' '{ print $3 }' | grep ^"${minor}"); do
        publish_date=$(ghretry release view "${patch}" -R "rancher/${product}" --json publishedAt -q '.publishedAt' | awk -F'T' '{ print $1 }')
        upstream_version=$(echo "${patch}" | awk -F'+' '{ print $1 }')
        upstream_publish_date=$(ghretry release view "${upstream_version}" -R "kubernetes/kubernetes" --json publishedAt -q '.publishedAt' | awk -F'T' '{ print $1 }')
        let days_since_upstream=($(date +%s -d $publish_date)-$(date +%s -d $upstream_publish_date))/86400
        echo "| [${patch}](${product}-${minor}.md#release-$(generate_markdown_link $patch)) | $(date +"%b %d %Y" -d "${publish_date}") | $(date +"%D" -d "${publish_date}") | $(date +"%F" -d "${publish_date}") | $(date +"%b %d %Y" -d "${upstream_publish_date}") | $(date +"%D" -d "${upstream_publish_date}") | $(date +"%F" -d "${upstream_publish_date}") | ${days_since_upstream} days |" >> $rke2versiontmp
        echo "# Release ${patch}" >> release-notes/${product}-${minor}.md
        ghretry release view "${patch}" -R "rancher/${product}" --json body -q '.body' >> release-notes/${product}-${minor}.md
        echo "-----" >> release-notes/${product}-${minor}.md
        body=$(ghretry release view "${patch}" -R "rancher/${product}" --json body -q '.body')
        if [ -z "${previous}" ]; then
            if [ -z "${body}" ]; then
                continue
            fi
            columns=$(echo "$body"  | grep "^|" | tail -n+3 | grep -v "^| Component" | grep -v "\---" | grep -v "CNI Plugins" | awk -F'|' '{ print $2 }' | wc -l)
            echo -n "| RKE2 version" >> $rke2table
            echo "$body"  | grep "^|" | tail -n+3 | grep -v "^| Component" | grep -v "\---" | grep -v "CNI Plugins" | awk -F'|' '{ print $2 }' | while read column; do echo -n "| $column " >> $rke2table; done
            echo " |" >> $rke2table
            echo -n "| ----- " >> $rke2table
            echo "$body"  | grep "^|" | tail -n+3 | grep -v "^| Component" | grep -v "\---" | grep -v "CNI Plugins" | awk -F'|' '{ print $2 }' | while read column; do echo -n "| ----- " >> $rke2table; done
            echo " |" >> $rke2table
        fi
        echo -n "| $patch " >> $rke2table
        if [ -n "${body}" ]; then
            echo "$body"  | grep "^|" | tail -n+3 | grep -v "^| Component" | grep -v "\---" | grep -v "CNI Plugins" | awk -F'|' '{ print $3 }' | while read column; do echo -n "| $column " >> $rke2table; done
            echo " |" >> $rke2table
        else
            for i in `seq 1 $columns`; do echo -n " | " >> $rke2table; done
            echo "" >> $rke2table
        fi
        previous=$patch
    done
    echo -e "\n\n" >> $rke2table
    echo -e "\n\n" >> $rke2versiontmp
    rke2tmp=$(mktemp)
    cat $rke2table $rke2versiontmp release-notes/${product}-${minor}.md > $rke2tmp && mv $rke2tmp release-notes/${product}-${minor}.md
    cat $rke2versiontmp >> release-notes/README-rke2.md
done
