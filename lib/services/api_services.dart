import 'dart:convert';
import 'package:http/http.dart' as http;

// class ApiHeaders {
//   static Map<String, String> getHeaders() {
//     return {
//       'X-RapidAPI-Key': '8ec235d2f6mshbffe97c67b86260p1a6cb8jsna608fd681823',
//       'X-RapidAPI-Host': 'exercisedb.p.rapidapi.com',
//     };
//   }
// }

class ApiService {
  static const String baseUrl = 'https://exercisedb.p.rapidapi.com';
  //static const String apiKey = '8ec235d2f6mshbffe97c67b86260p1a6cb8jsna608fd681823';

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
