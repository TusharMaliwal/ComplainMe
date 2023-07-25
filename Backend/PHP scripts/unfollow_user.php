<?php
 include "config.php";
 
$follower = mysqli_real_escape_string($connect, $_POST['follower']);
$following = mysqli_real_escape_string($connect, $_POST['following']);

$result = mysqli_query($connect,"Delete from user_following where follower='$follower' and following='$following'");
if($result >0){
    echo json_encode("Unfollowed");   
}else{
    echo json_encode("Some Error Occured");
}
?>