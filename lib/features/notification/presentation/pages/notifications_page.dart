import 'package:flutter/material.dart';
import '../../../../core/api_services/api.dart';
import '../../../../injection_container.dart';
import '../widgets/chat_bubble.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  Future<List<dynamic>> _loadNotifications() async {
    final Notifications notifications = sl();
    try {
      final List<dynamic> data = await notifications.obtenerNotificaciones('892071544');
      return data;
    } catch (e) {
      // ignore: avoid_print
      print('Error al obtener notificaciones: $e');
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notificaciones'),
        actions: [
          IconButton(onPressed: () => setState(() {}), icon: const Icon(Icons.refresh))
        ],
      ),
      body: FutureBuilder<List<dynamic>>(
        future: _loadNotifications(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No hay notificaciones'));
          } else {
            final notify = snapshot.data!;
            return ListView.builder(
              reverse: true,
              itemCount: notify.length,
              itemBuilder: (context, index) {
                final notificacion = notify[index];
                return ChatBubble(
                  header: (notificacion['user_id'] == '0') ? 'Para todos' : 'Solo para ti',
                  message: notificacion['message'] ?? 'No hay mensaje',
                  date: notificacion['date_time'] ?? DateTime.now().toString(),
                );
              },
            );
          }
        },
      ),
    );
  }
}
