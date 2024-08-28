import 'package:cloud_firestore/cloud_firestore.dart';

class VenueRequestModel {
  String venue_name;
  String requester_name;
  String address;
  String birthday;
  String request_status;
  String user_email;
  String user_age;
  Timestamp date_requested;
  String set_date;
  String purpose;
  String contact_number;
  List<String> additional_equipments; 
  
  VenueRequestModel({
    required this.venue_name,
    required this.requester_name,
    required this.address,
    required this.birthday,
    required this.request_status,
    required this.user_email,
    required this.date_requested,
    required this.set_date,
    required this.user_age,
    required this.purpose,
    required this.contact_number,
    required this.additional_equipments,
  });

  VenueRequestModel.fromJson(Map<String, Object?> json) :
  this(
    venue_name: json['venue_name']! as String,
    requester_name: json['requester_name']! as String,
    address: json['address']! as String,
    birthday: json['birthday']! as String,
    request_status: json['request_status']! as String,
    user_email: json['user_email']! as String,
    date_requested: json['date_requested']! as Timestamp,
    set_date: json['set_date']! as String,
    user_age: json['user_age']! as String,
    purpose: json['purpose']! as String,
    contact_number: json['contact_number']! as String,
    additional_equipments: json['additional_equipments'] as List<String>,
  );

  VenueRequestModel copyWith({
    String? venue_name,
    String? requester_name,
    String? address,
    String? birthday,
    String? request_status,
    String? user_email,
    Timestamp? date_requested,
    String? set_date,
    String? user_age,
    String? purpose,
    String? contact_number,
    List<String>? additional_equipments,
  }) {
    return VenueRequestModel(
      venue_name: venue_name ?? this.venue_name,
      requester_name: requester_name ?? this.requester_name,
      address: address ?? this.address, 
      birthday: birthday ?? this.birthday, 
      request_status: request_status ?? this.request_status, 
      user_email: user_email ?? this.user_email,
      date_requested: date_requested ?? this.date_requested, 
      set_date: set_date ?? this.set_date,
      user_age: user_age ?? this.user_age,
      purpose: purpose ?? this.purpose,
      contact_number: contact_number ?? this.contact_number,
      additional_equipments: additional_equipments ?? this.additional_equipments,
    );
  }

  Map<String, Object?> toJson(){
    return {
      'venue_name': venue_name,
      'requester_name': requester_name,
      'address': address,
      'birthday': birthday,
      'request_status': request_status,
      'user_email': user_email, 
      'date_requested': date_requested,
      'set_date': set_date,
      'user_age': user_age,
      'purpose': purpose,
      'contact_number': contact_number,
      'additional_equipments': additional_equipments,
    };
  }
}
