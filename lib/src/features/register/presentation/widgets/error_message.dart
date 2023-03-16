import 'package:app/src/features/register/data/models/register_response.dart';
import 'package:flutter/material.dart';

class ErrorMessage extends StatelessWidget {
  final List<ErrorItem> message;
  const ErrorMessage({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      color: Colors.red,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: message.map((item) {
            return Column(
              children: item.messages.map((message) {
                return Text(
                  message,
                  style: const TextStyle(color: Colors.white),
                );
              }).toList(),
            );
          }).toList(),
        ),
      ),
    );
  }
}
