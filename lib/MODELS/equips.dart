import 'package:cloud_firestore/cloud_firestore.dart';

class Equips{
  String itemName;
  String itemDescription;
  int itemQuantity;
  List<dynamic> itemRequirements;
  Timestamp createdOn;
  Timestamp lastUpdatedOn;
  Map pricingTable;
  List<dynamic> rules;

  Equips({
    required this.itemName,
    required this.itemDescription,
    required this.itemQuantity,
    required this.itemRequirements,
    required this.createdOn,
    required this.lastUpdatedOn,
    required this.pricingTable,
    required this.rules,
  });

  Equips.fromJson(Map<String, Object?> json) :
  this(
    itemName: json['itemName']! as String,
    itemDescription: json['itemDescription']! as String,
    itemQuantity: json['itemQuantity']! as int,
    createdOn: json['createdOn']! as Timestamp,
    lastUpdatedOn: json['lastUpdatedOn']! as Timestamp,
    itemRequirements: json['itemRequirements']! as List<dynamic>,
    pricingTable: json['pricingTable']! as Map,
    rules:  json['rules']! as List<dynamic>,
  );

  Equips copyWith({
    String? itemName,
    String? itemDescription,
    int? itemQuantity,
    List<dynamic>? itemRequirements,
    Timestamp? createdOn,
    Timestamp? lastUpdatedOn,
    Map? pricingTable,
    List<dynamic>? rules,

  }) {
    return Equips(
      itemName: itemName ?? this.itemName,
      itemDescription: itemDescription ?? this.itemDescription, 
      itemQuantity: itemQuantity ?? this.itemQuantity,
      createdOn: createdOn ?? this.createdOn, 
      lastUpdatedOn: lastUpdatedOn ?? this.lastUpdatedOn,
      itemRequirements: itemRequirements ?? this.itemRequirements,
      pricingTable: pricingTable ?? this.pricingTable,
      rules: rules ?? this.rules,
    );
  }

  Map<String, Object?> toJson(){
    return {
      'itemName': itemName,
      'itemDescription': itemDescription,
      'itemQuantity': itemQuantity,
      'createdOn': createdOn,
      'lastUpdatedOn': lastUpdatedOn,
      'itemRequirements': itemRequirements,
      'pricingTable': pricingTable,
      'rules' : rules,
    };
  }
}