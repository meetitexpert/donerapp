import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:donerapp/Models/Users.dart';

class DataRepository {
  // 1
  final CollectionReference collection =
      FirebaseFirestore.instance.collection('users');
  // 2
  Stream<QuerySnapshot> getStream() {
    return collection.snapshots();
  }
  // 3
  Future<DocumentReference> addPet(Users user) {
    return collection.add(user.toJson());
  }
  // 4
  void updateUser(Users user) async {
    await collection.doc(user.referenceId).update(user.toJson());
  }
  // 5
  void deleteUser(Users user) async {
    await collection.doc(user.referenceId).delete();
  }
}