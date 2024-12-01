class VideosModel {
  List<DataVideos> data;
  Links links;

  VideosModel({
    required this.data,
    required this.links,
  });

  factory VideosModel.fromJson(Map<String, dynamic> json) {
    return VideosModel(
      data: List<DataVideos>.from(
          json['data'].map((x) => DataVideos.fromJson(x))),
      links: Links.fromJson(json['links']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'data': List<dynamic>.from(data.map((x) => x.toJson())),
      'links': links.toJson(),
    };
  }
}

class DataVideos {
  int id;
  int sourceId;
  String title;
  Type type;
  int addDate;
  int updateDate;
  String description;
  dynamic fullDescription;
  String sourceLanguage;
  String translatedLanguage;
  String image;
  int numAttachments;
  String importanceLevel;
  String apiUrl;
  List<PreparedBy> preparedBy;
  List<Attachment> attachments;
  List<dynamic> locales;

  DataVideos({
    required this.id,
    required this.sourceId,
    required this.title,
    required this.type,
    required this.addDate,
    required this.updateDate,
    required this.description,
    required this.fullDescription,
    required this.sourceLanguage,
    required this.translatedLanguage,
    required this.image,
    required this.numAttachments,
    required this.importanceLevel,
    required this.apiUrl,
    required this.preparedBy,
    required this.attachments,
    required this.locales,
  });

  factory DataVideos.fromJson(Map<String, dynamic> json) {
    return DataVideos(
      id: json['id'],
      sourceId: json['source_id'],
      title: json['title'],
      type: json['type'],
      addDate: json['add_date'],
      updateDate: json['update_date'],
      description: json['description'],
      fullDescription: json['full_description'],
      sourceLanguage: json['source_language'],
      translatedLanguage: json['translated_language'],
      image: json['image'],
      numAttachments: json['num_attachments'],
      importanceLevel: json['importance_level'],
      apiUrl: json['api_url'],
      preparedBy: List<PreparedBy>.from(
        json['prepared_by'].map((x) => PreparedBy.fromJson(x)),
      ),
      attachments: List<Attachment>.from(
        json['attachments'].map((x) => Attachment.fromJson(x)),
      ),
      locales: List<dynamic>.from(json['locales'].map((x) => x)),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'source_id': sourceId,
      'title': title,
      'type': type,
      'add_date': addDate,
      'update_date': updateDate,
      'description': description,
      'full_description': fullDescription,
      'source_language': sourceLanguage,
      'translated_language': translatedLanguage,
      'image': image,
      'num_attachments': numAttachments,
      'importance_level': importanceLevel,
      'api_url': apiUrl,
      'prepared_by': List<dynamic>.from(preparedBy.map((x) => x.toJson())),
      'attachments': List<dynamic>.from(attachments.map((x) => x.toJson())),
      'locales': List<dynamic>.from(locales.map((x) => x)),
    };
  }
}

class Attachment {
  int order;
  String size;
  String extensionType;
  String description;
  String url;

  Attachment({
    required this.order,
    required this.size,
    required this.extensionType,
    required this.description,
    required this.url,
  });

  factory Attachment.fromJson(Map<String, dynamic> json) {
    return Attachment(
      order: json['order'],
      size: json['size'],
      extensionType: json['extension_type'],
      description: json['description'],
      url: json['url'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'order': order,
      'size': size,
      'extension_type': extensionType,
      'description': description,
      'url': url,
    };
  }
}

class PreparedBy {
  int id;
  int sourceId;
  String title;
  String type;
  String kind;
  dynamic description;
  String apiUrl;

  PreparedBy({
    required this.id,
    required this.sourceId,
    required this.title,
    required this.type,
    required this.kind,
    required this.description,
    required this.apiUrl,
  });

  factory PreparedBy.fromJson(Map<String, dynamic> json) {
    return PreparedBy(
      id: json['id'],
      sourceId: json['source_id'],
      title: json['title'],
      type: json['type'],
      kind: json['kind'],
      description: json['description'],
      apiUrl: json['api_url'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'source_id': sourceId,
      'title': title,
      'type': type,
      'kind': kind,
      'description': description,
      'api_url': apiUrl,
    };
  }
}

class Links {
  String next;
  String prev;
  String first;
  String last;
  int currentPage;
  int pagesNumber;
  int totalItems;

  Links({
    required this.next,
    required this.prev,
    required this.first,
    required this.last,
    required this.currentPage,
    required this.pagesNumber,
    required this.totalItems,
  });

  factory Links.fromJson(Map<String, dynamic> json) {
    return Links(
      next: json['next'],
      prev: json['prev'],
      first: json['first'],
      last: json['last'],
      currentPage: json['current_page'],
      pagesNumber: json['pages_number'],
      totalItems: json['total_items'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'next': next,
      'prev': prev,
      'first': first,
      'last': last,
      'current_page': currentPage,
      'pages_number': pagesNumber,
      'total_items': totalItems,
    };
  }
}
