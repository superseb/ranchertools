#!/usr/bin/env bash
function transform_image_to_link()
{
    local image=$1
    repository=$(echo $image | awk -F':' '{ print $1 }')
    tag=$(echo $image | awk -F':' '{ print $2 }')
    echo "[${tag}](## \"${repository}\")"
}

for release in v2.8 v2.7 v2.6; do
    KDM_DATA_FILE=$(mktemp)
    wget "https://releases.rancher.com/kontainer-driver-metadata/release-${release}/data.json" -O $KDM_DATA_FILE
    for k8s_minor in v1.27 v1.26 v1.25 v1.24 v1.23 v1.22 v1.21 v1.20; do
        previous=""
        kdmtable=$(mktemp)
        for found_version in $(jq -r --arg K8SMINOR "$k8s_minor" '.K8sVersionRKESystemImages | with_entries(select(.key | startswith($K8SMINOR))) | keys[]' $KDM_DATA_FILE | sort -Vr); do
            if [ -z "${previous}" ]; then
                > "kdm/${release}/${k8s_minor}.md"
                echo "# ${k8s_minor} (Rancher ${release})" >> $kdmtable
                echo -e "\n**Note:** Version links are only present to provide image name on hover\n" >> $kdmtable

                echo -n "| k8s version" >> $kdmtable
                found_components=$(jq -r --arg K8SVERSION "$found_version" '.K8sVersionRKESystemImages[$K8SVERSION] | keys_unsorted[]' $KDM_DATA_FILE)
                for column in $found_components; do
                    echo -n "| ${column}" >> $kdmtable
                done
                echo " |" >> $kdmtable
                echo -n "| ----- " >> $kdmtable
                for column in $found_components; do
                    echo -n "| ----- " >> $kdmtable
                done
                echo " |" >> $kdmtable
            fi
            echo -n "| \`$found_version\` " >> $kdmtable
            found_component_values=$(jq -r --arg K8SVERSION "$found_version" '.K8sVersionRKESystemImages[$K8SVERSION] | to_entries[] | .value' $KDM_DATA_FILE)
            for component_version in $found_component_values; do
                echo -n "| $(transform_image_to_link $component_version)" >> $kdmtable
            done
            echo " |" >> $kdmtable
            previous=$found_version
        done
        if [ -s "${kdmtable}" ]; then
            echo -e "\n\n" >> $kdmtable
            cat $kdmtable >> "kdm/${release}/${k8s_minor}.md"
        fi
    done
done
