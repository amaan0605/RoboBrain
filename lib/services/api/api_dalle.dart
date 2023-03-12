import 'dart:convert';
import 'package:http/http.dart' as http;
import 'apiKeys/api_key.dart';

Future<dynamic> generateImage(String text, String size) async {
  final url = Uri.parse('https://api.openai.com/v1/images/generations');
  var response = await http.post(
    url,
    headers: {
      "Content-Type": "application/json",
      "Authorization": "Bearer $secretApiKey"
    },
    body: jsonEncode(
      {
        "prompt": text,
        "n": 1,
        "size": size,
      },
    ),
  );
  try {
    var data = jsonDecode(response.body);
    return data['data'][0]['url'];
  } catch (e) {
    return e.toString();
  }
}
