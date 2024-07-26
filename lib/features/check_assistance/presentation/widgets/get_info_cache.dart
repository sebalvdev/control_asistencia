import 'package:flutter/material.dart';
import '../../../../core/api_services/api.dart';
import '../../../../injection_container.dart';

Widget getName() {
  final user = sl<UserInfo>();
  return FutureBuilder(
    future: user.getName(),
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return const Center(child: CircularProgressIndicator());
      } else if (snapshot.hasError) {
        return const Center(child: Text('Error loading name'));
      } else {
        String data = snapshot.data ?? "";

        return Text(data,
            style: const TextStyle(fontWeight: FontWeight.bold)
          );
      }
    },
  );
}

Widget getImage() {
  final user = sl<UserInfo>();
  return FutureBuilder(
    future: user.getImage(),
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return const Center(child: CircularProgressIndicator());
      } else if (snapshot.hasError) {
        return const Center(child: Text('Error loading name'));
      } else {
        final url = snapshot.data;
        Image data = Image.asset('assets/images/icono.png',fit: BoxFit.fitHeight,);
        if(url != null) {
          data = Image.network(url, height: 240,fit: BoxFit.fitHeight);
        }

        return data;
      }
    },
  );
}
