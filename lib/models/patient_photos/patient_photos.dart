// ignore_for_file: non_constant_identifier_names

class PatientPhotos {
  final dynamic id;
  final String img_url;
  final String date_created;

  const PatientPhotos({
    required this.id,
    required this.img_url,
    required this.date_created,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'img_url': img_url,
      'date_created': date_created,
    };
  }

  factory PatientPhotos.fromJson(Map<String, dynamic> map) {
    return PatientPhotos(
      id: map['id'] as dynamic,
      img_url: map['img_url'] as String,
      date_created: map['date_created'] as String,
    );
  }
}
