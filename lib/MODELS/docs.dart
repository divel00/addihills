import 'package:cloud_firestore/cloud_firestore.dart';

class Docs{
  String title;
  String description;
  Timestamp createdOn;
  Timestamp lastModificationOn;

  Docs({
    required this.title,
    required this.description,
    required this.createdOn,
    required this.lastModificationOn,

  });

  Docs.fromJson(Map<String, Object?> json) :
  this(
    title: json['title']! as String,
    description: json['description']! as String,
    createdOn: json['createdOn']! as Timestamp,
    lastModificationOn: json['lastModifiedOn']! as Timestamp,
  );

  Docs copyWith({
    String? title,
    String? description,
    Timestamp? createdOn,
    Timestamp? lastModificationOn,
  }) {
    return Docs(
      title: title ?? this.title,
      description: description ?? this.description, 
      createdOn: createdOn ?? this.createdOn, 
      lastModificationOn: lastModificationOn ?? this.lastModificationOn,
    );
  }

  Map<String, Object?> toJson(){
    return {
      'title': title,
      'description': description,
      'createdOn': createdOn,
      'lastModificationOn': lastModificationOn,
    };
  }
}