<?php
 include "config.php";
 
$postID = mysqli_real_escape_string($connect, $_POST['postID']);
$result = mysqli_query($connect,"delete * from user_posts where postID= '$postID'");
if($result >0){
    echo json_encode("Deletion Success");   
}else{
    echo json_encode("No Post Found");
}
?>