<?php
include "config.php"; 
$username = mysqli_real_escape_string($connect, $_POST['username']);
$sql = mysqli_query($connect,"select * from user_post where username='$username'");
$res = array();
if($sql){
    while($row=$sql->fetch_assoc()){
        $res[]=$row;
    }
    echo json_encode($res);
}else{
    echo json_encode('Error loading data');
}
?>