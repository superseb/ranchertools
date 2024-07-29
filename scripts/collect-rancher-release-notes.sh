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

touch release-notes/README-rancher.md
> release-notes/README-rancher.md
echo "# Rancher" >> release-notes/README-rancher.md
for minor in v2.5 v2.6 v2.7 v2.8 v2.9 v2.10; do
    product=rancher
    > release-notes/${product}-${minor}.md
    rancherversiontmp=$(mktemp)
    echo "| Version | Date | US date | EU date |" >> $rancherversiontmp
    echo "| ------- | ---- | ------- | ------- |" >> $rancherversiontmp
    for patch in $(ghretry release list -R "rancher/${product}" --exclude-drafts --exclude-pre-releases --limit=1000 | awk -F '\t' '{ print $3 }' | grep ^"${minor}"); do
        publish_date=$(ghretry release view "${patch}" -R "rancher/${product}" --json publishedAt -q '.publishedAt' | awk -F'T' '{ print $1 }')
        echo "| [${patch}](${product}-${minor}.md#release-$(generate_markdown_link $patch)) | $(date +"%b %d %Y" -d "${publish_date}") | $(date +"%D" -d "${publish_date}") | $(date +"%F" -d "${publish_date}") |" >> $rancherversiontmp
        ghretry release view "${patch}" -R "rancher/${product}" --json body -q '.body' >> release-notes/${product}-${minor}.md
        all_issues=$(ghretry issue list -R "rancher/${product}" -m $patch --limit 1000 --state closed --json number,url,title -q '.[] | "* [#\(.number)](\(.url)) \(.title)"')
        if [ -n "${all_issues}" ]; then
            echo -e "\n## All issues in ${patch} milestone\n" >> release-notes/${product}-${minor}.md
            echo "${all_issues}" >> release-notes/${product}-${minor}.md
        fi
        echo "-----" >> release-notes/${product}-${minor}.md
    done
    echo -e "\n\n" >> $rancherversiontmp
    ranchertmp=$(mktemp)
    cat $rancherversiontmp release-notes/${product}-${minor}.md > $ranchertmp && mv $ranchertmp release-notes/${product}-${minor}.md
    cat $rancherversiontmp >> release-notes/README-rancher.md
done
