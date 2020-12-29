import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:myboba/services/firebase/authentication.dart';
import 'package:myboba/utils/time.dart';

class FirestoreHelper {
  FirestoreHelper._privateConstructor();
  static final firestore = FirebaseFirestore.instance;
  static final FirestoreHelper instance = FirestoreHelper._privateConstructor();

  final _authHelper = AuthHelper.instance;

  Future<QuerySnapshot> getExistingOrderInCart(
      {@required String menuId, @required String description}) async {
    QuerySnapshot _querySnapshot;
    try {
      _querySnapshot = await firestore
          .collection('order')
          .limit(1)
          .where('customer_id', isEqualTo: _authHelper.customerId)
          .where('menu_id', isEqualTo: menuId)
          .where('description', isEqualTo: description)
          .where('checkout', isEqualTo: false)
          .where('pickup', isEqualTo: false)
          .get()
          .then(
        (QuerySnapshot snapshot) {
          if (snapshot.docs.isNotEmpty) {
            return snapshot;
          } else {
            return null;
          }
        },
      ).catchError((onError) {
        throw onError;
      });
    } catch (e) {
      print(e);
    }
    return _querySnapshot;
  }

  Future<bool> updateOrderInCart({
    @required String docId,
    @required int currentQuantity,
    @required int currentTotalPrice,
    @required int newTotalPrice,
  }) async {
    bool _isError = false;

    try {
      await firestore.collection('order').doc(docId).update(
        {
          'quantity': currentQuantity + 1,
          'total_price': currentTotalPrice + newTotalPrice
        },
      ).catchError((onError) {
        throw onError;
      });
    } catch (e) {
      print(e);
      _isError = true;
    }
    return _isError;
  }

  Future<bool> createNewOrderInCart(
      {@required String menuId,
      @required String menuName,
      @required String menuImg,
      @required String description,
      @required int totalPrice}) async {
    QuerySnapshot _data;

    bool _isError = false;

    try {
      _data = await firestore
          .collection('order')
          .where('customer_id', isEqualTo: _authHelper.customerId)
          .where('checkout', isEqualTo: false)
          .where('pickup', isEqualTo: false)
          .limit(1)
          .get()
          .then((QuerySnapshot querySnapshot) {
        return querySnapshot;
      }).catchError((onError) {
        throw onError;
      });

      DocumentSnapshot _existingReceiptId =
          _data.docs.isNotEmpty ? _data.docs[0] : null;

      Random _newReceiptId = Random();

      await firestore.collection('order').add({
        'menu_id': menuId,
        'customer_id': _authHelper.customerId,
        'receipt_id': _existingReceiptId == null
            ? _newReceiptId.nextInt(99999)
            : _existingReceiptId['receipt_id'],
        'checkout': false,
        'pickup': false,
        'menu_name': menuName,
        'menuImg': menuImg,
        'description': description,
        'total_price': totalPrice,
        'quantity': 1,
        'timestamp': Time.getTimeStamps(),
      }).catchError((onError) {
        throw onError;
      });
    } catch (e) {
      _isError = true;
      print(e);
    }
    return _isError;
  }

  Future<bool> deleteOrderInCart({@required String docId}) async {
    bool _isError = false;

    try {
      await firestore
          .collection('order')
          .doc(docId)
          .delete()
          .catchError((onError) {
        throw onError;
      });
    } catch (e) {
      _isError = true;
    }

    return _isError;
  }

  Future<bool> setCheckout() async {
    bool _isError = false;

    try {
      QuerySnapshot _snapshot = await firestore
          .collection('order')
          .where('customer_id', isEqualTo: _authHelper.customerId)
          .where('checkout', isEqualTo: false)
          .where('pickup', isEqualTo: false)
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

      int _totalPrice = 0;
      _snapshot.docs.forEach((element) {
        _totalPrice += element['total_price'];
      });

      _snapshot.docs.forEach((element) async {
        await firestore
            .collection('order')
            .doc(element.id)
            .update({'checkout': true}).catchError((onError) {
          throw onError;
        });
      });

      await firestore.collection('receipt').add({
        'customer_id': _authHelper.customerId,
        'receipt_id': _snapshot.docs[0]['receipt_id'],
        'pickup': false,
        'serve': false,
        'total_price': _totalPrice,
        'timestamp': Time.getTimeStamps()
      }).catchError((onError) {
        throw onError;
      });
    } catch (e) {
      _isError = true;
    }

    return _isError;
  }
}
