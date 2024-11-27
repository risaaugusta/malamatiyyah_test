import 'package:dio/dio.dart';
import 'dart:convert';

import 'package:r_muslim/models/list_surah_model.dart';

Future<dynamic> fetchAllSurat() async {
  final dio = Dio();
  
  try { 
    String url = 'https://equran.id/api/v2/surat?'; 

    final response = await dio.get(url);

    print('res surah => ${response.data}');
    
    if (response.data != null && response.data['data'] != null) {
      final responseDataList = response.data['data'] as List<dynamic>;

      final List<DataListSurah> listSurat = responseDataList.map((x) => DataListSurah.fromJson(x)).toList();
      print('list surah => $listSurat');
      
      return listSurat;
    } else {
      print('TIDAK ADA DATA SURAT');
      return [];
    }
  } catch (e, stacktrace) {
    print('ERROR -> $e');
    print('Stacktrace -> $stacktrace');
    throw e;  
  }
}