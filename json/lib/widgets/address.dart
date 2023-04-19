class Address {
  final String city;
  final String street;
  final String house;
  final int flat;

  Address({
    required this.city,
    required this.street,
    required this.house,
    required this.flat,
  });

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      city: json['city'] as String,
      street: json['street'] as String,
      house: json['house'] as String,
      flat: json['flat'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'city': city,
      'street': street,
      'house': house,
      'flat': flat,
    };
  }
}
