class Complain {
  String id;
  String name;
  String streetName;
  String cityName;
  String stateName;
  String postalCode;
  String countryName;
  String phoneNumber;
  double latitude;
  double longitude;
  double number;
  String hashtag;
  String imageUrl;

  Complain(
      {required this.id,
      required this.name,
      required this.streetName,
      required this.cityName,
      required this.stateName,
      required this.postalCode,
      required this.countryName,
      required this.phoneNumber,
      required this.latitude,
      required this.longitude,
      required this.number,
      required this.hashtag,
      required this.imageUrl});

  Map<String, Object> toJson() {
    return {
      'id': id,
      'name': name,
      'street_name': streetName,
      'city_name': cityName,
      'state_name': stateName,
      'postal_code': postalCode,
      'country_name': countryName,
      'phone_number': phoneNumber,
      'latitude': latitude,
      'longitude': longitude,
      'number': number,
      'hashtag':hashtag,
      'image_url': imageUrl,
    };
  }
}
