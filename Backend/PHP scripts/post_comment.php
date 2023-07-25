<?php
include "config.php"; 

$postID = mysqli_real_escape_string($connect, $_POST['postID']);
$username = mysqli_real_escape_string($connect, $_POST['username']);
$comment = mysqli_real_escape_string($connect, $_POST['comment']);
$datePublished = date('Y-m-d', strtotime($_POST['datePublished']));
$commentID = uniqid($username.$postID);

$query = "INSERT INTO user_comments VALUES('$commentID','$postID','$username','$comment','$datePublished')";
$results = mysqli_query($connect, $query);
if($results>0)
    echo json_encode("SUCCESS");
else
    echo json_encode("FAILED");