<?php

	$data = "Hello World";

	$key = "57119C07F45756AF6E81E662BE2CCE62";
	// $iv = openssl_random_pseudo_bytes(16);

	$iv = base64_decode("s1z17IG98Ph14L7zTqoRbg==");

	echo "iv: " . base64_encode($iv) . "<br />";

	// $encrypted = openssl_encrypt($data, 'aes-256-cbc', $key, false, $iv);

	$encrypted = "Jb42THYPRX726u5rvIKtfQ==";

	echo "encrypted: " . $encrypted . "<br />";

	$decrypted = openssl_decrypt($encrypted, 'aes-256-cbc', $key, false, $iv);

	echo "decrypted: " . $decrypted . "<br />";

	echo "<hr />";
	
?>
