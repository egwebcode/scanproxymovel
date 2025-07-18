<?php
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $user = $_POST['username'] ?? '';
    $pass = $_POST['password'] ?? '';

    if ($user === 'admin' && $pass === 'notfound404') {
        echo "Login OK";
    } else {
        echo "Login FAIL";
    }
}
?>