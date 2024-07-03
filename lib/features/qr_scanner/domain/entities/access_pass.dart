import 'package:equatable/equatable.dart';

class AccessPass extends Equatable{
  final String qrCode;

  const AccessPass({
    required this.qrCode
  });
  
  @override
  List<Object?> get props => [qrCode];
}