import 'package:flutter/material.dart';
import 'package:flutter_crud/addEditUser.dart';
import 'package:flutter_crud/api_executor.dart';

class ListPage extends StatefulWidget {
  const ListPage({super.key});

  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
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
                    onTap: () {
                      Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      AddEditPage(edit: snapshot.data[index])))
                          .then((res) => setState(() {}));
                      // Navigator.push(context,MaterialPageRoute(builder:(context)=>AddEditPage(student:data)));
                    },
                    title: Text(snapshot.data[index][ApiExecutor.NAME]),
                    trailing: IconButton(
                      icon: const Icon(
                        Icons.delete,
                        color: Colors.red,
                      ),
                      onPressed: () {
                        ApiExecutor()
                            .deleteByPersonID(
                                snapshot.data[index][ApiExecutor.PERSONID])
                            .then((val) => setState(() {}));
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

// Widget customListTile(dynamic data, context) {
//   return ;
// }
