<?php
$CONFIG = [
	"openid-connect" => [
		"provider-url" => $_ENV["OWNCLOUD_OIDC_PROVIDER_URL"],
		"post_logout_redirect_uri" => $_ENV["OWNCLOUD_OIDC_POST_LOGOUT_REDIRECT_URL"],
		"client-id" => $_ENV["OWNCLOUD_OIDC_CLIENT_ID"],
		"client-secret" => $_ENV["OWNCLOUD_OIDC_CLIENT_SECRET"],
		"loginButtonName" => "Azure AD",
		"autoRedirectOnLoginPage" => false,
		"scopes" => [
			"openid",
			$_ENV["OWNCLOUD_OIDC_SCOPES_API"],
			"profile", "email", "offline_access",
		],
		"mode" => "email",
		"search-attribute" => "unique_name",
		"use-access-token-payload-for-user-info" => true,
		'auto-provision' => [
			'enabled' => true,
			'email-claim' => 'email',
			'display-name-claim' => 'name',
		],
	],
];
