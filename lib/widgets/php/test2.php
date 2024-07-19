
<?php
    $host       = "localhost";
    $user       = "jcvctechno23_demo";
    $pass       = "tKP&66^K+Y*z";
    $database   = "jcvctechno23_demo";
 
    $connect = new mysqli($host, $user, $pass, $database);

    if (!$connect) {
        die(json_encode(array('error' => 'Connection failed: ' . $connect->connect_error)));
    } else {
        $connect->set_charset('utf8');
    }
    header('Access-Control-Allow-Origin: *');
	
	header("Access-Control-Allow-Headers: Origin, X-Requested-With, Content-Type, Accept");
	header('Access-Control-Allow-Methods: GET, POST, PUT, DELETE');
	header('Content-Type: multipart/form-data; charset=utf-8');

    if(isset($_GET['verify_db'])){

    }
    else if(isset($_GET['authenticate'])){
        $code_verification = $connect->real_escape_string($_GET['authenticate']);

        // Verificar credenciales y código de verificación
        $sql = "SELECT * FROM user WHERE code_verification='$code_verification'";
        header('Content-Type: application/json; charset=utf-8');
        $result = $connect->query($sql);

        if ($result->num_rows > 0) {
            //echo json_encode($result);
            echo json_encode(true);
        } else {
            echo json_encode(false);
        }
        exit;
    }

    $connect->close();
?>
