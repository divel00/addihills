
import 'package:addhills_app/MODELS/docs.dart';
import 'package:addhills_app/MODELS/docu_request.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

const String DOCS_COLLECTION_REF = 'documents';
const String DOCREQ_COLLECTION_REF = 'document_requests';


class DbService{
  final _firestore = FirebaseFirestore.instance;

  late final CollectionReference _docsRef;
  late final CollectionReference _docsReqRef;

  DbService(){
    _docsRef = _firestore.collection(DOCS_COLLECTION_REF).withConverter<Docs>(
      fromFirestore: (snapshots, _) => Docs.fromJson(snapshots.data()!,), 
      toFirestore: (docs, _) => docs.toJson());

    _docsReqRef = _firestore.collection(DOCREQ_COLLECTION_REF).withConverter<DocuRequest>(
      fromFirestore: (snapshots, _) => DocuRequest.fromJson(snapshots.data()!,), 
      toFirestore: (docsreq, _) => docsreq.toJson());    
  }

  Stream<QuerySnapshot> getDocs(){
    return _docsRef.snapshots();
  }

  Stream<QuerySnapshot> getDocsReq(){
    return _docsReqRef.snapshots();
  }

  void addDocsReq (DocuRequest docsreq) async{
    _docsReqRef.add(docsreq);
  }
}