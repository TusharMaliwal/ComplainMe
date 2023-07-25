//loading post details and likes and number of comments
<?php
include "config.php"; 
$sql = mysqli_query($connect,"select * from user_post");
$res = array();
if($sql){
    while($row=$sql->fetch_assoc()){
        $sql1 = mysqli_query($connect,"select username from user_likes where postID='$row[postID]'");
        $like= array();
        while($row1=$sql1->fetch_assoc()){
            $like[]=$row1['username'];
        }
        $sql1 = mysqli_query($connect,"select * from user_comments where postID='$row[postID]'");
	$num_rows = mysqli_num_rows($sql1);
        $res[]=$row+array("likes"=>$like) + array("comments"=>$num_rows);
    }
    echo json_encode($res);
}else{
    echo json_encode('Error loading data');
}
?>