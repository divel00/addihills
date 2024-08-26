import 'package:cloud_firestore/cloud_firestore.dart';

class Docs{
  String title;
  String description;
  Timestamp createdOn;
  Timestamp lastModificationOn;
  List<dynamic> docRequirements;
  String price;

  Docs({
    required this.title,
    required this.description,
    required this.createdOn,
    required this.lastModificationOn,
    required this.docRequirements,
    required this.price,
  });

  Docs.fromJson(Map<String, Object?> json) :
  this(
    title: json['title']! as String,
    description: json['description']! as String,
    createdOn: json['createdOn']! as Timestamp,
    lastModificationOn: json['lastModifiedOn']! as Timestamp,
    docRequirements: json['docRequirements']! as List<dynamic>,
    price: json['price']! as String,
  );

  Docs copyWith({
    String? title,
    String? description,
    Timestamp? createdOn,
    Timestamp? lastModificationOn,
    List<dynamic>? docRequirements,
    String? price,

  }) {
    return Docs(
      title: title ?? this.title,
      description: description ?? this.description, 
      createdOn: createdOn ?? this.createdOn, 
      lastModificationOn: lastModificationOn ?? this.lastModificationOn,
      docRequirements: docRequirements ?? this.docRequirements,
      price: price ?? this.price,
    );
  }

  Map<String, Object?> toJson(){
    return {
      'title': title,
      'description': description,
      'createdOn': createdOn,
      'lastModificationOn': lastModificationOn,
      'docRequirements': docRequirements,
      'price': price,
    };
  }
}