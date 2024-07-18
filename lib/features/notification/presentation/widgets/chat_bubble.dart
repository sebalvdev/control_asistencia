import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ChatBubble extends StatelessWidget {
  final String header;
  final String message;
  final String date;

  const ChatBubble(
      {super.key,
      required this.header,
      required this.message,
      required this.date});

  String formatDate(String date) {
    DateTime dateTime = DateTime.parse(date);
    return DateFormat('d \'de\' MMMM \',\' y', 'es_ES').format(dateTime);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 3.0),
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Colors.lightBlueAccent.withOpacity(0.2),
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                header,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14.0,
                ),
              ),
              // const SizedBox(height: 8.0),
              Text(
                formatDate(date),
                style: const TextStyle(
                  fontSize: 12.0,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8.0),
          Text(
            message,
            style: const TextStyle(
              fontSize: 12.0,
            ),
          ),
        ],
      ),
    );
  }
}
