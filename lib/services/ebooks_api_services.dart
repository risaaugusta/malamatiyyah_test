// surah_api_services.dart
import 'package:dio/dio.dart';
import 'package:r_muslim/models/ebooks_model.dart';

class EbooksApiServices {
  final Dio _dio = Dio();

  Future<List<DataEbooks>> fetchAllEbooks() async {
  try {
    final response = await _dio.get('https://api3.islamhouse.com/v3/paV29H2gm56kvLPy/main/books/id/id/1/25/json');

    if (response.statusCode == 200) {
      if (response.data is Map<String, dynamic>) {
        List<dynamic> data = response.data['data'];

        print('res ebooks => $data');

        List<DataEbooks> listSurah = data.map((json) => DataEbooks.fromJson(json)).toList();
        return listSurah;
      } else {
        throw Exception('Data tidak valid');
      }
    } else {
      print('Response tidak valid: ${response.statusCode}');
      throw Exception('Failed to load data, status code: ${response.statusCode}');
    }
  } catch (e) {
    print('Error fetching data: $e');
    throw Exception('Failed to load data: $e');
  }
}

}
