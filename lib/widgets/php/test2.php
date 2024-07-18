<?php

require_once("openDB.php");
$dbtable = "personal_tb";
$SQLquery = "SELECT * FROM $dbtable";

$stm = $db->prepare($SQLquery);
$stm->excecute();

$registros = $stm->fetchALL(mysqli::FETCH_ASSOC);

$myArreglo = array();

foreach($registros as $registro) {
    $myArreglo[]=$registro;
}

echo json_encode($myArreglo);

?>