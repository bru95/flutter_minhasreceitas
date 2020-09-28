import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:minhasreceitas/service_locator.dart';
import 'package:minhasreceitas/services/localstorage_service.dart';

class FirebaseService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final String path;
  CollectionReference ref;

  FirebaseService(this.path) {
    ref = _db.collection(path);
  }

  Stream<QuerySnapshot> streamDataCollection() {
    var sharedPreferences = locator<LocalStorageService>();
    return ref.orderBy("name").where("userId", isEqualTo: sharedPreferences.usrLogged).snapshots();
  }

  Stream<QuerySnapshot> streamDataCollectionFavorites() {
    var sharedPreferences = locator<LocalStorageService>();
    return ref.orderBy("name").where("userId", isEqualTo: sharedPreferences.usrLogged).where("favorite", isEqualTo: true).snapshots();
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
