import 'package:cloud_firestore/cloud_firestore.dart';

class ScannerHelper {
  final _firestoreApi = FirebaseFirestore.instance;

  Future<bool> setPickup(int receiptId) async {
    bool _isError = false;

    try {
      // Fetch all the order data that has been final in order collection

      QuerySnapshot snapshotOrder = await _firestoreApi
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

      // Set all the value on field pickup equal to true in every order that has been final in order collection

      snapshotOrder.docs.forEach((element) async {
        await _firestoreApi.collection('order').doc(element.id).update({
          'pickup': true,
        }).catchError((onError) {
          throw onError;
        });
      });

      // Fetch all the receipt data that has been creating in receipt collection

      QuerySnapshot snapshotReceipt = await _firestoreApi
          .collection('receipt')
          .where('pickup', isEqualTo: false)
          .where('receipt_id', isEqualTo: receiptId)
          .get()
          .catchError((onError) {
        throw onError;
      });

      DocumentSnapshot doc = snapshotReceipt.docs[0];

      // Set all the value on field pickup equal to true in receipt

      await _firestoreApi.collection('receipt').doc(doc.id).update({
        'pickup': true,
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
    // Set the value to true in pickup in equal to true to indicate that the customer order has been serve
    QuerySnapshot snapshot = await _firestoreApi
        .collection('receipt')
        .where('pickup', isEqualTo: true)
        .where('receipt_id', isEqualTo: receiptId)
        .get();

    DocumentSnapshot doc = snapshot.docs[0];

    await _firestoreApi.collection('receipt').doc(doc.id).update({
      'serve': true,
    });

    return true;
  }

  Future<String?> getCustomerName(int receiptId) async {
    String? _name = '';

    try {
      QuerySnapshot _receiptSnapshot = await _firestoreApi
          .collection('receipt')
          .where('receipt_id', isEqualTo: receiptId)
          .limit(1)
          .get();
      QuerySnapshot _usersSnapshot = await _firestoreApi
          .collection('users')
          .where('source_UID',
              isEqualTo: _receiptSnapshot.docs[0]['customer_id'])
          .limit(1)
          .get();

      print(_usersSnapshot.docs[0]['username']);

      _name = _usersSnapshot.docs[0]['username'];
    } catch (e) {
      print(e);
    }

    return _name;
  }
}
