<?php
include 'config.sample.inc.php';

$cfg['Servers'][1]['host']            = $_ENV['MYSQL_PORT_3306_TCP_ADDR'];
$cfg['Servers'][1]['AllowNoPassword'] = true;
$file_with_secret                     = 'config.inc.secret.php';

if (!file_exists($file_with_secret)) {
	$secret = hash('sha512', openssl_random_pseudo_bytes(1000));
	file_put_contents(
		$file_with_secret,
		"<?php \$cfg['blowfish_secret'] = '$secret';"
	);
}

include $file_with_secret;
