import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {

  static Future<List<dynamic>> getTickets() async {
    final res = await http.get(
      Uri.parse('http://localhost:3000/tickets'),
    );

    return json.decode(res.body);
  }

  static Future<bool> beliTiket(int id, String name) async {
    final res = await http.post(
      Uri.parse('http://localhost:3000/transactions'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'ticketId': id,
        'name': name,
      }),
    );

    return res.statusCode == 200 || res.statusCode == 201;
  }
}