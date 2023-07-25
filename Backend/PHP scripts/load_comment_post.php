<?php
include "config.php"; 
$postID = mysqli_real_escape_string($connect, $_POST['postID']);
$sql = mysqli_query($connect,"select * from user_comments where postID='$postID'");
$res = array();
if($sql){
    while($row=$sql->fetch_assoc()){
        $sql1 = mysqli_query($connect,"select * from user_details where username='$row[username]'");
        $details= array();
        while($row1=$sql1->fetch_assoc()){
            $details[]=$row1;
        }
        $res[]=$row+$details;
    }
    echo json_encode($res);
}else{
    echo json_encode('Error loading data');
}
?>