import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class StaffFirestoreHelper {
  StaffFirestoreHelper._privateConstructor();
  static final StaffFirestoreHelper instance =
      StaffFirestoreHelper._privateConstructor();

  static final firestore = FirebaseFirestore.instance;

  Future<bool> createStatus(
      {@required String name, @required String description}) async {
    bool _isError = false;

    try {
      await firestore.collection('status').add({
        'name': name,
        'description': description,
        'timestamp': Timestamp.now()
      }).catchError((onError) {
        throw onError;
      });
    } catch (e) {
      _isError = true;
      print(e);
    }

    return _isError;
  }

  Future<bool> deleteStatus(
      {@required String status, @required String docId}) async {
    bool _isError = false;

    try {
      await firestore
          .collection('status')
          .doc(docId)
          .delete()
          .catchError((onError) {
        throw onError;
      });

      QuerySnapshot snapshotMenu = await firestore
          .collection('menu')
          .where('status', isEqualTo: status)
          .get();

      snapshotMenu.docs.forEach((element) async {
        await firestore.collection('menu').doc(element.id).update({
          'status': '',
        });
      });
    } catch (e) {
      _isError = true;
      print(e);
    }

    return _isError;
  }

  Future<bool> updateStatus(
      {@required String newStatus,
      @required String previousStatus,
      @required String description,
      @required String docId}) async {
    bool _isError = false;

    try {
      await firestore
          .collection('status')
          .doc(docId)
          .update({'name': newStatus, 'description': description}).catchError(
              (onError) {
        throw onError;
      });

      QuerySnapshot snapshotMenu = await firestore
          .collection('menu')
          .where('status', isEqualTo: previousStatus)
          .get();

      snapshotMenu.docs.forEach((element) async {
        await firestore
            .collection('menu')
            .doc(element.id)
            .update({'status': newStatus});
      });
    } catch (e) {
      _isError = true;
      print(e);
    }

    return _isError;
  }

  //SECTION CATEGORY

  Future<bool> createCategory({@required String categoryValue}) async {
    bool _isError = false;

    try {
      await firestore
          .collection('category')
          .add({'name': categoryValue}).catchError((onError) {
        throw onError;
      });
    } catch (e) {
      _isError = true;
      print(e);
    }

    return _isError;
  }

  Future<bool> deleteCategory(
      {@required String category, @required String docId}) async {
    bool _isError = false;

    try {
      await firestore
          .collection('category')
          .doc(docId)
          .delete()
          .catchError((onError) {
        throw onError;
      });

      QuerySnapshot snapshotMenu = await firestore
          .collection('menu')
          .where('category', isEqualTo: category)
          .get();

      snapshotMenu.docs.forEach((element) async {
        await firestore.collection('menu').doc(element.id).update({
          'category': '',
        });
      });
    } catch (e) {
      _isError = true;
      print(e);
    }

    return _isError;
  }

  Future<bool> updateCategory(
      {@required String newCategory,
      @required String previousCategory,
      @required String docId}) async {
    bool _isError = false;

    try {
      await firestore
          .collection('category')
          .doc(docId)
          .update({'name': newCategory}).catchError((onError) {
        throw onError;
      });

      QuerySnapshot snapshotMenu = await firestore
          .collection('menu')
          .where('category', isEqualTo: previousCategory)
          .get();

      snapshotMenu.docs.forEach((element) async {
        await firestore
            .collection('menu')
            .doc(element.id)
            .update({'category': newCategory});
      });
    } catch (e) {
      _isError = true;
      print(e);
    }

    return _isError;
  }

  //Section Menu
  Future<bool> createMenu({
    @required String name,
    @required String description,
    @required int price,
    @required String img,
    @required String status,
    @required String category,
  }) async {
    bool _isError = false;

    try {
      await firestore.collection('menu').add({
        'name': name,
        'description': description,
        'price': price,
        'img': img,
        'status': status,
        'category': category
      }).catchError((onError) {
        throw onError;
      });
    } catch (e) {
      _isError = true;
      print(e);
    }

    return _isError;
  }

  Future<bool> updateMenu({
    @required String docId,
    @required String name,
    @required String description,
    @required int price,
    @required String img,
    @required String status,
    @required String category,
  }) async {
    bool _isError = false;

    try {
      await firestore.collection('menu').doc(docId).update({
        'name': name,
        'description': description,
        'price': price,
        'img': img,
        'status': status,
        'category': category
      }).catchError((onError) {
        throw onError;
      });
    } catch (e) {
      _isError = true;
      print(e);
    }

    return _isError;
  }

  Future<bool> deleteMenu({@required String docId}) async {
    bool _isError = false;

    try {
      await firestore
          .collection('menu')
          .doc(docId)
          .delete()
          .catchError((onError) {
        throw onError;
      });
    } catch (e) {
      _isError = true;
      print(e);
    }

    return _isError;
  }
}
