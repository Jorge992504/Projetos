import 'package:flusql/app/models/db_lite.dart';
import 'package:flusql/app/services/api_service.dart';
import 'package:flusql/app/services/db_service.dart';
import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: OfflineForm(),
    );
  }
}

class OfflineForm extends StatefulWidget {
  const OfflineForm({super.key});

  @override
  State<OfflineForm> createState() => _OfflineFormState();
}

class _OfflineFormState extends State<OfflineForm> {
  final TextEditingController _controller = TextEditingController();
  final ApiService _api = ApiService();
  final DbService _db = DbService();

  @override
  void initState() {
    super.initState();
    _checkAndSync();
  }

  Future<void> _checkAndSync() async {
    final connectivity = await Connectivity().checkConnectivity();
    // ignore: unrelated_type_equality_checks
    if (connectivity != ConnectivityResult.none) {
      final dataList = await _db.getALLData();
      for (var data in dataList) {
        final success = await _api.sendData(data);
        if (success) {
          await _db.deleteData(data.id!);
        }
      }
    }
  }

  Future<void> _handleSubmit() async {
    final text = _controller.text.trim();
    if (text.isEmpty) return;

    final data = DbLite(text: text);
    final connectivity = await Connectivity().checkConnectivity();

    // ignore: unrelated_type_equality_checks
    if (connectivity != ConnectivityResult.none) {
      final success = await _api.sendData(data);
      if (!success) {
        await _db.insertData(data);
      }
    } else {
      await _db.insertData(data);
    }

    _controller.clear();
    _checkAndSync(); // tenta novamente depois
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Form Offline Sync")),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(children: [
          TextFormField(
            controller: _controller,
            decoration: const InputDecoration(labelText: 'Digite algo'),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: _handleSubmit,
            child: const Text("Salvar"),
          ),
        ]),
      ),
    );
  }
}
