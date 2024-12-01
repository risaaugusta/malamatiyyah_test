class DetailSurahModel {
  int code;
  String message;
  Data data;

  DetailSurahModel({
    required this.code,
    required this.message,
    required this.data,
  });

  factory DetailSurahModel.fromJson(Map<String, dynamic> json) {
    return DetailSurahModel(
      code: json['code'],
      message: json['message'],
      data: Data.fromJson(json['data']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'code': code,
      'message': message,
      'data': data.toJson(),
    };
  }
}

class Data {
  int nomor;
  String nama;
  String namaLatin;
  int jumlahAyat;
  String tempatTurun;
  String arti;
  String deskripsi;
  Map<String, String> audioFull;
  List<Ayat> ayat;
  dynamic suratSelanjutnya;
  dynamic suratSebelumnya;

  Data({
    required this.nomor,
    required this.nama,
    required this.namaLatin,
    required this.jumlahAyat,
    required this.tempatTurun,
    required this.arti,
    required this.deskripsi,
    required this.audioFull,
    required this.ayat,
    required this.suratSelanjutnya,
    required this.suratSebelumnya,
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      nomor: json['nomor'],
      nama: json['nama'],
      namaLatin: json['namaLatin'],
      jumlahAyat: json['jumlahAyat'],
      tempatTurun: json['tempatTurun'],
      arti: json['arti'],
      deskripsi: json['deskripsi'],
      audioFull: Map<String, String>.from(json['audioFull']),
      ayat: (json['ayat'] as List)
          .map((ayatJson) => Ayat.fromJson(ayatJson))
          .toList(),
      suratSelanjutnya: json['suratSelanjutnya'] == false
          ? false
          : json['suratSelanjutnya'] != null
              ? SuratSelanjutnya.fromJson(json['suratSelanjutnya'])
              : null,
      suratSebelumnya: json['suratSebelumnya'] == false
          ? false
          : json['suratSebelumnya'] != null
              ? SuratSelanjutnya.fromJson(json['suratSebelumnya'])
              : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'nomor': nomor,
      'nama': nama,
      'namaLatin': namaLatin,
      'jumlahAyat': jumlahAyat,
      'tempatTurun': tempatTurun,
      'arti': arti,
      'deskripsi': deskripsi,
      'audioFull': audioFull,
      'ayat': ayat.map((ayat) => ayat.toJson()).toList(),
      'suratSelanjutnya':
          suratSelanjutnya == false ? false : suratSelanjutnya?.toJson(),
      'suratSebelumnya':
          suratSebelumnya == false ? false : suratSebelumnya?.toJson(),
    };
  }
}

class Ayat {
  int nomorAyat;
  String teksArab;
  String teksLatin;
  String teksIndonesia;
  Map<String, String> audio;

  Ayat({
    required this.nomorAyat,
    required this.teksArab,
    required this.teksLatin,
    required this.teksIndonesia,
    required this.audio,
  });

  factory Ayat.fromJson(Map<String, dynamic> json) {
    return Ayat(
      nomorAyat: json['nomorAyat'],
      teksArab: json['teksArab'],
      teksLatin: json['teksLatin'],
      teksIndonesia: json['teksIndonesia'],
      audio: Map<String, String>.from(json['audio']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'nomorAyat': nomorAyat,
      'teksArab': teksArab,
      'teksLatin': teksLatin,
      'teksIndonesia': teksIndonesia,
      'audio': audio,
    };
  }
}

class SuratSelanjutnya {
  int nomor;
  String nama;
  String namaLatin;
  int jumlahAyat;

  SuratSelanjutnya({
    required this.nomor,
    required this.nama,
    required this.namaLatin,
    required this.jumlahAyat,
  });

  factory SuratSelanjutnya.fromJson(Map<String, dynamic> json) {
    return SuratSelanjutnya(
      nomor: json['nomor'],
      nama: json['nama'],
      namaLatin: json['namaLatin'],
      jumlahAyat: json['jumlahAyat'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'nomor': nomor,
      'nama': nama,
      'namaLatin': namaLatin,
      'jumlahAyat': jumlahAyat,
    };
  }
}
