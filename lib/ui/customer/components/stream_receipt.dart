import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:myboba/services/firebase_authentication/authentication.dart';
import 'package:myboba/services/firestore/order_firestore_helper.dart';
import 'package:myboba/ui/customer/screens/detail_receipt.dart';
import 'package:myboba/utils/customer/time.dart';

class StreamReceipt extends StatelessWidget {
  final _firestore = OrderFirestoreHelper.firestoreApi;
  final _authHelper = AuthHelper.instance;

  final bool? _isPickup;

  StreamReceipt({bool? isPickup, bool? isActiveOrder}) : _isPickup = isPickup;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore
          .collection('receipt')
          .where('customer_id', isEqualTo: _authHelper.getUserID())
          .where('pickup', isEqualTo: _isPickup)
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        } else {
          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              DocumentSnapshot _receipt = snapshot.data!.docs[index];
              double _totalPriceAfterTax = _receipt['total_price'] * 0.05;
              int? _newtotalPrice =
                  _receipt['total_price'] + _totalPriceAfterTax.toInt();
              return Padding(
                padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
                child: GestureDetector(
                  child: Container(
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Color(0xFFF7F6F2),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: Container(
                            child: Center(
                                child: Text(
                              '${index + 1}',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline4!
                                  .copyWith(
                                      fontSize: 40, color: Color(0xFf9D521E)),
                            )),
                            height: 80,
                            width: 80,
                            decoration: BoxDecoration(
                              color: Color(0xFFFAFAFA),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                        Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                Time.convertToDate(
                                  _receipt['timestamp'],
                                ),
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle1!
                                    .copyWith(
                                        color: Color(0xFF9D521E), fontSize: 16),
                              ),
                              Text(
                                'Total Rp $_newtotalPrice',
                                style: Theme.of(context)
                                    .textTheme
                                    .caption!
                                    .copyWith(color: Color(0xFF9D521E)),
                              ),
                            ],
                          ),
                        ),
                        Spacer(),
                        Container(
                          height: 80,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                _receipt['pickup'] ? 'Completed' : 'Need Scan',
                                style: Theme.of(context)
                                    .textTheme
                                    .caption!
                                    .copyWith(
                                      color: Color(0xFF026242),
                                    ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      DetailReceipt.id,
                      arguments: DetailReceipt(receipt: _receipt),
                    );
                  },
                ),
              );
            },
          );
        }
      },
    );
  }
}
