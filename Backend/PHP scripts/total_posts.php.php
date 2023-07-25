<?php 
include "config.php";

$username = mysqli_real_escape_string($connect, $_POST['username']);
$sql1 = mysqli_query($connect,"select * from user_post where username='$username'");
$res = "Error";
$num_rows = mysqli_num_rows($sql1);
$res = array("length"=>$num_rows);
echo json_encode($res);