<?php
header('Content-Type: application/json');

// Configuración de la base de datos
$servername = "localhost";
$username = "jcvctechno23";
$password = "s)U*G.lrIF-X";

$dbname = "jcvctechno23_demo";

// Crear conexión
$conn = new mysqli($servername, $username, $password, $dbname);

// Verificar conexión
if ($conn->connect_error) {
    die(json_encode(array('error' => 'Connection failed: ' . $conn->connect_error)));
}

// Datos de prueba
$test_data = array(
    'username' => 'jcvctechno23',
    'password' => 's)U*G.lrIF-X',
    'code_verification' => '123'
);

// Leer datos de la solicitud
$received_data = isset($test_data) ? $test_data : json_decode(file_get_contents("php://input"), true);
$username = $conn->real_escape_string($received_data['username']);
$password = $conn->real_escape_string($received_data['password']);
$code_verification = $conn->real_escape_string($received_data['code_verification']);

// Verificar credenciales y código de verificación
$sql = "SELECT * FROM user WHERE username='$username' AND password='$password' AND code_verification='$code_verification'";
$result = $conn->query($sql);

if ($result->num_rows > 0) {
    $response = array('status' => 'success', 'message' => 'Authenticated');
} else {
    $response = array('status' => 'error', 'message' => 'Invalid credentials or verification code');
}

echo json_encode($response);

$conn->close();
?>