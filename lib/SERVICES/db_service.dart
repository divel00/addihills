import 'package:addhills_app/MODELS/Requests/equips_request_model.dart';
import 'package:addhills_app/MODELS/Requests/venue_request_model.dart';
import 'package:addhills_app/MODELS/announcements.dart';
import 'package:addhills_app/MODELS/docs.dart';
import 'package:addhills_app/MODELS/Requests/docu_request.dart';
import 'package:addhills_app/MODELS/equips.dart';
import 'package:addhills_app/MODELS/users.dart';
import 'package:addhills_app/MODELS/venues.dart';
import 'package:addhills_app/PAGE/OTHER_SERVICES/VENUE_PAGE/item_Map.dart';
import 'package:addhills_app/utils/methods.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

const String DOCS_COLLECTION_REF = 'documents';
const String EQUIPS_COLLECTION_REF = 'event_equipment';
const String VENUES_COLLECTION_REF = 'event_venue';
const String ANNOUNCEMENT_COLLECTION_REF = 'announcements';
const String DOCREQ_COLLECTION_REF = 'document_requests';
const String VENUEREQ_COLLECTION_REF = 'venue_requests';
const String EQUIPREQ_COLLECTION_REF = 'equipment_requests';
const String USERS_COLLECTION_REF = 'users';

class DbService {
  final _firestore = FirebaseFirestore.instance;

  late final CollectionReference<Docs> _docsRef;
  late final CollectionReference<DocuRequest> _docsReqRef;
  late final CollectionReference<Equips> _equipRef;
  late final CollectionReference<Venues> _venueRef;
  late final CollectionReference<Announcements> _announcementRef;
  late final CollectionReference<VenueRequestModel> _venueReqRef;
  late final CollectionReference<EquipsRequestModel> _equipReqRef;
  late final CollectionReference<UsersInfo> _usersInfoRef;

  CollectionReference<VenueRequestModel> get venueReqRef => _venueReqRef;

  DbService() {
    
    _docsRef = _firestore.collection(DOCS_COLLECTION_REF).withConverter<Docs>(
      fromFirestore: (snapshots, _) => Docs.fromJson(snapshots.data()!),
      toFirestore: (docs, _) => docs.toJson(),
    );

    _docsReqRef = _firestore.collection(DOCREQ_COLLECTION_REF).withConverter<DocuRequest>(
      fromFirestore: (snapshots, _) => DocuRequest.fromJson(snapshots.data()!),
      toFirestore: (docsreq, _) => docsreq.toJson(),
    );

    _equipRef = _firestore.collection(EQUIPS_COLLECTION_REF).withConverter<Equips>(
      fromFirestore: (snapshots, _) => Equips.fromJson(snapshots.data()!),
      toFirestore: (equip, _) => equip.toJson(),
    );

    _venueRef = _firestore.collection(VENUES_COLLECTION_REF).withConverter<Venues>(
      fromFirestore: (snapshots, _) => Venues.fromJson(snapshots.data()!),
      toFirestore: (venue, _) => venue.toJson(),
    );

    _announcementRef = _firestore.collection(ANNOUNCEMENT_COLLECTION_REF).withConverter<Announcements>(
      fromFirestore: (snapshots, _) => Announcements.fromJson(snapshots.data()!),
      toFirestore: (announce, _) => announce.toJson(),
    );

    _venueReqRef = _firestore.collection(VENUEREQ_COLLECTION_REF).withConverter<VenueRequestModel>(
      fromFirestore: (snapshots, _) => VenueRequestModel.fromJson(snapshots.data()!),
      toFirestore: (venuereq, _) => venuereq.toJson(),
    );

    _equipReqRef = _firestore.collection(EQUIPREQ_COLLECTION_REF).withConverter<EquipsRequestModel>(
      fromFirestore: (snapshots, _) => EquipsRequestModel.fromJson(snapshots.data()!),
      toFirestore: (equipreq, _) => equipreq.toJson(),
    );

    _usersInfoRef = _firestore.collection(USERS_COLLECTION_REF).withConverter<UsersInfo>(
      fromFirestore: (snapshots, _) => UsersInfo.fromJson(snapshots.data()!),
      toFirestore: (userinfo, _) => userinfo.toJson(),
    );
  }

