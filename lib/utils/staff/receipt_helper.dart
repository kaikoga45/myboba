import 'package:cloud_firestore/cloud_firestore.dart';

class ReceiptHelper {
  ReceiptHelper._privateConstructor();
  static final instance = ReceiptHelper._privateConstructor();

  final _firestore = FirebaseFirestore.instance;

  Future<bool> setPickup(int receiptId) async {
    bool _isError = false;

    try {
      QuerySnapshot snapshotOrder = await _firestore
          .collection('order')
          .where('pickup', isEqualTo: false)
          .where('checkout', isEqualTo: true)
          .where('receipt_id', isEqualTo: receiptId)
          .get()
          .then((QuerySnapshot querySnapshot) {
        if (querySnapshot.docs.isNotEmpty) {
          return querySnapshot;
        } else {
          return null;
        }
      }).catchError((onError) {
        throw onError;
      });

      snapshotOrder.docs.forEach((element) async {
        await _firestore.collection('order').doc(element.id).update({
          'pickup': true,
          'receipt_id': 0,
        }).catchError((onError) {
          throw onError;
        });
      });

      QuerySnapshot snapshotReceipt = await _firestore
          .collection('receipt')
          .where('pickup', isEqualTo: false)
          .where('receipt_id', isEqualTo: receiptId)
          .get()
          .catchError((onError) {
        throw onError;
      });

      DocumentSnapshot doc = snapshotReceipt.docs[0];

      await _firestore.collection('receipt').doc(doc.id).update({
        'pickup': true,
        'receipt_id': 0,
      }).catchError((onError) {
        throw onError;
      });
    } catch (e) {
      print(e);
      _isError = true;
    }
    return _isError;
  }

  Future<bool> setServe(int receiptId) async {
    QuerySnapshot snapshot = await _firestore
        .collection('receipt')
        .where('pickup', isEqualTo: true)
        .where('receipt_id', isEqualTo: receiptId)
        .get();

    DocumentSnapshot doc = snapshot.docs[0];

    await _firestore.collection('receipt').doc(doc.id).update({
      'serve': true,
    });

    return true;
  }
}
