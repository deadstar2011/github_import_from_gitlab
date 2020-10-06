class AddressCoordinates {
  final double lat;
  final double lon;

  const AddressCoordinates({
    this.lat,
    this.lon,
  });

  factory AddressCoordinates.fromJson(Map<String, dynamic> json) {
    if (json == null) {
      return null;
    }

    return AddressCoordinates(
      lat: json['lat'] as double,
      lon: json['lon'] as double,
    );
  }
}

class Address {
  String title;
  AddressCoordinates coordinates;

  Address({
    this.title,
    this.coordinates,
  });

  factory Address.fromJson(Map<String, dynamic> json) {
    if (json == null) {
      return null;
    }
    return Address(
      title: json['title'] as String,
      coordinates: AddressCoordinates.fromJson(
          json['coordinates'] as Map<String, dynamic>),
    );
  }
}
