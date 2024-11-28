// surah_api_services.dart
import 'package:dio/dio.dart';
import 'package:r_muslim/models/list_surah_model.dart';

class SurahApiServices {
  final Dio _dio = Dio();

  Future<List<DataListSurah>> fetchAllSurat() async {
  try {
    final response = await _dio.get('https://equran.id/api/v2/surat');

    if (response.statusCode == 200) {
      if (response.data is Map<String, dynamic>) {
        List<dynamic> data = response.data['data'];

        print('res surah => $data');

        List<DataListSurah> listSurah = data.map((json) => DataListSurah.fromJson(json)).toList();
        return listSurah;
      } else {
        throw Exception('Data tidak valid');
      }
    } else {
      print('Response tidak valid: ${response.statusCode}');
      throw Exception('Failed to load surah data, status code: ${response.statusCode}');
    }
  } catch (e) {
    print('Error fetching data: $e');
    throw Exception('Failed to load surah data: $e');
  }
}

}
