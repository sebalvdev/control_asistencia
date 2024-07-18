import 'package:flutter/material.dart';

import '../widgets/chat_bubble.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Notificaciones'),
          actions: [
            IconButton(
              icon: const Icon(Icons.refresh_outlined),
              onPressed: () {
                setState(() {});
              },
            ),
          ],
        ),
        body: Center(
          child: ListView(
              padding: const EdgeInsets.all(8.0),
              children: const <Widget>[
                ChatBubble(
                  header: 'Usuario 1',
                  message: 'Hola, ¿cómo estás?',
                  date: '2024-07-17',
                ),
                ChatBubble(
                    header: 'Todos',
                    message: 'este es un test',
                    date: '2024-07-17'),
                ChatBubble(
                    header: 'Todos',
                    message: 'este es un test',
                    date: '2024-07-17'),
              ]),
        ));
  }
}
