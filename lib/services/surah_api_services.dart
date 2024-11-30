import 'package:dio/dio.dart';
import 'package:r_muslim/models/detail_surah_model.dart';
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

          List<DataListSurah> listSurah =
              data.map((json) => DataListSurah.fromJson(json)).toList();
          return listSurah;
        } else {
          throw Exception('Data tidak valid');
        }
      } else {
        print('Response tidak valid: ${response.statusCode}');
        throw Exception(
            'Failed to load surah data, status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching data: $e');
      throw Exception('Failed to load surah data: $e');
    }
  }

  Future<Data> fetchDetailSurah(int id) async {
    try {
      final response = await _dio.get(
        'https://equran.id/api/v2/surat/$id',
      );

      if (response.statusCode == 200) {
        // Memastikan data yang diterima valid
        if (response.data is Map<String, dynamic>) {
          final apiResponse = DetailSurahModel.fromJson(response.data);
          return apiResponse.data;
        } else {
          throw Exception('Format data tidak sesuai');
        }
      } else {
        print('Response tidak valid: ${response.statusCode}');
        throw Exception(
            'failed to load data, status code: ${response.statusCode}');
      }
    } on DioError catch (e) {
      print('Dio error: ${e.message}');
      throw Exception('failed to load data: ${e.message}');
    } catch (e) {
      print('Error fetching data: $e');
      throw Exception('failed to load data: $e');
    }
  }
}
