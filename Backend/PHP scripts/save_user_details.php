<?php 
include "config.php";

$email = mysqli_real_escape_string($connect, $_POST['email']);
$username = mysqli_real_escape_string($connect, $_POST['username']);
$bio = mysqli_real_escape_string($connect, $_POST['bio']);
$firstname = mysqli_real_escape_string($connect, $_POST['firstName']);
$lastName = mysqli_real_escape_string($connect,$_POST['lastName']);
$password = mysqli_real_escape_string($connect,$_POST['password']);

$targetDir = "Profilepics/";
$fileName = basename($_FILES["file"]["name"]);
$targetFilePath = $targetDir . $fileName;
$fileType = pathinfo($targetFilePath,PATHINFO_EXTENSION);


$allowTypes = array('jpg','png','jpeg','gif');
//if(in_array($fileType, $allowTypes)){
    // Upload file to server
    if(move_uploaded_file($_FILES["file"]["tmp_name"], $targetFilePath)){
        $result = mysqli_query($connect,"SELECT email FROM user_authentication where email='$email'");
        $num_rows = mysqli_num_rows($result);
        if($num_rows >= 1){
            //Email already exists
            echo json_encode("User exists");
        }else{
            $query = "INSERT INTO user_authentication VALUES('$email','$password')";
            $results = mysqli_query($connect, $query);
            if($results>0)
            {
                //User registered
                // Insert image file name into database and other details
                $query = "INSERT INTO user_details  VALUES('$email','$username','$firstname','$lastName','$bio','$fileName')";
                $results = mysqli_query($connect, $query);
                if($results>0)
                {
                    //Data added
                    echo json_encode("SUCCESS");
                }else{
                    //Data not added
                    //TODO code for failing version
                    echo json_encode("FAILED and todo");
                }
    
            }
            else{
                echo json_encode("FAILED");
            }
    
        }
    }
    else{
        echo json_encode("Some Problem in Storing image");
    }
//}
//else{
  //  echo json_encode("Only 'jpg','png','jpeg','gif' are allowed");
//}

?>