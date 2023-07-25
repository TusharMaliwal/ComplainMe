<?php
 include "config.php";
 
$postID = mysqli_real_escape_string($connect, $_POST['postID']);
$username = mysqli_real_escape_string($connect, $_POST['username']);
$likeID = uniqid($username.$postID);
$result = mysqli_query($connect,"Insert into user_likes values ('$likeID','$username','$postID')");
if($result >0){
    echo json_encode("Post liked");   
}else{
    echo json_encode("Some Error Occured");
}
?>