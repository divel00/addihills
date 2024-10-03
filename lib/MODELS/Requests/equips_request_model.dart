import 'package:cloud_firestore/cloud_firestore.dart';

class EquipsRequestModel {
  String start_time;
  String end_time;
  String requester_name;
  String address;
  String birthday;
  String request_status;
  String user_email;
  String user_age;
  Timestamp date_requested;
  String selected_date;
  String purpose;
  String contact_number;
  List<String> equipments; 
  
  EquipsRequestModel({
    required this.start_time,
    required this.end_time,
    required this.requester_name,
    required this.address,
    required this.birthday,
    required this.request_status,
    required this.user_email,
    required this.date_requested,
    required this.selected_date,
    required this.user_age,
    required this.purpose,
    required this.contact_number,
    required this.equipments,
  });

  EquipsRequestModel.fromJson(Map<String, Object?> json) :
  this(
    start_time: json['start_time']! as String,
    end_time: json['end_time']! as String,
    requester_name: json['requester_name']! as String,
    address: json['address']! as String,
    birthday: json['birthday']! as String,
    request_status: json['request_status']! as String,
    user_email: json['user_email']! as String,
    date_requested: json['date_requested']! as Timestamp,
    selected_date: json['selected_date']! as String,
    user_age: json['user_age']! as String,
    purpose: json['purpose']! as String,
    contact_number: json['contact_number']! as String,
    equipments: json['equipments'] as List<String>,
  );

  EquipsRequestModel copyWith({
    String? start_time,
    String? end_time,
    String? requester_name,
    String? address,
    String? birthday,
    String? request_status,
    String? user_email,
    Timestamp? date_requested,
    String? selected_date,
    String? user_age,
    String? purpose,
    String? contact_number,
    List<String>? equipments,
  }) {
    return EquipsRequestModel(
      start_time: start_time ?? this.start_time,
      end_time: end_time ?? this.end_time,
      requester_name: requester_name ?? this.requester_name,
      address: address ?? this.address, 
      birthday: birthday ?? this.birthday, 
      request_status: request_status ?? this.request_status, 
      user_email: user_email ?? this.user_email,
      date_requested: date_requested ?? this.date_requested, 
      selected_date: selected_date ?? this.selected_date,
      user_age: user_age ?? this.user_age,
      purpose: purpose ?? this.purpose,
      contact_number: contact_number ?? this.contact_number,
      equipments: equipments ?? this.equipments,
    );
  }

  Map<String, Object?> toJson(){
    return {
      'start_time': start_time,
      'end_time': end_time,
      'requester_name': requester_name,
      'address': address,
      'birthday': birthday,
      'request_status': request_status,
      'user_email': user_email, 
      'date_requested': date_requested,
      'selected_date': selected_date,
      'user_age': user_age,
      'purpose': purpose,
      'contact_number': contact_number,
      'equipments': equipments,
    };
  }
}
