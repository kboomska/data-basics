import '/widgets/address.dart';

class Human {
  String name;
  String surname;
  int age;
  List<Address> addreses;

  Human({
    required this.name,
    required this.surname,
    required this.age,
    required this.addreses,
  });

  factory Human.fromJson(Map<String, dynamic> json) {
    return Human(
      name: json['name'] as String,
      surname: json['surname'] as String,
      age: json['age'] as int,
      addreses: (json['addreses'] as List<dynamic>)
          .map(
            (dynamic e) => Address.fromJson(e as Map<String, dynamic>),
          )
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'name': name,
      'surname': surname,
      'age': age,
      'addreses': addreses.map((e) => e.toJson()).toList(),
    };
  }
}
