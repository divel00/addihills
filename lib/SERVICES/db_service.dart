
import 'package:addhills_app/MODELS/docs.dart';
import 'package:addhills_app/MODELS/docu_request.dart';
import 'package:addhills_app/MODELS/equips.dart';
import 'package:addhills_app/MODELS/users.dart';
import 'package:addhills_app/MODELS/venues.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

const String DOCS_COLLECTION_REF = 'documents';
const String DOCREQ_COLLECTION_REF = 'document_requests';
const String EQUIPS_COLLECTION_REF = 'event_equipment';
const String VENUES_COLLECTION_REF = 'event_venue';
const String USERINFO_COLLECTION_REF = 'apptest';

class DbService{
  final _firestore = FirebaseFirestore.instance;

  late final CollectionReference _docsRef;
  late final CollectionReference _docsReqRef;
  late final CollectionReference _equipRef;
  late final CollectionReference _venueRef;
  late final CollectionReference _userInfoRef;

  DbService(){
    _docsRef = _firestore.collection(DOCS_COLLECTION_REF).withConverter<Docs>(
      fromFirestore: (snapshots, _) => Docs.fromJson(snapshots.data()!,), 
      toFirestore: (docs, _) => docs.toJson());

    _docsReqRef = _firestore.collection(DOCREQ_COLLECTION_REF).withConverter<DocuRequest>(
      fromFirestore: (snapshots, _) => DocuRequest.fromJson(snapshots.data()!,), 
      toFirestore: (docsreq, _) => docsreq.toJson());
    
    _equipRef = _firestore.collection(EQUIPS_COLLECTION_REF).withConverter<Equips>(
      fromFirestore: (snapshots, _) => Equips.fromJson(snapshots.data()!,), 
      toFirestore: (equip, _) => equip.toJson());

    _venueRef = _firestore.collection(VENUES_COLLECTION_REF).withConverter<Venues>(
      fromFirestore: (snapshots, _) => Venues.fromJson(snapshots.data()!,), 
      toFirestore: (venue, _) => venue.toJson());

    _userInfoRef = _firestore.collection(USERINFO_COLLECTION_REF).withConverter<Users>(
      fromFirestore: (snapshots, _) => Users.fromJson(snapshots.data()!,), 
      toFirestore: (userInfo, _) => userInfo.toJson());
  }

// read
  Stream<QuerySnapshot> getDocs(){
    return _docsRef.snapshots();
  }

  Stream<QuerySnapshot> getDocsReq(){
    return _docsReqRef.snapshots();
  }

  Stream<QuerySnapshot> getEquips(){
    return _equipRef.snapshots();
  }

  Stream<QuerySnapshot> getVenues(){
    return _venueRef.snapshots();
  }

  Stream<QuerySnapshot> getUsers(){
    return _userInfoRef.snapshots();
  }

  void addDocsReq (DocuRequest docsreq) async{
    _docsReqRef.add(docsreq);
  }

  void addUserInfo (Users userInfo) async{
    _userInfoRef.add(userInfo);
  }

}