import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_crud/addEditUser.dart';
import 'package:flutter_crud/api_executor.dart';

class ListPage extends StatefulWidget {
  const ListPage({super.key});

  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  void confirmationDialog(data) async {
    final confirmDelete = await showCupertinoDialog(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          content: Text(
              "Are you sure you want to delete ${data[ApiExecutor.NAME]}?"),
          actions: [
            CupertinoDialogAction(
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              isDestructiveAction: true,
              child: const Text(
                "Delete",
                style: TextStyle(color: Colors.red),
              ),
            ),
            CupertinoDialogAction(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: const Text("Cancel"),
            ),
          ],
        );
      },
    );
    if (mounted && confirmDelete) {
      ApiExecutor()
          .deleteByPersonID(data[ApiExecutor.PERSONID])
          .then((value) => setState(() {}));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("API CRUD"),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: FutureBuilder(
        future: ApiExecutor().getAll(),
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data != null) {
            return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  // return customListTile(snapshot.data[index], context);
                  return ListTile(
                    leading: Text(
                        snapshot.data[index][ApiExecutor.PERSONID].toString()),
                    onTap: () {
                      Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      AddEditPage(edit: snapshot.data[index])))
                          .then((res) => setState(() {}));
                    },
                    title: Text(snapshot.data[index][ApiExecutor.NAME]),
                    trailing: IconButton(
                      icon: const Icon(
                        Icons.delete,
                        color: Colors.red,
                      ),
                      onPressed: () {
                        confirmationDialog(snapshot.data[index]);
                      },
                    ),
                  );
                });
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () => {
                Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const AddEditPage()))
                    .then((val) => setState(() {}))
              },
          child: const Icon(Icons.add)),
    );
  }
}

