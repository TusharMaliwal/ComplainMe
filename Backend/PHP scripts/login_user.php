<?php
include "config.php";

$email = mysqli_real_escape_string($connect, $_POST['email']);
$password = mysqli_real_escape_string($connect, $_POST['password']);
$result = mysqli_query($connect,"select * from user_authentication where email = '$email' and password = '$password'");
$num_rows = mysqli_num_rows($result);
echo "This is $email";
if($num_rows >=1){
    $row = $result->fetch_assoc();
        // Login user
    //echo "Succes";
    echo json_encode("Login Success");   
}else{
    echo json_encode("Invalid Credentials");
}
?>