#!/usr/bin/env bash

PUBLIC_DIR=public
PUBLIC_SWAGGER_DIR=${PUBLIC_DIR}/swagger-ui
SWAGGER_UI_ARCHIVE_FILE=swagger-ui.tar.gz

# Does swagger-ui folder exist?
if [ ! -d "$PUBLIC_SWAGGER_DIR" ]
then
    echo "Creating dir at ${PUBLIC_SWAGGER_DIR}"
    mkdir -p ${PUBLIC_SWAGGER_DIR}
fi

# Check swagger-ui folder empty?
if [ ! -z "$(ls -A ${PUBLIC_SWAGGER_DIR})" ]; then
    read -p "Remove all files inside ${PUBLIC_SWAGGER_DIR}/ (y/n)? " choice
    case "$choice" in
      y|Y ) rm -riv ${PUBLIC_SWAGGER_DIR}/*;;
      n|N ) echo "no";;
      * )
        echo "invalid"
        exit -1
      ;;
    esac
fi

echo
echo " === Get latest release information"
echo
RELEASE_INFORMATION=$(curl --silent https://api.github.com/repos/swagger-api/swagger-ui/releases/latest)

RELEASE_VERSION=$(echo $RELEASE_INFORMATION | jq -r '.tag_name')
RELEASE_URL=$(echo $RELEASE_INFORMATION | jq -r '.tarball_url')

echo
echo " === Latest release tag: ${RELEASE_VERSION}"
echo
echo " === Download to ${SWAGGER_UI_ARCHIVE_FILE}"
echo
curl --location --output "${PUBLIC_SWAGGER_DIR}/${SWAGGER_UI_ARCHIVE_FILE}" ${RELEASE_URL}

echo
echo " === Extract contents"
echo
pushd "${PUBLIC_SWAGGER_DIR}"
tar -xvf "${SWAGGER_UI_ARCHIVE_FILE}" --wildcards swagger-api-swagger-ui-*/dist/* --strip-components=2
popd

echo
echo " === Remove downloaded archive"
echo
rm -iv "${PUBLIC_SWAGGER_DIR}/${SWAGGER_UI_ARCHIVE_FILE}"

echo
echo " === DONE"
echo
echo "Installed swagger-ui at ${PUBLIC_SWAGGER_DIR}/"