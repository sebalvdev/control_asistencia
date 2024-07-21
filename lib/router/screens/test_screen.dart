// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class TestScreen extends StatelessWidget {
   
  const TestScreen({super.key});

Future<void> getData(String codeVerification) async {
  String key = "https://jcvctechnology.com/";
  String filename = "test.php";
  final url = Uri.parse(key + filename);

  final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'code_verification': codeVerification,
      }),
    );

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      if (responseData) {
        print('Authenticated');
      } else {
        print('Invalid credentials or verification code');
      }
    } else {
      throw Exception('Failed to authenticate');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            getData('123');
          },
          child: const Text('Login'),
        ),
      ),
    );
  }
}



