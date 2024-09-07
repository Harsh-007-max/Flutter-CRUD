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
