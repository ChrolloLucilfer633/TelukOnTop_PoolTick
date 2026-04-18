import 'dart:convert';
import 'package:http/http.dart' as http;

Future<List<dynamic>> getTickets() async {
  final response = await http.get(
    Uri.parse('http://10.0.2.2:3000/tickets'),
  );

  if (response.statusCode == 200) {
    return jsonDecode(response.body);
  } else {
    throw Exception('Gagal load tiket');
  }
}