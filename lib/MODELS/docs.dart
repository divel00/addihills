import 'package:cloud_firestore/cloud_firestore.dart';

class Docs{
  String title;
  String description;
  Timestamp createdOn;
  Timestamp lastModificationOn;
  List<dynamic> docRequirements;
  double fee;
  String imageUrl;

  Docs({
    required this.title,
    required this.description,
    required this.createdOn,
    required this.lastModificationOn,
    required this.docRequirements,
    required this.fee,
    required this.imageUrl,
  });

  Docs.fromJson(Map<String, Object?> json) :
  this(
    title: json['title']! as String,
    description: json['description']! as String,
    createdOn: json['createdOn']! as Timestamp,
    lastModificationOn: json['lastModifiedOn']! as Timestamp,
    docRequirements: json['docRequirements']! as List<dynamic>,
    fee: _parseFee(json['fee']),
    imageUrl: json['imageUrl']! as String,
  );

  // Utility method to handle type conversion for fee
  static double _parseFee(Object? fee) {
    if (fee == null) return 0.00;
    if (fee is double) return fee;
    if (fee is int) return fee.toDouble();
    throw ArgumentError('Invalid type for fee: ${fee.runtimeType}');
  }

  Docs copyWith({
    String? title,
    String? description,
    Timestamp? createdOn,
    Timestamp? lastModificationOn,
    List<dynamic>? docRequirements,
    double? fee,
    String? imageUrl,
  }) {
    return Docs(
      title: title ?? this.title,
      description: description ?? this.description, 
      createdOn: createdOn ?? this.createdOn, 
      lastModificationOn: lastModificationOn ?? this.lastModificationOn,
      docRequirements: docRequirements ?? this.docRequirements,
      fee: fee ?? this.fee,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }

  Map<String, Object?> toJson(){
    return {
      'title': title,
      'description': description,
      'createdOn': createdOn,
      'lastModificationOn': lastModificationOn,
      'docRequirements': docRequirements,
      'fee': fee,
      'imageUrl': imageUrl,
    };
  }
}