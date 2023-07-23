<?php
 include "config.php";
 
$sql = $connect->query($connect,"select * from user_post");
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