// To parse this JSON data, do
//
//     final userEntity = userEntityFromMap(jsonString);

// ignore_for_file: public_member_api_docs
import 'dart:convert';

class UserEntity {
  UserEntity({
    this.name,
    this.age,
    this.salary,
    this.socialAnimal,
    this.addresses,
    this.primaryAddress,
  });

  factory UserEntity.fromMap(Map<String, dynamic> json) => UserEntity(
        name: json['name'] == null ? null : json['name'] as String,
        age: json['age'] == null ? null : json['age'] as int,
        salary: json['salary'] == null ? null : json['salary'] as double,
        socialAnimal: json['social_animal'] == null
            ? null
            : json['social_animal'] as bool,
        addresses: json['addresses'] == null
            ? null
            : List<Address>.from((json['addresses']
                    as List<Map<String, dynamic>>)
                .map<Address>((Map<String, dynamic> x) => Address.fromMap(x))),
        primaryAddress: json['primary_address'] == null
            ? null
            : Address.fromMap(json['primary_address'] as Map<String, dynamic>),
      );

  factory UserEntity.fromJson(String str) =>
      UserEntity.fromMap(json.decode(str) as Map<String, dynamic>);

  String? name;
  int? age;
  double? salary;
  bool? socialAnimal;
  List<Address>? addresses;
  Address? primaryAddress;

  UserEntity copyWith({
    String? name,
    int? age,
    double? salary,
    bool? socialAnimal,
    List<Address>? addresses,
    Address? primaryAddress,
  }) =>
      UserEntity(
        name: name ?? this.name,
        age: age ?? this.age,
        salary: salary ?? this.salary,
        socialAnimal: socialAnimal ?? this.socialAnimal,
        addresses: addresses ?? this.addresses,
        primaryAddress: primaryAddress ?? this.primaryAddress,
      );

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() => <String, dynamic>{
        'name': name,
        'age': age,
        'salary': salary,
        'social_animal': socialAnimal,
        'addresses': addresses == null
            ? null
            : List<Map<String, dynamic>>.from(
                addresses!.map<Map<String, dynamic>>((Address x) => x.toMap())),
        'primary_address':
            primaryAddress == null ? null : primaryAddress!.toMap(),
      };
}

class Address {
  Address({
    this.city,
    this.state,
    this.pincode,
    this.lat,
    this.long,
    this.places,
  });

  factory Address.fromJson(String str) =>
      Address.fromMap(json.decode(str) as Map<String, dynamic>);

  factory Address.fromMap(Map<String, dynamic> json) => Address(
        city: json['city'] as String,
        state: json['State'] as String,
        pincode: json['pincode'] as int,
        lat: json['lat'] == null ? null : json['lat'] as double,
        long: json['long'] == null ? null : json['long'] as double,
        places: json['places'] == null
            ? null
            : List<String>.from(
                (json['places'] as List<String>).map<String>((String x) => x)),
      );

  String toJson() => json.encode(toMap());

  String? city;
  String? state;
  int? pincode;
  double? lat;
  double? long;
  List<String>? places;

  Address copyWith({
    String? city,
    String? state,
    int? pincode,
    double? lat,
    double? long,
    List<String>? places,
  }) =>
      Address(
        city: city ?? this.city,
        state: state ?? this.state,
        pincode: pincode ?? this.pincode,
        lat: lat ?? this.lat,
        long: long ?? this.long,
        places: places ?? this.places,
      );

  Map<String, dynamic> toMap() => <String, dynamic>{
        'city': city,
        'State': state,
        'pincode': pincode,
        'lat': lat,
        'long': long,
        'places': places == null
            ? null
            : List<dynamic>.from(places!.map<String>((String x) => x)),
      };
}
