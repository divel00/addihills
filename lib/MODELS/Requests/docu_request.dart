import 'package:cloud_firestore/cloud_firestore.dart';

class DocuRequest{
  String document_title;
  String requester_name;
  String address;
  String birthday;
  String request_status;
  String user_email;
  String years_of_residence;
  String user_age;
  Timestamp date_requested;
  Timestamp pickup_date;
  String contact_number;
  double fee;
  
  DocuRequest({
    required this.document_title,
    required this.requester_name,
    required this.address,
    required this.birthday,
    required this.request_status,
    required this.user_email,
    required this.date_requested,
    required this.pickup_date,
    required this.years_of_residence,
    required this.user_age,
    required this.contact_number,
    required this.fee,
  });

  DocuRequest.fromJson(Map<String, Object?> json) :
  this(
    document_title: json['document_title']! as String,
    requester_name: json['requester_name']! as String,
    address: json['address']! as String,
    birthday: json['birthday']! as String,
    request_status: json['request_status']! as String,
    user_email: json['user_email']! as String,
    date_requested: json['date_requested']! as Timestamp,
    pickup_date: json['pickup_date']! as Timestamp,
    years_of_residence: json['years_of_residence']! as String,
    user_age: json['user_age']! as String,
    contact_number: json['contact_number']! as String,
    fee: json['fee']! as double,
  );

  DocuRequest copyWith({
    String? document_title,
    String? requester_name,
    String? address,
    String? birthday,
    String? request_status,
    String? user_email,
    Timestamp? date_requested,
    Timestamp? pickup_date,
    String? years_of_residence,
    String? user_age,
    String? contact_number,
    double? fee
  }) {
    return DocuRequest(
      document_title: document_title ?? this.document_title,
      requester_name: requester_name ?? this.requester_name,
      address: address ?? this.address, 
      birthday: birthday ?? this.birthday, 
      request_status: request_status ?? this.request_status, 
      user_email: user_email ?? this.user_email,
      date_requested: date_requested ?? this.date_requested, 
      pickup_date: pickup_date ?? this.pickup_date,
      years_of_residence: years_of_residence ?? this.years_of_residence,
      user_age: user_age ?? this.user_age,
      contact_number: contact_number ?? this.contact_number,
      fee: fee ?? this.fee,
    );
  }

  Map<String, Object?> toJson(){
    return {
      'document_title': document_title,
      'requester_name': requester_name,
      'address': address,
      'birthday': birthday,
      'request_status': request_status,
      'user_email': user_email, 
      'date_requested': date_requested,
      'pickup_date': pickup_date,
      'years_of_residence': years_of_residence,
      'user_age': user_age,
      'contact_number': contact_number,
      'fee': fee,
    };
  }
}