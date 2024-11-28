class DoaModel {
  int id;
  String grup;
  String nama;
  String ar;
  String tr;
  String idn;
  String tentang;
  String mood;
  String tag;

  DoaModel({
    required this.id,
    required this.grup,
    required this.nama,
    required this.ar,
    required this.tr,
    required this.idn,
    required this.tentang,
    required this.mood,
    required this.tag,
  });

  factory DoaModel.fromJson(Map<String, dynamic> json) {
    return DoaModel(
      id: json['id'],
      grup: json['grup'],
      nama: json['nama'],
      ar: json['ar'],
      tr: json['tr'],
      idn: json['idn'],
      tentang: json['tentang'],
      mood: json['mood'],
      tag: json['tag'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'grup': grup,
      'nama': nama,
      'ar': ar,
      'tr': tr,
      'idn': idn,
      'tentang': tentang,
      'mood': mood,
      'tag': tag,
    };
  }
}
