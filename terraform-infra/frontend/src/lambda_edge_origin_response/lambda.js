'use strict';

exports.handler = (event, context, callback) => {
	const response = event.Records[0].cf.response;
	const headers = response.headers;

	headers['strict-transport-security'] = [{key: 'Strict-Transport-Security', value: 'max-age=63072000; includeSubdomains; preload'}];
	const securityPolicies = {
		'default-src': ["'self'",'*.cabd.link'],
		'img-src': [
			"'self'",
			'data:',
			'*.cabd.link',
			'http://*.hotjar.com',
			'https://*.hotjar.com',
			'http://*.hotjar.io',
			'https://*.hotjar.io',
			'https://api.privally.global',
			'https://app.privally.global',
			'*',
		],
		'font-src': [
			"'self'",
			'*.cabd.link',
			'fonts.gstatic.com',
			'http://*.hotjar.com',
			'https://*.hotjar.com',
			'http://*.hotjar.io',
			'https://*.hotjar.io',
		],
		'connect-src':[
			"'self'",
			'data:',
			'*.cabd.link',
			'*.cloudfront.net',
			'www.google-analytics.com',
			'https://analytics.conpass.io/v2/',
			'https://stats.g.doubleclick.net',
			'https://*.youtube.com',
			'https://cdn.cookielaw.org'
		],
		'style-src': [
			"'self'",
			"'unsafe-inline'",
			'*.cabd.link',
			'fonts.googleapis.com',
			'*.cloudfront.net',

		],
		'media-src': [
			"'self'",
			'*.cabd.link',
			'https://*.youtube.com',
			'*.cloudfront.net',
		],
		'script-src': [
			"'self'",
			"'unsafe-eval'",
			"'unsafe-inline'",
			'www.gstatic.com',
			'www.googletagmanager.com',
			'www.google-analytics.com',
			'storage.googleapis.com',
			'*.cabd.link',
			'*.cloudfront.net',
		],
		'script-src-elem': [
			"'self'",
			"'unsafe-inline'",
			'www.gstatic.com',
			'www.googletagmanager.com',
			'www.google-analytics.com',
			'storage.googleapis.com',
			'*.cabd.link',
			'*.cloudfront.net',
		],
		'prefetch-src': [
			"'self'",
			'*.cabd.link',
			'*.cloudfront.net',
		],
		'frame-ancestors': [
			"'self'",
			'*.cabd.link',
			'*.cloudfront.net',
		],
		'frame-src': [
			"'self'",
			'*.cabd.link',
			'https://*.youtube.com',
			'*.cloudfront.net',
		],
		'form-action': [
			"'self'",
		],
		'base-uri': [
			"'self'",
		],
		'object-src': [
			"'self'",
		],
		'manifest-src': [
			"'self'",
		]

	}

	const contentSecurityPolicyValue = Object.keys(securityPolicies)
		.map(directive => `${directive} ${securityPolicies[directive].join(' ')}`)
		.join('; ');

	headers['content-security-policy'] = [{key: 'Content-Security-Policy', value: `${contentSecurityPolicyValue};`}];
	headers['x-content-type-options'] = [{key: 'X-Content-Type-Options', value: 'nosniff'}];
	headers['x-frame-options'] = [{key: 'X-Frame-Options', value: 'SAMEORIGIN'}];
	headers['x-xss-protection'] = [{key: 'X-XSS-Protection', value: '1; mode=block'}];
	headers['referrer-policy'] = [{key: 'Referrer-Policy', value: 'origin'}];

	callback(null, response);
};

