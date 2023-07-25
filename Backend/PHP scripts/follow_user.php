<?php
 include "config.php";
 
$follower = mysqli_real_escape_string($connect, $_POST['follower']);
$following = mysqli_real_escape_string($connect, $_POST['following']);

$result = mysqli_query($connect,"Insert into user_following values ('$follower','$following')");
if($result >0){
    echo json_encode("Followed");   
}else{
    echo json_encode("Some Error Occured");
}
?>