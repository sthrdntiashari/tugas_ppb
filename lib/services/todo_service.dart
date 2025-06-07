// lib/services/todo_service.dart
import 'dart:convert'; // Untuk mengelola JSON
import 'package:http/http.dart' as http; // Untuk melakukan HTTP requests
import 'package:flutter_application_1/models/todo.dart'; // Impor model Todo yang sudah kita buat

class TodoService {
  final String apiUrl = "https://jsonplaceholder.typicode.com/todos/";

  Future<List<Todo>> fetchTodos() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      // Jika server mengembalikan respons OK (status code 200),
      // parse JSON.
      List<dynamic> body = json.decode(response.body);
      // Konversi setiap item di body menjadi objek Todo
      return body.map((dynamic item) => Todo.fromJson(item)).toList();
    } else {
      // Jika respons tidak OK, lempar exception.
      throw Exception('Failed to load todos');
    }
  }
}