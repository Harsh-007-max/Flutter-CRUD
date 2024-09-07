In this Repository we are going to perform following Operations in a flutter MongoDB database.
- Create
- Read
- Update
- Delete

# Get All Data
## Step-1
- Create a new Flutter project using below command
```
flutter create flutter_crud
```

- Install `http` package by using the below command 
- `http` package is used to make `API` calls in flutter 
```
flutter pub add http
```

## Step-3
- Create the list file which will be used to list all the the records returned by the `API`
	- `list_page.dart`
- Create a file that is used to make `API` calls 
	- `api_executor.dart`
- Create a file that is used as a model for the `API` data
	- `api_crud_model.dart` (used in future)

## Step-4
- Write following code in `api_executor.dart`
```dart
import 'dart:convert';

import 'package:http/http.dart' as http;
class ApiExecutor{
  static const api="https://65ded7efff5e305f32a09deb.mockapi.io/api/users";  
  static const NAME = "name";
  static const ID= "id";

  Future<dynamic> getAll()async{
    http.Response response = await http.get(Uri.parse(api));
    return jsonDecode(response.body);
  } 
}
```
The above code snippet contains a class `ApiExecutor` which will be the class used for `API` calls from flutter app 
- We have some static variables i.e., `api, NAME, ID` 
	- `api` contains the `API URL`.
	- `NAME` contains the column in `API` which is represented as `name`.
	- `ID` is the unique id provided for each tuple.
- Alongside that we have a `async` method which is `getAll()` which returns a `Future` of type `dynamic` which will eventually return a dart `Map` object which contains our data.
- `http.Response response = await http.get(Uri.parse(api));`
	- this line will do 2 things 
	1. Create a `http Response Object`
	2. Call the `API` and `GET` all the data into the `http Response Object`
- `return jsonDecode(response.body)`
	- our `API` returns `JSON` data so we have to parse it appropriately 
	- `JSON` data is stored in the body of `http Response object`

## Step-5
- Write the following code in `list_page.dart`
```dart
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
```
- In above code we are retrieving data from the `API` and presenting it as a List in the flutter widget tree which is explained below
- `FutureBuilder` is used because the `API` data will be fetched asynchronously in future object
	- here the `future:` parameter is set to `ApiExecutor().getAll()` which will return all the data in a `Future<dynamic>` object
	- In `builder:` parameter we pass a function with two parameters `(context,snapshot)` which contains a snapshot (image) of the data and in next line we are checking if the snapshot has data and its data is not null 
		- If snapshots data is null or we are still waiting for `API` response then it will return the `CircularProgressIndicator()` widget.
	- as soon as the data arrives in snapshot the `ListView.builder()` method will be called which has two parameters `itemCount` and `itemBuilder`.
		- `itemCount` specifies the length of data in the snapshot i.e., `snapshot.data.length`
		- `itemBuilder` takes a function with arguments `(context,index)` which are used to iterate through the list
	- The custom function `customListTile()` is not important right now but in future operations it will make the code easier to understand.