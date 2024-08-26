import 'package:cloud_firestore/cloud_firestore.dart';

class Venues{
  String venueName;
  String venueDescription;
  String venueAddress;
  List<dynamic> venueRequirements;
  Timestamp createdOn;
  Timestamp lastUpdatedOn;
  String venuePrice;
  List<dynamic> venueAvailable;

  Venues({
    required this.venueName,
    required this.venueDescription,
    required this.venueAddress,
    required this.venueRequirements,
    required this.createdOn,
    required this.lastUpdatedOn,
    required this.venuePrice,
    required this.venueAvailable
  });

  Venues.fromJson(Map<String, Object?> json) :
  this(
    venueName: json['venueName']! as String,
    venueDescription: json['venueDescription']! as String,
    venueAddress: json['venueAddress']! as String,
    createdOn: json['createdOn']! as Timestamp,
    lastUpdatedOn: json['lastUpdatedOn']! as Timestamp,
    venueRequirements: json['venueRequirements']! as List<dynamic>,
    venuePrice: json['venuePrice']! as String,
    venueAvailable: json['venueAvailable']! as List<dynamic>,
  );

  Venues copyWith({
    String? venueName,
    String? venueDescription,
    String? venueAddress,
    List<dynamic>? venueRequirements,
    Timestamp? createdOn,
    Timestamp? lastUpdatedOn,
    String? venuePrice,
    List<dynamic>? venueAvailable,

  }) {
    return Venues(
      venueName: venueName ?? this.venueName,
      venueDescription: venueDescription ?? this.venueDescription, 
      venueAddress: venueAddress ?? this.venueAddress,
      createdOn: createdOn ?? this.createdOn, 
      lastUpdatedOn: lastUpdatedOn ?? this.lastUpdatedOn,
      venueRequirements: venueRequirements ?? this.venueRequirements,
      venuePrice: venuePrice ?? this.venuePrice,
      venueAvailable: venueAvailable ?? this.venueAvailable,
    );
  }

  Map<String, Object?> toJson(){
    return {
      'venueName': venueName,
      'venueDescription': venueDescription,
      'venueAddress': venueAddress,
      'createdOn': createdOn,
      'lastUpdatedOn': lastUpdatedOn,
      'venueRequirements': venueRequirements,
      'venuePrice': venuePrice,
      'venueAvailable': venueAvailable,
    };
  }
}




// checkpoint : work on venue page&database