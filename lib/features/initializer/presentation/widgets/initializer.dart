// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:control_asistencia_2/router/app_routes.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/api_services/api.dart';
import '../../../../injection_container.dart';
import '../../../register/presentation/widgets/obtain_unique_number.dart';

// ignore: must_be_immutable
class Initializer extends StatelessWidget {
  final UniqueNumber uniqueNumber = UniqueNumber();
  SharedPreferences sharedPreferences;

  Initializer({super.key, required this.sharedPreferences});

  Future<Map<String, dynamic>> verifyCode() async {

    DateTime now = DateTime.now();
    final newDate = DateFormat('yyyy-MM-dd').format(now);

    final assistanceInfo = sl<AssistanceInfo>();
    final data = await assistanceInfo.fetchLastCheck();
    String newLastDate;

    if(data['date'] != null) {
      DateTime lastDate = DateTime.parse(data['date']);
      newLastDate = DateFormat('yyyy-MM-dd').format(lastDate);
    } else {
      newLastDate = "";
    }

     bool compareDates = newDate == newLastDate;

    final authenticate = sl<Authenticate>();

    int code = await uniqueNumber.getValue();
    bool verify = await authenticate.verifiCodeApi(code.toString());
    return {
      'verify' : verify,
      'compareDates' : compareDates,

    };
  }

  @override
  Widget build(BuildContext context) {
    final userInfo = sl<UserInfo>();
    final oneSignal = sl<UpdateSignalId>();
    return FutureBuilder<Map<String, dynamic>>(
      future: verifyCode(),
      builder: (context, snapshot) {
        final verify = snapshot.data?['verify'];
        final compareDates = snapshot.data?['compareDates'];
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(
              child: AppRoutes.loadingRout,
            ),
          );
        } else if (snapshot.hasError) {
          return Scaffold(
            body: Center(
              child: Text('Error: ${snapshot.error}'),
            ),
          );
        } else if (snapshot.hasData) {
          WidgetsBinding.instance.addPostFrameCallback((_) async {
            await userInfo.getUserInfo();
            oneSignal.updateOneSignalId();
            if(compareDates) {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => AppRoutes.sameDay),
              );
            } else {
              if (verify!) {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => AppRoutes.registeredRout),
                );
              } else {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => AppRoutes.noRegisteredRoute),
                );
              }
            }
          });
          return Container();
        } else {
          return const Scaffold(
            body: Center(
              child: Text('No se recibieron datos'),
            ),
          );
        }
      },
    );
  }
}
