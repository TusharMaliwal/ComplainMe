<?php 
include "config.php";
$username = mysqli_real_escape_string($connect, $_POST['username']);
$sql = $connect->query("SELECT * FROM  user_details WHERE 
username LIKE '$username'");
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