// lib/providers/todo_provider.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_application_1/models/todo.dart';
import 'package:flutter_application_1/services/todo_service.dart';

// Provider untuk instance TodoService
final todoServiceProvider = Provider((ref) => TodoService());

// FutureProvider untuk mengambil daftar Todo
// Ini akan secara otomatis menangani loading dan error state
final todoListProvider = FutureProvider<List<Todo>>((ref) async {
  return ref.read(todoServiceProvider).fetchTodos();
});