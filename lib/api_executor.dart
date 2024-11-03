import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiExecutor {
  static get api => dotenv.env['API_URL'] ?? 'http://localhost:8000';
  static const PERSONID = "PersonID";
  static const NAME = "Name";
  static const DESCRIPTION = "Description";
  static const GENDER = "gender";

//--------get All--------
  Future<dynamic> getAll() async {
    http.Response response = await http.get(Uri.parse(api));
    return response.statusCode == 200
        ? jsonDecode(response.body)
        : throw Exception("api_executor.dart/GetAll method error!!");
  }

//--------get by PersonID--------
  Future<dynamic> getByPersonID(int personID) async {
    http.Response response = await http.get(Uri.parse(api + "/" + personID));
    return response.statusCode == 200
        ? jsonDecode(response.body)
        : throw Exception("api_executor.dart/GetByPersonID method error!!");
  }

//--------add new Person--------
  Future<dynamic> addNewPerson(personData) async {
    http.Response response =
        await http.post(Uri.parse("$api"), body: personData);
    return response.statusCode == 200
        ? jsonDecode(response.body)
        : throw Exception("api_executor.dart/addNewPerson method error!!");
  }

//--------update by PersonID--------
  Future<dynamic> updateByPersonID(id, personData) async {
    http.Response response =
        await http.put(Uri.parse("$api/$id"), body: personData);
    return response.statusCode == 200
        ? jsonDecode(response.body)
        : throw Exception("api_executor.dart/updateByPersonID method error!!");
  }

//--------delete by PersonID--------
  Future<dynamic> deleteByPersonID(id) async {
    http.Response response = await http.delete(Uri.parse("$api/$id"));
    return response.statusCode == 200
        ? jsonDecode(response.body)
        : throw Exception("api_executor.dart/deleteByPersonID method error!!");
  }
}
