import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = 'https://exercisedb.p.rapidapi.com';

  Future<List<Map<String, dynamic>>> fetchExercisesByPage(int page) async {
    final response =
        await http.get(Uri.parse('$baseUrl/exercises?page=$page'), headers: {
      'X-RapidAPI-Key': 'c6db7f5f9dmsh3254f86410205b1p1490c9jsn64567251f578',
      'X-RapidAPI-Host': 'exercisedb.p.rapidapi.com'
    });

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.cast<Map<String, dynamic>>();
    } else {
      throw Exception('Failed to load data');
    }
  }
}
