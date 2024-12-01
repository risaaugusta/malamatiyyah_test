import 'package:dio/dio.dart';
import 'package:r_muslim/models/videos_model.dart';

class VideosApiServices {
  final Dio _dio = Dio();

  Future<List<DataVideos>> fetchAllVideos() async {
  try {
    final response = await _dio.get('https://api3.islamhouse.com/v3/paV29H2gm56kvLPy/main/videos/id/id/1/25/json');

    if (response.statusCode == 200) {
      if (response.data is Map<String, dynamic>) {
        List<dynamic> data = response.data['data'];

        print('res videos => $data');

        List<DataVideos> listVideos = data.map((json) => DataVideos.fromJson(json)).toList();
        return listVideos;
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
