import '../../../../injection_container.dart';
import '../../../../router/app_routes.dart';
import '../../../../core/api_services/api.dart';
import '../widgets/exit_app.dart';
import '../widgets/widgets.dart';
import 'package:flutter/material.dart';

class NoCheckAssistanceScreen extends StatefulWidget {
  const NoCheckAssistanceScreen({super.key});

  @override
  State<NoCheckAssistanceScreen> createState() => _NoCheckAssistanceScreenState();
}

class _NoCheckAssistanceScreenState extends State<NoCheckAssistanceScreen> {
  
  bool newMessages = false;

  @override
  void initState() {
    super.initState();

    // final notificationsService = sl<Notifications>();
    // newMessages = notificationsService.test();
  //   List lastMessageslist = notificationsService.getNotifications();
  //   notificationsService.fetchNotifications;
  //   List newMessageslist = notificationsService.getNotifications();

  //   newMessages = (lastMessageslist == newMessageslist) ? false : true;
  }

  @override
  Widget build(BuildContext context) {
    final logo = sl<Logo>();

    return FutureBuilder<String>(
      future: logo.getLogo(),
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
          String logoUrl = snapshot.data ?? 'https://default-logo-url.com/logo.jpg';

          return Scaffold(
            appBar: AppBar(
              leading: IconButton(
                icon: const Icon(Icons.exit_to_app),
                onPressed: () {
                  // Navigator.popAndPushNamed(context, '/registerNumber');
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
                  // icon: !newMessages ? const Icon(Icons.notifications) : const Icon(Icons.notification_important_outlined),
                  icon: const Icon(Icons.notifications),
                  // icon: const Icon(Icons.notification_important_outlined),
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
            body: const Nocheck(),
          );
        }
      },
    );
  }
}
