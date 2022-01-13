<?php

include 'config.php';

    // Process verification
    $email = mysqli_real_escape_string($connect, $_POST['email']);

    $vkey = md5(email);

    $to = $email;
    $subject = 'Email Verification for ComplainMe App';
    $message = "<a href='http://192.168.1.13:8000/complain_me-app/verify.php?vkey=$vkey'>http://192.168.1.13:8000/complain_me-app/verify.php?vkey=$vkey</a>
	    <a> If You can't Open this link Then Paste This link in Your Browser</a>";
    $headers = "From: medicare690@gmail.com \r\n";
    $headers .= "MIME-Version: 1.0"."\r\n";
    $headers .= "Content-type:text/html;charset=UTF-8"."\r\n";
    
    mail($to,$subject,$message,$headers);
?>