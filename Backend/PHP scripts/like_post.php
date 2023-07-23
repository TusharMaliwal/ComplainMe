<?php
 include "config.php";
 
$postID = mysqli_real_escape_string($connect, $_POST['postID']);
$username = mysqli_real_escape_string($connect, $_POST['username']);
$likeID = uniqid($username+$postID);
$result = mysqli_query($connect,"Insert into user_likes values ('$likeID','$postID','$username')");
if($result >0){
    echo json_encode("Post Unliked");   
}else{
    echo json_encode("Some Error Occured");
}
?>