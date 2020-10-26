import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:minhasreceitas/service_locator.dart';
import 'package:minhasreceitas/services/localstorage_service.dart';
import 'dart:convert';

class FirebaseService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final String path;
  CollectionReference ref;

  FirebaseService(this.path) {
    ref = _db.collection(path);
  }

  Stream<QuerySnapshot> streamDataCollection() {
    var sharedPreferences = locator<LocalStorageService>();
    var user = json.decode(sharedPreferences.usrLogged);
    return ref
        .orderBy("name")
        .where("userId", isEqualTo: user['uid'])
        .snapshots();
  }

  Stream<QuerySnapshot> streamDataCollectionFavorites() {
    var sharedPreferences = locator<LocalStorageService>();
    var user = json.decode(sharedPreferences.usrLogged);
    return ref
        .orderBy("name")
        .where("userId", isEqualTo: user['uid'])
        .where("favorite", isEqualTo: true)
        .snapshots();
  }

  Future<DocumentSnapshot> getDocumentById(String id) {
    return ref.doc(id).get();
  }

  Future<void> removeDocument(String id) {
    return ref.doc(id).delete();
  }

  Future<DocumentReference> addDocument(Map data) {
    return ref.add(data);
  }

  Future<void> updateDocument(Map data, String id) {
    return ref.doc(id).update(data);
  }
}
