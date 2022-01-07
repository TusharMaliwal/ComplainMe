<?php
$servername = "localhost";
$database = "complain_me_app";
$username = "root";
$password = "";
// Create connection
$connect = mysqli_connect($servername, $username, $password, $database,3307);
// Check connection
if (!$connect) {
    echo json_encode("Connection Failed");
}
?>