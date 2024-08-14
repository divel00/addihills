
import 'package:addhills_app/MODELS/docs.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

const String DOCS_COLLECTION_REF = 'documents';


class DbService{
  final _firestore = FirebaseFirestore.instance;

  late final CollectionReference _docsRef;

  DbService(){
    _docsRef = _firestore.collection(DOCS_COLLECTION_REF).withConverter<Docs>(
      fromFirestore: (snapshots, _) => Docs.fromJson(snapshots.data()!,), 
      toFirestore: (docs, _) => docs.toJson());
  }

  Stream<QuerySnapshot> getDocs(){
    return _docsRef.snapshots();
  }
}