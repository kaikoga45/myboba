import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:myboba/services/firebase_authentication/authentication.dart';
import 'package:myboba/utils/customer/time.dart';

class OrderFirestoreHelper {
  static final firestoreApi = FirebaseFirestore.instance;

  final _authHelper = AuthHelper.instance;

  Future<QuerySnapshot?> getExistingOrderInCart(
      {required String menuId, required String description}) async {
    QuerySnapshot? _querySnapshot;
    try {
      /*
        Fetching all required data from order collection with specific where condition.
        Return querySnapshot if not empty, else return null.
       */
      _querySnapshot = await firestoreApi
          .collection('order')
          .limit(1)
          .where('customer_id', isEqualTo: _authHelper.getUserID())
          .where('menu_id', isEqualTo: menuId)
          .where('description', isEqualTo: description)
          .where('checkout', isEqualTo: false)
          .where('pickup', isEqualTo: false)
          .get()
          .then(
        (QuerySnapshot querySnapshot) {
          if (querySnapshot.docs.isNotEmpty) {
            return querySnapshot;
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
    required String docId,
    required int currentQuantity,
    required int currentTotalPrice,
    required int newTotalPrice,
  }) async {
    bool _isError = false;

    try {
      // Updating the values on quantity and total price at existing order data.
      await firestoreApi.collection('order').doc(docId).update(
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
      {required String menuId,
      required String? menuName,
      required String? menuImg,
      required String description,
      required int totalPrice}) async {
    QuerySnapshot _data;

    bool _isError = false;

    try {
      // Fetching data in order collection with specific where condition for trying to get the existing receipt_id
      _data = await firestoreApi
          .collection('order')
          .where('customer_id', isEqualTo: _authHelper.getUserID())
          .where('checkout', isEqualTo: false)
          .where('pickup', isEqualTo: false)
          .limit(1)
          .get()
          .then((QuerySnapshot querySnapshot) {
        return querySnapshot;
      }).catchError((onError) {
        throw onError;
      });

      /*
         If the receipt id does exist, it will set the value from data docs to the variable.
         Else, set the variable to null.
      */
      DocumentSnapshot? _existingReceiptId =
          _data.docs.isNotEmpty ? _data.docs[0] : null;

      // If previously, the id does not exist. Then, it will generate a new random receipt id
      bool _isReceiptIdExist = false;
      int? _newReceiptId;

      /*
         Checking if the new receipt id are exist in order collection.
         If it does exist, then it will generate a new random receipt id until the new receipt id does not exist in order collection
      */
      while (_isReceiptIdExist == false) {
        Random _randomNumber = Random();
        _newReceiptId = _randomNumber.nextInt(99999999);

        _isReceiptIdExist = await firestoreApi
            .collection('order')
            .where('receipt_id', isEqualTo: _newReceiptId)
            .get()
            .then((QuerySnapshot querySnapshot) {
          if (querySnapshot.docs.isNotEmpty) {
            return true;
          }
        }).catchError((onError) {
          throw onError;
        });
      }

      // Creating a new order data at order collection

      await firestoreApi.collection('order').add({
        'menu_id': menuId,
        'customer_id': _authHelper.getUserID(),
        'receipt_id': _existingReceiptId == null
            ? _newReceiptId
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

  Future<bool> deleteOrderInCart({required String docId}) async {
    bool _isError = false;

    // Deleting the order data in order collection
    try {
      await firestoreApi
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
      // Fetching all the order data from customer cart
      QuerySnapshot _snapshot = await firestoreApi
          .collection('order')
          .where('customer_id', isEqualTo: _authHelper.getUserID())
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

      // Calculating the total price for all order in cart

      int _totalPrice = 0;
      _snapshot.docs.forEach((element) {
        _totalPrice += element['total_price'];
      });

      // Set the checkout to true for indicate that the customer order are final

      _snapshot.docs.forEach((element) async {
        await firestoreApi
            .collection('order')
            .doc(element.id)
            .update({'checkout': true}).catchError((onError) {
          throw onError;
        });
      });

      // Creating a receipt

      await firestoreApi.collection('receipt').add({
        'customer_id': _authHelper.getUserID(),
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
