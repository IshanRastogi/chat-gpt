import 'dart:convert';
import 'package:http/http.dart' as http;

class OpenAIService {
  final String url = 'https://api.openai.com/v1/engines/davinci-codex/completions';
  final String apiKey = 'your-openai-api-key';

  Future<String> getCompletion(String prompt) async {
    var response = await http.post(
      Uri.parse(url),
      headers: {
        'Authorization': 'Bearer $apiKey',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'prompt': prompt,
        'max_tokens': 60,
      }),
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return data['choices'][0]['text']['content'].trim();
    } else {
      throw Exception('Error getting completion: ${response.statusCode}');
    }
  }
}
