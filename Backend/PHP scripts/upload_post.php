<?php 
include "config.php";

$description = mysqli_real_escape_string($connect, $_POST['description']);
$username = mysqli_real_escape_string($connect, $_POST['username']);
$datePublished = date("Y-m-d",strtotime($_POST['datePublished']));
$postID = uniqid($username);

$targetDir = "PostPics/";
$fileName = $postID;//basename($_FILES["file"]["name"]);
$targetFilePath = $targetDir . $fileName;
$fileType = pathinfo($targetFilePath,PATHINFO_EXTENSION);

if(move_uploaded_file($_FILES["file"]["tmp_name"], $targetFilePath)){
    $query = "INSERT INTO user_post VALUES('$postID','$username','$fileName','$description','$datePublished')";

    $results = mysqli_query($connect, $query);
    if($results>0)
        echo json_encode("SUCCESS");
    else
        echo json_encode("FAILED");
}
else{
    echo json_encode("Some Problem in Storing Post");
}