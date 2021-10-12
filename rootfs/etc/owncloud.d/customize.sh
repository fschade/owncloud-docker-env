#!/usr/bin/env bash

envs=(
	TRAEFIK_HOST
	TRAEFIK_ACME_MAIL
	GITHUB_ACCESS_TOKEN
	OWNCLOUD_LICENSE_KEY
	OWNCLOUD_WOPI_TOKEN_KEY
	OWNCLOUD_WOPI_OFFICE_ONLINE_SERVER
	OWNCLOUD_WOPI_PROXY_URL
	OWNCLOUD_OIDC_PROVIDER_URL
	OWNCLOUD_OIDC_POST_LOGOUT_REDIRECT_URL
	OWNCLOUD_OIDC_CLIENT_ID
	OWNCLOUD_OIDC_CLIENT_SECRET
	OWNCLOUD_OIDC_SCOPES_API
)

for env in "${envs[@]}"
do
	if [[ -z "${!env}" ]]
	then
		echo "env ${env} missing ..."
		false
	fi
done

if [ ! -d /mnt/data/apps/wopi ]
then
	echo "Installing wopi app..."
	git clone https://${GITHUB_ACCESS_TOKEN}@github.com/owncloud/wopi.git /mnt/data/apps/wopi
	# workaround: wopi.git master also has version 1.5.0, oc only uses apps in mnt/datta/apps/appname
	# if the version is greater then same app in /var/www/owncloud/apps/wopi
	rm -R /var/www/owncloud/apps/wopi
	composer install --working-dir /mnt/data/apps/wopi
	occ app:enable wopi
fi

if [ ! -d /mnt/data/apps/msteamsbridge ]
then
	echo "Installing msteamsbridge app..."
	git clone https://${GITHUB_ACCESS_TOKEN}@github.com/owncloud/msteamsbridge.git /mnt/data/apps/msteamsbridge
	composer install --working-dir /mnt/data/apps/msteamsbridge
	occ app:enable msteamsbridge
fi

echo "Installing web app..."
occ market:install -n web

echo "Installing openidconnect app..."
occ market:install -n openidconnect

true
