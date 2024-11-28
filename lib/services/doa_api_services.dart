import 'package:dio/dio.dart';
import 'package:r_muslim/models/doa_model.dart';  

class DoaApiServices {
  final Dio _dio = Dio();

  Future<List<DoaModel>> fetchAllDoa() async {
    try {
      final response = await _dio.get('https://equran.id/api/doa');

      if (response.statusCode == 200) {
        if (response.data is List) {
          List<dynamic> data = response.data;  

          print('res doa => $data');

          List<DoaModel> listDoa = data.map((json) => DoaModel.fromJson(json)).toList();
          return listDoa;
        } else {
          throw Exception('Data tidak valid');
        }
      } else {
        print('Response tidak valid: ${response.statusCode}');
        throw Exception('Failed to load, status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching data: $e');
      throw Exception('Failed to load: $e');
    }
  }
}
