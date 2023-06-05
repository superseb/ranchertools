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
	>&2 echo "Failure during gh command, sleeping 10"
        sleep 10
    done
}

> release-notes/README.md
echo "# RKE" >> release-notes/README.md
for minor in v1.2 v1.3 v1.4; do
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
    cat $rkeversiontmp >> release-notes/README.md
    echo -e "\n" >> release-notes/README.md
done

echo "# Rancher" >> release-notes/README.md
for minor in v2.5 v2.6 v2.7; do
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
    cat $rancherversiontmp >> release-notes/README.md
    echo -e "\n" >> release-notes/README.md
done

echo "# RKE2" >> release-notes/README.md
for minor in v1.20 v1.21 v1.22 v1.23 v1.24 v1.25 v1.26 v1.27; do
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
    cat $rke2versiontmp >> release-notes/README.md
    echo -e "\n" >> release-notes/README.md
done

echo "# k3s" >> release-notes/README.md
for minor in v1.20 v1.21 v1.22 v1.23 v1.24 v1.25 v1.26 v1.27; do
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
    cat $k3sversiontmp >> release-notes/README.md
    echo -e "\n" >> release-notes/README.md
done
