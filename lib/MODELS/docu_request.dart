import 'package:cloud_firestore/cloud_firestore.dart';

class DocuRequest{
  String document_title;
  String requester_name;
  String address;
  String birthday;
  String request_status;
  String user_email;
  Timestamp date_requested;
  Timestamp pickup_date;
  
  DocuRequest({
    required this.document_title,
    required this.requester_name,
    required this.address,
    required this.birthday,
    required this.request_status,
    required this.user_email,
    required this.date_requested,
    required this.pickup_date
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
    };
  }
}