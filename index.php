<?php
include 'viewer.php';
$data = array(
    'title'     => 'hello world',
    'h1text'    => 'hello smarty',
    'IS_DEV'    => rand(0, 9) < 5
);
tpl_display('page', $data);
