class Remotedatasource{
  final String codigoCorrecto = '1234';
  
  void verificar(String codigo, Function(bool) callback) {
    if (codigo == codigoCorrecto) {
      callback(true); // Llama al callback con true si el código es correcto
    } else {
      callback(false); // Llama al callback con false si el código es incorrecto
    }
  }
}