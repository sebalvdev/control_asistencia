import 'package:flutter/material.dart';
import '../../data/datasource/test.dart';
import '../widgets/chat_bubble.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  Future<List<dynamic>> _loadNotifications() async {
    final ApiService apiService = ApiService();
    try {
      final List<dynamic> data = await apiService.obtenerNotificaciones('892071544');
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
            final notifications = snapshot.data!;
            return ListView.builder(
              itemCount: notifications.length,
              itemBuilder: (context, index) {
                final notificacion = notifications[index];
                return ChatBubble(
                  header: (notificacion['user_id'] == '0') ? 'Para todos' : 'Para ti',
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
