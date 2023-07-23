<?php
 include "config.php";
 
$postID = mysqli_real_escape_string($connect, $_POST['postID']);
$username = mysqli_real_escape_string($connect, $_POST['username']);
$result = mysqli_query($connect,"delete * from user_likes where postID= '$postID' and username = '$username'");
if($result >0){
    echo json_encode("Post Unliked");   
}else{
    echo json_encode("Some Error Occured");
}
?>