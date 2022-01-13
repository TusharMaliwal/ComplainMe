<?php 
include "config.php";
// REGISTER USER
$email = mysqli_real_escape_string($connect, $_POST['email']);
$password = mysqli_real_escape_string($connect, $_POST['password']);
$vkey = md5($email);

$result = mysqli_query($connect,"SELECT email FROM user_authentication where email='$email'");
$num_rows = mysqli_num_rows($result);
if($num_rows >= 1){
    //Email already exists
    echo json_encode("User exists");
}else{
    $query = "INSERT INTO user_authentication VALUES('$email','$password','$vkey',0)";
    $results = mysqli_query($connect, $query);
    if($results>0)
    {
        //User registered
        echo json_encode("User registered");
        $to = $email;
        $subject = 'Email Verification for ComplainMe App';
        $message = "<a href='http://192.168.1.13:8000/complain_me-app/verify.php?vkey=$vkey'>http://192.168.1.13/complain_me-app/verify.php?vkey=$vkey</a>
		    <a> If You can't Open this link Then Paste This link in Your Browser</a>";
        $headers = "From: medicare690@gmail.com \r\n";
        $headers .= "MIME-Version: 1.0"."\r\n";
        $headers .= "Content-type:text/html;charset=UTF-8"."\r\n";
        
        mail($to,$subject,$message,$headers);
    }
}
?>