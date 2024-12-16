import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

import '../../../firebase_options.dart';
import 'fcm_helper.dart';

abstract class FirebaseHelper {
  static Stream<QuerySnapshot<Map<String, dynamic>>> getCollectionStream(
      String collectionPath,
      {FirebaseFirestore? firestore}) {
    final firestoreInstance = firestore ?? FirebaseFirestore.instance;
    return firestoreInstance.collection(collectionPath).snapshots();
  }

  static Future<DocumentReference<Map<String, dynamic>>> insertDocument(
      String collectionPath, Map<String, dynamic> data,
      {String? documentId, FirebaseFirestore? firestore}) async {
    final firestoreInstance = firestore ?? FirebaseFirestore.instance;
    final collection = firestoreInstance.collection(collectionPath);
    if (documentId == null) {
      return await collection.add(data);
    } else {
      final doc = collection.doc(documentId);
      await doc.set(data);
      return doc;
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

  static Future<void> initFirebase() async {
    if (Firebase.apps.isEmpty) {
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );

      await FCMHelper.initNotifications();
    }
  }
}
