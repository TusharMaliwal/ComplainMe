<?php
include "config.php"; 
$username = mysqli_real_escape_string($connect, $_POST['username']);
$res = array();

$following = array();
$sql = mysqli_query($connect,"select following from user_following where followers='$username'");
if($sql){
    while($row=$sql->fetch_assoc()){
        $following[]=$row['following'];
    }
}

$followers = array();
$sql = mysqli_query($connect,"select followers from user_following where following='$username'");
if($sql){
    while($row=$sql->fetch_assoc()){
        $followers[]=$row['followers'];
    }
}
$sql = $connect->query("SELECT * FROM user_details WHERE username='$username'");
if($sql){
    while($row=$sql->fetch_assoc()){
        $res[]=$row + array("followers"=>$followers) + array("following"=>$following);;
    }
    echo json_encode($res);
}
else{
    echo json_encode("Some Error Occured");
}

?>