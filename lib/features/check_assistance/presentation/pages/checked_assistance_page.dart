import '../../../../injection_container.dart';
import '../../../../router/app_routes.dart';
import '../../../../core/api_services/api.dart';
import '../widgets/exit_app.dart';
import '../widgets/widgets.dart';
import 'package:flutter/material.dart';

class CheckAssistanceScreen extends StatefulWidget {
  const CheckAssistanceScreen({super.key});

  @override
  State<CheckAssistanceScreen> createState() => _CheckAssistanceScreenState();
}

class _CheckAssistanceScreenState extends State<CheckAssistanceScreen> {

  @override
  void initState() {
    super.initState();
  }

  Future<Map<String, dynamic>> initialData() async {
    final logo = sl<Logo>();
    final notification = sl<Notifications>();
    
    final urlLogo = await logo.getLogo();
    final verifyNotify = await notification.verifyNotifications();

    return {
      'logo' : urlLogo,
      'notify' : verifyNotify,
    };
  }

  @override
  Widget build(BuildContext context) {

    return FutureBuilder<Map<String, dynamic>>(
      future: initialData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(
              child: AppRoutes.loadingRout,
            ),
          );
        } else if (snapshot.hasError) {
          return const Scaffold(
            body: Center(child: Text('Error loading logo')),
          );
        } else {
          String logoUrl = snapshot.data?['logo'] ?? 'https://default-logo-url.com/logo.jpg';

          return Scaffold(
            appBar: AppBar(
              leading: IconButton(
                icon: const Icon(Icons.exit_to_app),
                onPressed: () {
                  exitApp();
                },
              ),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                    child: Image.network(
                      logoUrl,
                      fit: BoxFit.contain,
                      height: AppBar().preferredSize.height,
                    ),
                  ),
                ],
              ),
              actions: <Widget>[
                IconButton(
                  icon: snapshot.data?['notify'] ? const Icon(Icons.notifications) : const Icon(Icons.notification_important_outlined),
                  onPressed: () {
                    Navigator.pushNamed(context, '/notify');
                  },
                ),

                IconButton(
                  icon: const Icon(Icons.camera_alt_outlined),
                  onPressed: () {
                    Navigator.pushNamed(context, '/qrScanner');
                  },
                ),
              ],
            ),
            body: const CompleteCheck(),
          );
        }
      },
    );
  }
}