  // Read
  Stream<QuerySnapshot<Docs>> getDocs() {
    return _docsRef.snapshots();
  }

  Stream<QuerySnapshot<DocuRequest>> getDocsReq() {
    return _docsReqRef.snapshots();
  }

  Stream<QuerySnapshot<Equips>> getEquips() {
    return _equipRef.snapshots();
  }

  Stream<QuerySnapshot<Venues>> getVenues() {
    return _venueRef.snapshots();
  }

  Stream<QuerySnapshot<VenueRequestModel>> getVenueReqs() {
    return _venueReqRef.where('request_status', isEqualTo: 'Approved').snapshots();
  }

  Stream<QuerySnapshot<Announcements>> getAnnouncements() {
    return _announcementRef.snapshots();
  }
  
  Future<DocumentSnapshot<UsersInfo>> getUsersInfo(String uid) async {
    try {
      // Fetch the specific document by UID with automatic conversion
      DocumentSnapshot<UsersInfo> userInfo = await _usersInfoRef.doc(uid).get();
      return userInfo; 
    } catch (e) {
      print("Error fetching user info: $e");
      rethrow; // Optionally rethrow the error
    }
  }


  // Method to get all user requests
  Future<List<Map<String, dynamic>>> getAllUserRequests(String userEmail) async {
    List<Map<String, dynamic>> allRequests = [];

    // Fetch document requests
    try {
      QuerySnapshot<DocuRequest> docRequestsSnapshot = await _docsReqRef.where('user_email', isEqualTo: userEmail).get();
      for (var doc in docRequestsSnapshot.docs) {
        allRequests.add({
          'type': 'Document Request',
          'data': doc.data(),
        });
      }
    } catch (e) {
      print("Error fetching document requests: $e");
    }

    // Fetch venue requests
    try {
      QuerySnapshot<VenueRequestModel> venueRequestsSnapshot = await _venueReqRef.where('user_email', isEqualTo: userEmail).get();
      for (var venueDoc in venueRequestsSnapshot.docs) {
        allRequests.add({
          'type': 'Venue Request',
          'data': venueDoc.data(),
        });
      }
    } catch (e) {
      print("Error fetching venue requests: $e");
    }

    // Fetch equipment requests
    try {
      QuerySnapshot<EquipsRequestModel> equipRequestsSnapshot = await _equipReqRef.where('user_email', isEqualTo: userEmail).get();
      for (var equipDoc in equipRequestsSnapshot.docs) {
        allRequests.add({
          'type': 'Equipment Request',
          'data': equipDoc.data(),
        });
      }
    } catch (e) {
      print("Error fetching equipment requests: $e");
    }

    return allRequests;
  }






  // Fetch equipment
  Stream<List<Equipment>> getEquipments() {
    return _equipRef.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        final equip = doc.data();
        return Equipment(
          id: doc.id,
          name: equip.itemName, 
          available: equip.available,
        );
      }).toList();
    });
  }

  // create || add
  void addDocsReq(String id, DocuRequest docsreq) async {
    await _docsReqRef.doc(id).set(docsreq);
  }

  void addVenueReq(String id, VenueRequestModel venuereq) async {
    await _venueReqRef.doc(id).set(venuereq);
  }

  void addEquipReq(String id, EquipsRequestModel equipreq) async {
    await _equipReqRef.doc(id).set(equipreq);
  }

  void addUserInfo(String id, UsersInfo userinfo) async {
    await _usersInfoRef.doc(id).set(userinfo);
  }

  // update
  void updUserInfo(String id, UsersInfo userinfo) async {
    try {
      await _usersInfoRef.doc(id).update(userinfo.toJson());
      //print("User info updated successfully");
    } catch (e) {
      print("Error updating user info: $e");
    }
  }

}


