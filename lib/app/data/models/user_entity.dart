// To parse this JSON data, do
//
//final userEntity = userEntityFromMap(jsonString);

// ignore_for_file: public_member_api_docs
import 'dart:convert';

/// User entity
class UserEntity {
  UserEntity({
    this.firstName,
    this.lastName,
    this.middleName,
    this.email,
    this.mobileNumber,
    this.primaryAddress,
  });

  factory UserEntity.fromMap(Map<String, dynamic> json) => UserEntity(
        firstName: json['first_name'] ?? '',
        lastName: json['last_name'] ?? '',
        middleName: json['middle_name'] ?? '',
        email: json['email'] ?? '',
        mobileNumber: json['mobile_number'] ?? '',
        primaryAddress: json['primary_address'] == null
            ? null
            : Address.fromMap(json['primary_address'] as Map<String, dynamic>),
      );

  factory UserEntity.fromJson(String str) =>
      UserEntity.fromMap(json.decode(str) as Map<String, dynamic>);

  /// First name
  String? firstName;

  /// Last name
  String? lastName;

  /// Middle name
  String? middleName;

  /// Email
  String? email;

  /// Mobile number
  String? mobileNumber;

  /// Primary address
  Address? primaryAddress;

  /// Copy with
  UserEntity copyWith({
    String? firstName,
    String? lastName,
    String? middleName,
    String? email,
    String? mobileNumber,
    Address? primaryAddress,
  }) =>
      UserEntity(
        email: email ?? this.email,
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        middleName: middleName ?? this.middleName,
        mobileNumber: mobileNumber ?? this.mobileNumber,
        primaryAddress: primaryAddress ?? this.primaryAddress,
      );

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() => <String, dynamic>{
        'first_name': firstName,
        'last_name': lastName,
        'middle_name': middleName,
        'email': email,
        'mobile_number': mobileNumber,
        'primary_address':
            primaryAddress == null ? null : primaryAddress!.toMap(),
      };
}

/// Address
class Address {
  Address({
    this.city,
    this.state,
    this.pincode,
    this.lat,
    this.long,
    this.places,
  });

  /// From json
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

  /// City
  String? city;

  /// State
  String? state;

  /// Pincode
  int? pincode;

  /// Latitude
  double? lat;

  /// Longitude
  double? long;

  /// Places
  List<String>? places;

  /// Copy with
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

  /// To map
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
