#!/usr/bin/php8.1

<?php
$user='gerard';
$host='localhost';
$port='3306';
$passwd='password';
$db='altschool';


$conn=mysqli_connect($host,$user,$passwd,$db);
if(!$conn){
	echo 'succes';
}else{
echo 'failed';
}





?>

