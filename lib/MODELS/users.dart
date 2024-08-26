import 'package:cloud_firestore/cloud_firestore.dart';

class Users{
  String lastName;
  String firstName;
  String userEmail;
  String phoneNumber;
  String address;
  String birthday;
  Timestamp createdOn;

  Users({
    required this.lastName,
    required this.firstName,
    required this.userEmail,
    required this.phoneNumber,
    required this.address,
    required this.birthday,
    required this.createdOn,
  });

  Users.fromJson(Map<String, Object?> json) :
  this(
    lastName: json['lastName']! as String,
    firstName: json['firstName']! as String,
    userEmail: json['userEmail']! as String,
    phoneNumber: json['phoneNumber']! as String,
    address: json['address']! as String,
    birthday: json['birthday']! as String,
    createdOn: json['createdOn']! as Timestamp,    
  );

  Users copyWith({
    String? lastName,
    String? firstName,
    String? email,
    String? phoneNumber,
    String? address,
    String? birthday,
    Timestamp? createdOn,


  }) {
    return Users(
      lastName: lastName ?? this.lastName,
      firstName: firstName ?? this.firstName,
      userEmail: email ?? this.userEmail,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      address: address ?? this.address,
      birthday: birthday ?? this.birthday,
      createdOn: createdOn ?? this.createdOn, 
    );
  }

  Map<String, Object?> toJson(){
    return {
      'lastName': lastName,
      'firstName': firstName,
      'userEmail': userEmail,
      'phoneNumber': phoneNumber,
      'address': address,
      'birthday': birthday,
      'createdOn': createdOn,
    };
  }
}




// checkpoint : work on venue page&database