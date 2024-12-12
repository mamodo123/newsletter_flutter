import 'package:cloud_firestore/cloud_firestore.dart';

abstract class FirebaseHelper {
  static Stream<QuerySnapshot<Map<String, dynamic>>> getCollectionStream(
      String collectionPath) {
    final firestoreInstance = FirebaseFirestore.instance;
    return firestoreInstance.collection(collectionPath).snapshots();
  }

  static Future<void> insertDocument(
      String collectionPath, Map<String, dynamic> data,
      {String? documentId}) async {
    final firestoreInstance = FirebaseFirestore.instance;
    final collection = firestoreInstance.collection(collectionPath);
    if (documentId == null) {
      await collection.add(data);
    } else {
      await collection.doc(documentId).set(data);
    }
  }

  static Future<void> updateDocument(String collectionPath, String? documentId,
      Map<String, dynamic> data) async {
    final firestoreInstance = FirebaseFirestore.instance;
    await firestoreInstance
        .collection(collectionPath)
        .doc(documentId)
        .update(data);
  }
}
