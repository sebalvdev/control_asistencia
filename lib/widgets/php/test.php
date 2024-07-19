
<?php
  $host       = "localhost";
  $user       = "jcvctechno23_demo";
  $pass       = "tKP&66^K+Y*z";
  $database   = "jcvctechno23_demo";
 
    $connect = new mysqli($host, $user, $pass, $database);

    if (!$connect) {
        die ("connection failed: " . mysqli_connect_error());
    } else {
        $connect->set_charset('utf8');
    }
    header('Access-Control-Allow-Origin: *');
	
	header("Access-Control-Allow-Headers: Origin, X-Requested-With, Content-Type, Accept");
	header('Access-Control-Allow-Methods: GET, POST, PUT, DELETE');
	header('Content-Type: multipart/form-data; charset=utf-8');
if(isset($_GET['codigo'])){
    
    $code_sim = $_GET['codigo'];
    $query = "SELECT * from user where code_verification = '$code_sim'";			
	$resouter = mysqli_query($connect, $query);

	header('Content-Type: application/json; charset=utf-8');
	$total_records = mysqli_num_rows($resouter);
	    if($total_records >= 1) {
	      	while ($link = mysqli_fetch_array($resouter, MYSQLI_ASSOC)){
	        $content = array("code_verification" => $link['code_verification'],"id_user" => $link['id_user'],"name_user" => $link['name_user'],"lastname_user" => $link['lastname_user'],"image_user"=>$link['image_user'],"one_signal_id"=>$link['one_signal_id']);
	        echo $val = str_replace('\\/', '/', json_encode($content));
	        exit;
	      }
	    }
        $content = array("code_verification" => null);
	    echo $val = str_replace('\\/', '/', json_encode($content));
	    exit;
}
else if(isset($_GET['notifications'])){
    
    $code_sim = $_GET['notifications'];
    $date = date('Y-m-d');
    $query = "SELECT DISTINCT notifications.notifications_id, notifications.message,notifications.date_time,notifications.user_id from notifications, `user` where (`user`.`id_user` = notifications.user_id and `user`.`code_verification` = '$code_sim' and '$date' >= notifications.date_time ) or (notifications.user_id = 0 and '$date' >= notifications.date_time) ORDER BY notifications.date_time  DESC";			
	$resouter = mysqli_query($connect, $query);
    
	header('Content-Type: application/json; charset=utf-8');
	$array = array();
	$total_records = mysqli_num_rows($resouter);
	    if($total_records >= 1) {
	      	while ($link = mysqli_fetch_array($resouter, MYSQLI_ASSOC)){
	        $array[] = $link;
	      }
	    }
	echo $val = str_replace('\\/', '/', json_encode($array));
	exit;
}
else if(isset($_GET['update_signal_id'])){
    $update_signal_id = $_GET['update_signal_id'];
    $user_id = $_GET['user_id'];
    $exist_ios = $_GET['ios'];//default android
    if(!$exist_ios || $exist_ios == null){
        $exist_ios = 0;
    }
    else{
        $exist_ios = 1;
    }
    header('Content-Type: application/json; charset=utf-8');
    $query = "UPDATE user SET one_signal_id = '$update_signal_id',platform_user = $exist_ios WHERE id_user = $user_id";
    $resouter = mysqli_query($connect, $query);
    $content = array("success" => true,"onesignal_id" => $update_signal_id);
    echo $val = str_replace('\\/', '/', json_encode($content));
    exit;
}
else if(isset($_GET['get_unique'])){
    $v1 = rand(100,999);
    $v2 = rand(100,999);
    $v3 = rand(100,999);
    $key_search = $v1.''.$v2.''.$v3;

    $query = "SELECT * from user where code_verification = '$key_search'";			
	$resouter = mysqli_query($connect, $query);
    
	$total_records = mysqli_num_rows($resouter);
	header('Content-Type: application/json; charset=utf-8');
	$content = array("success" => false,"key" => $key_search);
	if($total_records == 0) {
	   $content = array("success" => true,"key" => $key_search,"message"=>'Generando codigo unico');
	}
    
	echo $val = str_replace('\\/', '/', json_encode($content));
	exit;
}
else if(isset($_GET['find'])){
    $code_sim = $_GET['find'].'.jpg';
    $id_user = $_GET['id_user'];
    $day = $_GET['day'];
    
    $query_qr = "SELECT * from configuration where id_configuration='2'";
    
	$resouter_qr = mysqli_query($connect, $query_qr);
	$total_records_qr = mysqli_num_rows($resouter_qr);
	$query = "SELECT * from calendary where image_calendary = '$code_sim' AND day_calendary = '$day'";
	if($total_records_qr >= 1) {
	    while ($link_qr = mysqli_fetch_array($resouter_qr, MYSQLI_ASSOC)){
	        if($link_qr['logo_payment_receive'] == '1'){//qr semanal
	            $query = "SELECT * from calendary where image_calendary = '$code_sim'";
	        }
	        break;
	    }
	}
    //para poner limite
    $datetime_init = date("Y-m-d 06:00:01");
    $datetime_fin = date("Y-m-d 23:00:01");
    
	$resouter = mysqli_query($connect, $query);
	$total_records = mysqli_num_rows($resouter);
	
	header('Content-Type: application/json; charset=utf-8');
	if($total_records >= 1) {
	    while ($link = mysqli_fetch_array($resouter, MYSQLI_ASSOC)){
	        //buscar la ubicacion del usuario
	        $registration = "No encontrado";
	        $location_find = false;

            $query_location_user = "SELECT l.id_location,l.name_location,l.latitude,l.longitude,l.zoom 
             FROM location_user lu,location l,user u where u.id_user='$id_user' AND u.status_user='1' AND l.id_location = lu.id_location AND lu.id_user = u.id_user";
            $resouter_location_user = mysqli_query($connect, $query_location_user);
            $total_records_type = mysqli_num_rows($resouter_location_user);
            if($total_records_type == 0) {
                $content = array("success" => false,"message"=>'Usuario inactivo, consulte con su administrador');
                echo json_encode($content);
	            exit;
            }
            while ($location_user = mysqli_fetch_array($resouter_location_user, MYSQLI_ASSOC)){
                $id_location = $location_user['id_location'];
                $circle_x = $location_user['latitude'];
                $circle_y = $location_user['longitude'];
                $radio = floatval(($location_user['zoom'])/(25000));
                $x = $_GET['latitude'];
	            $y = $_GET['longitude'];

	            $x = $circle_x;
                $y = $circle_y;
                $X = $_GET['latitude'];
                $Y = $_GET['longitude'];
                $w = $radio;
                $W = 0;
	            $S = $X - $x;
                $D = $Y - $y;
                $F = $w + $W;
                $result = ($S * $S + $D * $D <= $F * $F);
                if($result){
                    $registration = $location_user['name_location'];
                    $location_find = true;
                }
            }
            if($location_find == true){
                $query_type = "SELECT count(type_assistance) AS type_assistance from assistance where id_user = '$id_user' AND datetime_assistance > '$datetime_init'";	
                $resouter_type = mysqli_query($connect, $query_type);
                $total_records_type = mysqli_num_rows($resouter_type);
                $type_assistance = 'Salida';//default
                if($total_records_type >= 1) {
                    while ($asistence = mysqli_fetch_array($resouter_type, MYSQLI_ASSOC)){
                        $type_assistance = $asistence['type_assistance']%2 == 0 ?'Ingreso':'Salida';
                        break;
                    }
                }
                else{
                    $type_assistance = 'Ingreso';
                }
                
    	        $browser_assistance = 'App Movil';
    	        $latitude_assistance = $_GET['latitude'];
    	        $longitude_assistance = $_GET['longitude'];
    	        $datetime_assistance = date("Y-m-d H:i:s");
    
    	        $new_query = "INSERT INTO assistance(id_user,datetime_assistance,type_assistance,latitude_assistance,longitude_assistance,browser_assistance,location)
    	        VALUES ($id_user,'$datetime_assistance','$type_assistance','$latitude_assistance','$longitude_assistance','$browser_assistance','$registration')";
                $insert = mysqli_query($connect, $new_query);
                $total_records2 = mysqli_num_rows($insert);
                $content = array("success" => true,"type_asistence" => $type_assistance,"date"=>$datetime_assistance,"registration"=>$registration);
            }
            else{
                $content = array("success" => false,"message"=>'Rango de Zona no permitido para poder marcar asistencia');
                echo json_encode($content);
	            exit;
            }
            
	    }
	}
	else{
	    $query_codigo = "SELECT * from calendary where image_calendary = '".$_GET['find']."'";				
    	$resouter_codigo = mysqli_query($connect, $query_codigo);
    	$total_record_codigo = mysqli_num_rows($resouter_codigo);
    	if($total_record_codigo == 0) {
    	    $content = array("success" => false,"message"=>'C贸digo QR no registrado, favor contactarse con los administradores');
    	}
    	else{
    	    $query_dia = "SELECT * from calendary where day_calendary = '$day'";				
        	$resouter_dia = mysqli_query($connect, $query_dia);
        	$total_record_dia = mysqli_num_rows($resouter_dia);
        	if($total_record_dia == 0) {
        	    $content = array("success" => false,"message"=>'El dia no corresponde, favor contactarse con los administradores');
        	}
    	}
	}
    
	echo json_encode($content);
	exit;
}

else if(isset($_GET['authenticate'])){
    $code_verification = $_GET['authenticate'];

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

?>
