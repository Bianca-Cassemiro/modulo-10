import "dart:convert";

import "../model/todo.dart";

import "package:http/http.dart" as http;

var baseurl = baseUrl;

Future<List<ToDo>> getTasks() async {
  final response = await http.get(
    Uri.parse("$baseurl/todo/user:$userId"),
    headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $accessToken',
    },
  );
  if (response.statusCode == 200) {
    final List<dynamic> data = json.decode(response.body);
    return data.map((d) => ToDo.fromJson(d)).toList();
  } else {
    return ToDo.todoList();
  }
}

Future<bool> addTask(String content) async {
  final response = await http.post(Uri.parse("$baseurl/todo/"),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${globals.accessToken}',
      },
      body: jsonEncode(<String, dynamic>{
        "content": content,
        "user_id": globals.userId,
      }));
  if (response.statusCode == 200) {
    return true;
  } else {
    return false;
  }
}

Future<bool> removeTodo(int id) async {
  final response = await http.delete(
    Uri.parse("$baseurl/todo/$id"),
    headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${globals.accessToken}',
    },
  );

  if (response.statusCode == 200) {
    return true;
  } else {
    return false;
  }
}

Future<bool> checkTodo(int id) async {
  final response = await http.put(
    Uri.parse("$baseurl/todo/check/$id"),
    headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${globals.accessToken}',
    },
  );
  if (response.statusCode == 200) {
    return true;
  } else {
    return false;
  }
}