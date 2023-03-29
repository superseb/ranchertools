#!/usr/bin/env bash
function generate_markdown_link()
{
    local release=$1
    release_link=$(echo $patch | tr '[:upper:]' '[:lower:]' | sed -e 's/ /-/g' -e 's/\.//g' -e 's/+//g')
    echo "${release_link}"
}

> release-notes/README.md
echo "# RKE" >> release-notes/README.md
for minor in v1.2 v1.3 v1.4; do
    product=rke
    > release-notes/${product}-${minor}.md
    rkeversiontmp=$(mktemp)
    echo "| Version | Date | US date | EU date |" >> $rkeversiontmp
    echo "| ------- | ---- | ------- | ------- |" >> $rkeversiontmp
    for patch in $(gh release list -R "rancher/${product}" --exclude-drafts --exclude-pre-releases --limit=1000 | awk -F '\t' '{ print $3 }' | grep ^"${minor}"); do
        publish_date=$(gh release view "${patch}" -R "rancher/${product}" --json publishedAt -q '.publishedAt' | awk -F'T' '{ print $1 }')
        echo "| [${patch}](${product}-${minor}.md#release-$(generate_markdown_link $patch)) | $(date +"%b %d %Y" -d "${publish_date}") | $(date +"%D" -d "${publish_date}") | $(date +"%F" -d "${publish_date}") |" >> $rkeversiontmp
        gh release view "${patch}" -R "rancher/${product}" --json body -q '.body' >> release-notes/${product}-${minor}.md
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
    for patch in $(gh release list -R "rancher/${product}" --exclude-drafts --exclude-pre-releases --limit=1000 | awk -F '\t' '{ print $3 }' | grep ^"${minor}"); do
        publish_date=$(gh release view "${patch}" -R "rancher/${product}" --json publishedAt -q '.publishedAt' | awk -F'T' '{ print $1 }')
        echo "| [${patch}](${product}-${minor}.md#release-$(generate_markdown_link $patch)) | $(date +"%b %d %Y" -d "${publish_date}") | $(date +"%D" -d "${publish_date}") | $(date +"%F" -d "${publish_date}") |" >> $rancherversiontmp
        gh release view "${patch}" -R "rancher/${product}" --json body -q '.body' >> release-notes/${product}-${minor}.md
        echo "-----" >> release-notes/${product}-${minor}.md
    done
    echo -e "\n\n" >> $rancherversiontmp
    ranchertmp=$(mktemp)
    cat $rancherversiontmp release-notes/${product}-${minor}.md > $ranchertmp && mv $ranchertmp release-notes/${product}-${minor}.md
    cat $rancherversiontmp >> release-notes/README.md
    echo -e "\n" >> release-notes/README.md
done

echo "# RKE2" >> release-notes/README.md
for minor in v1.20 v1.21 v1.22 v1.23 v1.24 v1.25 v1.26; do
    product=rke2
    > release-notes/${product}-${minor}.md
    rke2versiontmp=$(mktemp)
    echo "| Version | Date | US date | EU date |" >> $rke2versiontmp
    echo "| ------- | ---- | ------- | ------- |" >> $rke2versiontmp
    for patch in $(gh release list -R "rancher/${product}" --exclude-drafts --exclude-pre-releases --limit=1000 | awk -F '\t' '{ print $3 }' | grep ^"${minor}"); do
        publish_date=$(gh release view "${patch}" -R "rancher/${product}" --json publishedAt -q '.publishedAt' | awk -F'T' '{ print $1 }')
        echo "| [${patch}](${product}-${minor}.md#release-$(generate_markdown_link $patch)) | $(date +"%b %d %Y" -d "${publish_date}") | $(date +"%D" -d "${publish_date}") | $(date +"%F" -d "${publish_date}") |" >> $rke2versiontmp
        echo "# Release ${patch}" >> release-notes/${product}-${minor}.md
        gh release view "${patch}" -R "rancher/${product}" --json body -q '.body' >> release-notes/${product}-${minor}.md
        echo "-----" >> release-notes/${product}-${minor}.md
    done
    echo -e "\n\n" >> $rke2versiontmp
    rke2tmp=$(mktemp)
    cat $rke2versiontmp release-notes/${product}-${minor}.md > $rke2tmp && mv $rke2tmp release-notes/${product}-${minor}.md
    cat $rke2versiontmp >> release-notes/README.md
    echo -e "\n" >> release-notes/README.md
done

echo "# k3s" >> release-notes/README.md
for minor in v1.20 v1.21 v1.22 v1.23 v1.24 v1.25 v1.26; do
    product=k3s
    > release-notes/${product}-${minor}.md
    k3stable=$(mktemp)
    k3sversiontmp=$(mktemp)
    previous=""
    echo "| Version | Date | US date | EU date |" >> $k3sversiontmp
    echo "| ------- | ---- | ------- | ------- |" >> $k3sversiontmp
    for patch in $(gh release list -R "k3s-io/${product}" --exclude-drafts --exclude-pre-releases --limit=1000 | awk -F '\t' '{ print $3 }' | grep ^"${minor}"); do
        publish_date=$(gh release view "${patch}" -R "k3s-io/${product}" --json publishedAt -q '.publishedAt' | awk -F'T' '{ print $1 }')
        echo "| [${patch}](${product}-${minor}.md#release-$(generate_markdown_link $patch)) | $(date +"%b %d %Y" -d "${publish_date}") | $(date +"%D" -d "${publish_date}") | $(date +"%F" -d "${publish_date}") |" >> $k3sversiontmp
        echo "# Release ${patch}" >> release-notes/${product}-${minor}.md
        gh release view "${patch}" -R "k3s-io/${product}" --json body -q '.body' >> release-notes/${product}-${minor}.md
        echo "-----" >> release-notes/${product}-${minor}.md
        body=$(gh release view "${patch}" -R "k3s-io/${product}" --json body -q '.body')
        if [ -z "${previous}" ]; then
            echo -n "| k3s version" >> $k3stable
            echo "$body"  | grep "^|" | tail -n+3 | awk -F'|' '{ print $2 }' | while read column; do echo -n "| $column " >> $k3stable; done
            echo " |" >> $k3stable
            echo -n "| ----- " >> $k3stable
            echo "$body"  | grep "^|" | tail -n+3 | awk -F'|' '{ print $2 }' | while read column; do echo -n "| ----- " >> $k3stable; done
            echo " |" >> $k3stable
        fi
        echo -n "| $patch " >> $k3stable
        echo "$body"  | grep "^|" | tail -n+3 | awk -F'|' '{ print $3 }'; while read column; do echo -n "| $column " >> $k3stable; done
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
