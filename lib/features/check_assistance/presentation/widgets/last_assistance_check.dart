import 'package:flutter/material.dart';

import '../../../../core/api_services/api.dart';
import '../../../../injection_container.dart';

class LastAssistanceCheck extends StatelessWidget {
   
  const LastAssistanceCheck({super.key});

  @override
  Widget build(BuildContext context) {
    
    final lastAssistance = sl<AssistanceInfo>();

    return FutureBuilder(
      future: lastAssistance.fetchAssistanceInfo(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Text(snapshot.data ?? "");
      },
    );
  }
}