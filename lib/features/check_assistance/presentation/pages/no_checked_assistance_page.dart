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

class _NoCheckAssistanceScreenState extends State<NoCheckAssistanceScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Color?> _colorAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    )..repeat(reverse: true);

    _colorAnimation = ColorTween(
      begin: Colors.red,
      end: Colors.transparent,
    ).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
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
          bool notify = snapshot.data?['notify'] ?? false;

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
                  icon: AnimatedBuilder(
                    animation: _colorAnimation,
                    builder: (context, child) {
                      return Icon(
                        notify ? Icons.notifications : Icons.notification_important_outlined,
                        color: notify ? null : _colorAnimation.value,
                      );
                    },
                  ),
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
