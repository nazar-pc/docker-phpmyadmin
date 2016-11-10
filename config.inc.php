<?php
include 'config.sample.inc.php';

if (!isset($_ENV['MYSQL_HOST']) && isset($_ENV['MYSQL_PORT_3306_TCP_ADDR'])) {
	$_ENV['MYSQL_HOST'] = $_ENV['MYSQL_PORT_3306_TCP_ADDR'];
}

$hosts = isset($_ENV['MYSQL_HOST']) ? $_ENV['MYSQL_HOST'] : 'mysql';
foreach (explode(',', $hosts) as $index => $host) {
	$config = &$cfg['Servers'][$index + 1];

	// split into host[:port], user and pass
	list($host, $user, $password) = explode(';', $host, 3) + [1 => '', 2 => ''];

	if (strpos($host, ':') !== false) {
		list($host, $port) = explode(':', $host);
		$config['port'] = $port;
	}
	$config['host'] = $host;

	if($user) {
		$config['user'] = $user;
	}

	if($password) {
		$config['auth_type'] = 'config';
		$config['password'] = $password;
	}

	$config['AllowNoPassword'] = true;

	$config = array_map('trim', $config);
}

if (isset($_ENV['ALLOW_ARBITRARY'])) {
	$cfg['AllowArbitraryServer'] = (bool)$_ENV['ALLOW_ARBITRARY'];
}

if (isset($_ENV['ABSOLUTE_URI'])) {
	$cfg['PmaAbsoluteUri'] = $_ENV['ABSOLUTE_URI'];
}

if (isset($_ENV['SESSION_TIMEOUT'])) {
	$cfg['LoginCookieValidity'] = $_ENV['SESSION_TIMEOUT'];
	ini_set('session.gc_maxlifetime', $_ENV['SESSION_TIMEOUT']);
}

$file_with_secret = 'config.inc.secret.php';

if (!file_exists($file_with_secret)) {
	$secret = hash('sha512', openssl_random_pseudo_bytes(1000));
	file_put_contents(
		$file_with_secret,
		"<?php \$cfg['blowfish_secret'] = '$secret';"
	);
}

include $file_with_secret;

if (isset($_ENV['JSON_CONFIG'])) {
	$custom = json_decode($_ENV['JSON_CONFIG'], true);

	$cfg = array_merge($cfg, $custom);
}

