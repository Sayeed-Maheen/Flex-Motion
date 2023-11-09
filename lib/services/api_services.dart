import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = 'https://exercisedb.p.rapidapi.com';

  Future<List<Map<String, dynamic>>> fetchExercisesByPage(int page) async {
    final response =
        await http.get(Uri.parse('$baseUrl/exercises?page=$page'), headers: {
      'X-RapidAPI-Key': '80220bfb6amshb35a1079de116b6p1d5440jsn5e32ae11893b',
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
