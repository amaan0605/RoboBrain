import "dart:convert";
import "package:ai_magic/services/api/apiKeys/api_key.dart";
import "package:http/http.dart" as http;

Future<dynamic> generateChatResponse(String promt) async {
  final url = Uri.parse('https://api.openai.com/v1/chat/completions');
  var response = await http.post(url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $secretApiKey'
      },
      body: jsonEncode({
        "model": "gpt-3.5-turbo",
        "messages": [
          {
            "role": "user",
            "content": promt,
          }
        ]
      }));
  try {
    var data = jsonDecode(response.body);
    return data['choices'][0]['message']['content'];
  } catch (e) {
    return 'Some Errors occured, Try again Later!!!';
  }
}
