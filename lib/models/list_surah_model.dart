class ListSurahModel {
  int code;
  String message;
  List<DataListSurah> data;

  ListSurahModel({
    required this.code,
    required this.message,
    required this.data,
  });

  factory ListSurahModel.fromJson(Map<String, dynamic> json) => ListSurahModel(
    code: json["code"],
    message: json["message"],
    data: json["data"] == null
        ? []
        : List<DataListSurah>.from(
            json["data"]!.map((x) => DataListSurah.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "message": message,
    "data": data.isEmpty
        ? []
        : List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class DataListSurah {
  int nomor;
  String nama;
  String namaLatin;
  String jumlahAyat; 
  String tempatTurun;
  String arti;
  String deskripsi;
  AudioFull audioFull;

  DataListSurah({
    required this.nomor,
    required this.nama,
    required this.namaLatin,
    required this.jumlahAyat,   
    required this.tempatTurun,
    required this.arti,
    required this.deskripsi,
    required this.audioFull,
  });

  factory DataListSurah.fromJson(Map<String, dynamic> json) => DataListSurah(
        nomor: json["nomor"],
        nama: json["nama"],
        namaLatin: json["namaLatin"],
        jumlahAyat: json["jumlahAyat"].toString(),   
        tempatTurun: json["tempatTurun"],
        arti: json["arti"],
        deskripsi: json["deskripsi"],
        audioFull: json['audioFull'] != null
            ? AudioFull.fromJson(json['audioFull'])
            : AudioFull(
                satu: '',
                dua: '',
                tiga: '',
                empat: '',
                lima: '',
              ),
      );

  Map<String, dynamic> toJson() => {
        'nomor': nomor,
        'nama': nama,
        'namaLatin': namaLatin,
        'jumlahAyat': jumlahAyat,   
        'tempatTurun': tempatTurun,
        'arti': arti,
        'deskripsi': deskripsi,
        'audioFull': audioFull.toJson(),
      };
}

class AudioFull {
  String satu;
  String dua;
  String tiga;
  String empat;
  String lima;

  AudioFull({
    required this.satu,
    required this.dua,
    required this.tiga,
    required this.empat,
    required this.lima,
  });

  factory AudioFull.fromJson(Map<String, dynamic> json) => AudioFull(
        satu: json["01"],
        dua: json["02"],
        tiga: json["03"],
        empat: json["04"],
        lima: json["05"],
      );

  Map<String, dynamic> toJson() => {
        "01": satu,
        "02": dua,
        "03": tiga,
        "04": empat,
        "05": lima,
      };
}
