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
  int currentPage = 0;
  List<dynamic> notifications = [];
  bool isLoading = false;
  bool hasMore = true;
  final pageSize = 5;

  @override
  void initState() {
    super.initState();
    _loadNotifications();
  }

  Future<void> _loadNotifications() async {
    setState(() {
      isLoading = true;
    });

    final notificationsService = sl<Notifications>();
    try {
      final List<dynamic> data = await notificationsService.getNotifications();
      setState(() {
        notifications = data;
        hasMore = notifications.length > pageSize * (currentPage + 1);
      });
    } catch (e) {
      // ignore: avoid_print
      print('Error al obtener notificaciones: $e');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  void _loadNextPage() {
    if (hasMore && !isLoading) {
      setState(() {
        currentPage++;
      });
      _loadNotifications();
    }
  }

  void _loadPreviousPage() {
    if (currentPage > 0 && !isLoading) {
      setState(() {
        currentPage--;
      });
      _loadNotifications();
    }
  }

  @override
  Widget build(BuildContext context) {
    final int startIndex = currentPage * pageSize;
    final int endIndex = (currentPage + 1) * pageSize;
    final List<dynamic> displayedNotifications = notifications.sublist(
      startIndex,
      endIndex > notifications.length ? notifications.length : endIndex,
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Notificaciones'),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                currentPage = 0;
                notifications.clear();
                hasMore = true;
              });
              _loadNotifications();
            },
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: isLoading && notifications.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    // enlista los mensajes desde abajo o arriba de la pantalla
                    reverse: false,
                    itemCount: displayedNotifications.length,
                    itemBuilder: (context, index) {
                      final notificacion = displayedNotifications[index];
                      return ChatBubble(
                        header: (notificacion['user_id'] == '0')
                            ? 'Para todos'
                            : 'Solo para ti',
                        message: notificacion['message'] ?? 'No hay mensaje',
                        date: notificacion['date_time'] ??
                            DateTime.now().toString(),
                      );
                    },
                  ),
                ),
                if (!isLoading)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        onPressed: currentPage > 0 ? _loadPreviousPage : () => {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: (currentPage > 0) ? Colors.white : Colors.white.withOpacity(0.2), // Color de fondo del botón
                        ),
                        child: const Text('Anterior'),
                      ),
                      ElevatedButton(
                        onPressed: hasMore ? _loadNextPage : () => {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor : hasMore ?  Colors.white : Colors.white.withOpacity(0.2),
                        ),
                        child: const Text('Siguiente'),
                      ),
                    ],
                  ),
                if (isLoading)
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: CircularProgressIndicator(),
                  ),
              ],
            ),
    );
  }
}
