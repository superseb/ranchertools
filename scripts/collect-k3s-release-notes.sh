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

touch release-notes/README-k3s.md
> release-notes/README-k3s.md
echo "# k3s" >> release-notes/README-k3s.md
for minor in v1.20 v1.21 v1.22 v1.23 v1.24 v1.25 v1.26 v1.27 v1.28 v1.29 v1.30 v1.31 v1.32; do
    product=k3s
    > release-notes/${product}-${minor}.md
    k3stable=$(mktemp)
    k3sversiontmp=$(mktemp)
    previous=""
    echo "| Version | Release date | US date | EU date | Upstream release date | US date | EU date | Days since upstream |" >> $k3sversiontmp
    echo "| ----- | ----- | ----- | ----- | ----- | ----- | ----- | ----- |" >> $k3sversiontmp
    for patch in $(ghretry release list -R "k3s-io/${product}" --exclude-drafts --exclude-pre-releases --limit=1000 | awk -F '\t' '{ print $3 }' | grep ^"${minor}"); do
        publish_date=$(ghretry release view "${patch}" -R "k3s-io/${product}" --json publishedAt -q '.publishedAt' | awk -F'T' '{ print $1 }')
        upstream_version=$(echo "${patch}" | awk -F'+' '{ print $1 }')
        upstream_publish_date=$(ghretry release view "${upstream_version}" -R "kubernetes/kubernetes" --json publishedAt -q '.publishedAt' | awk -F'T' '{ print $1 }')
        let days_since_upstream=($(date +%s -d $publish_date)-$(date +%s -d $upstream_publish_date))/86400
        echo "| [${patch}](${product}-${minor}.md#release-$(generate_markdown_link $patch)) | $(date +"%b %d %Y" -d "${publish_date}") | $(date +"%D" -d "${publish_date}") | $(date +"%F" -d "${publish_date}") | $(date +"%b %d %Y" -d "${upstream_publish_date}") | $(date +"%D" -d "${upstream_publish_date}") | $(date +"%F" -d "${upstream_publish_date}") | ${days_since_upstream} days |" >> $k3sversiontmp
        echo "# Release ${patch}" >> release-notes/${product}-${minor}.md
        ghretry release view "${patch}" -R "k3s-io/${product}" --json body -q '.body' >> release-notes/${product}-${minor}.md
        echo "-----" >> release-notes/${product}-${minor}.md
        body=$(ghretry release view "${patch}" -R "k3s-io/${product}" --json body -q '.body')
        if [ -z "${previous}" ]; then
            echo -n "| k3s version" >> $k3stable
            echo "$body"  | grep "^|" | tail -n+3 | awk -F'|' '{ print $2 }' | while read column; do echo -n "| $column " >> $k3stable; done
            echo " |" >> $k3stable
            echo -n "| ----- " >> $k3stable
            echo "$body"  | grep "^|" | tail -n+3 | awk -F'|' '{ print $2 }' | while read column; do echo -n "| ----- " >> $k3stable; done
            echo " |" >> $k3stable
        fi
        echo -n "| $patch " >> $k3stable
        echo "$body"  | grep "^|" | tail -n+3 | awk -F'|' '{ print $3 }' | while read column; do echo -n "| $column " >> $k3stable; done
        echo " |" >> $k3stable
        previous=$patch
    done
    echo -e "\n\n" >> $k3stable
    echo -e "\n\n" >> $k3sversiontmp
    k3stmp=$(mktemp)
    cat $k3stable $k3sversiontmp release-notes/${product}-${minor}.md > $k3stmp && mv $k3stmp release-notes/${product}-${minor}.md
    cat $k3sversiontmp >> release-notes/README-k3s.md
done
