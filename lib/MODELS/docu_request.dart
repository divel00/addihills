import 'package:cloud_firestore/cloud_firestore.dart';

class DocuRequest{
  String document_title;
  String requester_name;
  String address;
  String birthday;
  String request_status;
  Timestamp date_requested;
  
  DocuRequest({
    required this.document_title,
    required this.requester_name,
    required this.address,
    required this.birthday,
    required this.request_status,
    required this.date_requested,

  });

  DocuRequest.fromJson(Map<String, Object?> json) :
  this(
    document_title: json['document_title']! as String,
    requester_name: json['requester_name']! as String,
    address: json['address']! as String,
    birthday: json['birthday']! as String,
    request_status: json['request_status']! as String,
    date_requested: json['date_requested']! as Timestamp,
  );

  DocuRequest copyWith({
    String? document_title,
    String? requester_name,
    String? address,
    String? birthday,
    String? request_status,
    Timestamp? date_requested,
  }) {
    return DocuRequest(
      document_title: document_title ?? this.document_title,
      requester_name: requester_name ?? this.requester_name,
      address: address ?? this.address, 
      birthday: birthday ?? this.birthday, 
      request_status: request_status ?? this.request_status, 
      date_requested: date_requested ?? this.date_requested, 
    );
  }

  Map<String, Object?> toJson(){
    return {
      'document_title': document_title,
      'requester_name': requester_name,
      'address': address,
      'birthday': birthday,
      'request_status': request_status,
      'date_requested': date_requested,
    };
  }
}