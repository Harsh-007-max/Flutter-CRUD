import 'package:flutter/material.dart';
import 'package:flutter_crud/api_executor.dart';

class ListPage extends StatelessWidget {
  const ListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("API CRUD")),
      body: FutureBuilder(
        future: ApiExecutor().getAll(),
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data != null) {
            return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  return customListTile(snapshot.data[index]);
                });
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}

Widget customListTile(dynamic data) {
  return ListTile(
    title: Text(data[ApiExecutor.NAME]),
  );
}
