<?php 
include "config.php";

$email = mysqli_real_escape_string($connect, $_POST['email']);
$name = mysqli_real_escape_string($connect, $_POST['name']);
$house_name = mysqli_real_escape_string($connect, $_POST['house_name']);
$city_name = mysqli_real_escape_string($connect, $_POST['city_name']);
$street_name = mysqli_real_escape_string($connect, $_POST['street_name']);
$state_name = mysqli_real_escape_string($connect, $_POST['state_name']);
$country_name = mysqli_real_escape_string($connect, $_POST['country_name']);
$postal_code = mysqli_real_escape_string($connect, $_POST['postal_code']);

$query = "INSERT INTO user_details (email,name,house_name,street_name,city_name,state_name,country_name,postal_code) VALUES('$email','$name','$house_name','$street_name','$city_name','$state_name','$country_name','$postal_code')";
$results = mysqli_query($connect, $query);
if($results>0)
{
    //Data added
    echo json_encode("SUCCESS");
}else{
    //Data not added
    echo json_encode("FAILED");
}
    
?>