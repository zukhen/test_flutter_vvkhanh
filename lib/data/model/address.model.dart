class AddressModel {
  final String title;
  final String id;
  final Position position;

  AddressModel({
    required this.title,
    required this.id,
    required this.position,
  });

  factory AddressModel.fromJson(Map<String, dynamic> json) {
    return AddressModel(
      title: json['title'],
      id: json['id'],
      position: Position.fromJson(json['position']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'id': id,
      'position': position.toJson(),
    };
  }
}

class Position {
  final double lat;
  final double lng;

  Position({required this.lat, required this.lng});

  factory Position.fromJson(Map<String, dynamic> json) {
    return Position(
      lat: json['lat'],
      lng: json['lng'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'lat': lat,
      'lng': lng,
    };
  }
}
