import 'package:flutter/material.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> historyRecords = [
      {'from': 'A', 'to': 'B'},
      {'from': 'C', 'to': 'D'},
      {'from': 'E', 'to': 'F'},
      {'from': 'G', 'to': 'H'},
      {'from': 'I', 'to': 'J'},
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('History'),
      ),
      body: ListView.builder(
        itemCount: historyRecords.length,
        itemBuilder: (context, index) {
          final record = historyRecords[index];
          return ListTile(
            title: Text('From ${record['from']} to ${record['to']}'),
            subtitle: Text('Record ${index + 1}'),
          );
        },
      ),
    );
  }
}
