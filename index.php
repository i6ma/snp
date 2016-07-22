<?php
include 'viewer.php';
$data = array(
    'title'     => 'hello world',
    'h1text'    => 'hello smarty',
);
if (rand(0, 9) < 5) {
    $data['debug']  = true;
}
tpl_display('page', $data);
