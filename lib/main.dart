// lib/main.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart'; // Impor Riverpod
import 'package:flutter_application_1/models/todo.dart'; // Impor model Todo
import 'package:flutter_application_1/providers/todo_provider.dart'; // Impor provider Todo

void main() {
  runApp(
    const ProviderScope( // Widget penting dari Riverpod untuk mengelola state
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aplikasi To-Do',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const TodoListPage(), // Halaman utama aplikasi kita
    );
  }
}

class TodoListPage extends ConsumerWidget { // Gunakan ConsumerWidget untuk mengakses provider Riverpod
  const TodoListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) { // Tambahkan WidgetRef ref
    // Ambil state dari todoListProvider. Ini akan berupa AsyncValue (loading, data, error)
    final todoListAsyncValue = ref.watch(todoListProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar Tugas (Todos)'),
        backgroundColor: Colors.blueAccent,
      ),
      body: todoListAsyncValue.when(
        data: (List<Todo> todos) {
          // Jika data berhasil diambil, tampilkan dalam ListView
          return ListView.builder(
            itemCount: todos.length,
            itemBuilder: (context, index) {
              final todo = todos[index];
              return Card(
                margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                elevation: 4,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Judul: ${todo.title}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.deepPurple,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text('ID: ${todo.id}', style: const TextStyle(fontSize: 14)),
                      Text('User ID: ${todo.userId}', style: const TextStyle(fontSize: 14)),
                      Text(
                        'Selesai: ${todo.completed ? 'Ya' : 'Tidak'}',
                        style: TextStyle(
                          fontSize: 14,
                          color: todo.completed ? Colors.green : Colors.red,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
        loading: () => const Center(
          // Tampilkan indikator loading saat data sedang diambil
          child: CircularProgressIndicator(),
        ),
        error: (error, stack) => Center(
          // Tampilkan pesan error jika terjadi kesalahan
          child: Text('Error: $error', style: const TextStyle(color: Colors.red, fontSize: 16)),
        ),
      ),
    );
  }
}