<?php
include "config.php";

$email = mysqli_real_escape_string($connect, $_POST['email']);
$password = mysqli_real_escape_string($connect, $_POST['password']);
$result = mysqli_query($connect,"SELECT email FROM user_authentication where email='$email'and password='$password'");
$num_rows = mysqli_num_rows($result);
	if($num_rows >= 1){
        	//Email already exists
            	echo json_encode("Success");
        }else{
		echo json_encode("Invalid Credentials");
	}
?>