import 'package:cloud_firestore/cloud_firestore.dart';

class Announcements{
  String title;
  String content;
  String last_modified_by;
  String published_by;
  Timestamp published_date;
  Timestamp last_modified_date;
  

  Announcements({
    required this.title,
    required this.content,
    required this.last_modified_by,
    required this.published_by,
    required this.published_date,
    required this.last_modified_date,
  });

  Announcements.fromJson(Map<String, Object?> json) :
  this(
    title: json['title']! as String,
    content: json['content']! as String,
    last_modified_by: json['last_modified_by']! as String,
    published_by: json['published_by']! as String,
    published_date: json['published_date']! as Timestamp,
    last_modified_date: json['last_modified_date']! as Timestamp,
  );

  Announcements copyWith({
    String? title,
    String? content,
    String? last_modified_by,
    String? published_by,
    Timestamp? published_date,
    Timestamp? last_modified_date,

  }) {
    return Announcements(
      title: title ?? this.title,
      content: content ?? this.content,
      last_modified_by: last_modified_by ?? this.last_modified_by,
      published_by: published_by ?? this.published_by,
      published_date: published_date ?? this.published_date,
      last_modified_date: last_modified_date ?? this.last_modified_date,
    );
  }

  Map<String, Object?> toJson(){
    return {
      'title': title,
      'content': content,
      'last_modified_by': last_modified_by,
      'published_by': published_by,
      'published_date': published_date,
      'last_modified_date': last_modified_date,
    };
  }
}