import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:myboba/services/firestore/order_firestore_helper.dart';
import 'package:myboba/utils/customer/time.dart';
import 'package:qr_flutter/qr_flutter.dart';

class DetailReceipt extends StatelessWidget {
  static const String id = '/detail_receipt';
  final _firestoreApi = OrderFirestoreHelper.firestoreApi;

  final DocumentSnapshot _receipt;

  DetailReceipt({DocumentSnapshot receipt}) : _receipt = receipt;

  @override
  Widget build(BuildContext context) {
    DetailReceipt _data = ModalRoute.of(context).settings.arguments;
    double _totalPriceAfterTax = _data._receipt['total_price'] * 0.05;
    int _newtotalPrice =
        _data._receipt['total_price'] + _totalPriceAfterTax.toInt();

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.close),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'DETAIL RECEIPT ORDER',
          style: Theme.of(context)
              .textTheme
              .headline6
              .copyWith(fontWeight: FontWeight.bold),
        ),
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Expanded(
              flex: 2,
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0xFFF7F6F2),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                ),
                height: 400,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'DETAIL ORDER',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline6
                                  .copyWith(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                            Text(
                              Time.convertToDate(_data._receipt['timestamp']),
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle1
                                  .copyWith(
                                      color: Color(0xFF9D521E), fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Container(
                          height: 250,
                          child: StreamBuilder<QuerySnapshot>(
                            stream: _firestoreApi
                                .collection('order')
                                .where('receipt_id',
                                    isEqualTo: _data._receipt['receipt_id'])
                                .snapshots(),
                            builder: (context, snapshot) {
                              if (!snapshot.hasData) {
                                return Center(
                                    child: CircularProgressIndicator());
                              } else {
                                return ListView.builder(
                                  itemCount: snapshot.data.docs.length,
                                  itemBuilder: (context, index) {
                                    DocumentSnapshot _receiptDetail =
                                        snapshot.data.docs[index];
                                    return Column(
                                      children: [
                                        Container(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          right: 15),
                                                  child: Container(
                                                    child: ClipRRect(
                                                      child: FadeInImage
                                                          .assetNetwork(
                                                        fit: BoxFit.cover,
                                                        height: 40,
                                                        width: 40,
                                                        fadeInCurve:
                                                            Curves.bounceIn,
                                                        placeholder:
                                                            'assets/img/fade_placeholder.png',
                                                        image: _receiptDetail[
                                                            'menuImg'],
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              70),
                                                    ),
                                                    height: 40,
                                                    width: 40,
                                                  ),
                                                ),
                                                Container(
                                                  child: Column(
                                                    children: [
                                                      Text(
                                                        _receiptDetail[
                                                            'menu_name'],
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .subtitle1
                                                            .copyWith(
                                                                fontSize: 16.0,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                      ),
                                                      Text(
                                                        _receiptDetail[
                                                            'description'],
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .caption,
                                                        maxLines: 10,
                                                      ),
                                                      Text(
                                                        'Rp ${_receiptDetail['total_price']}',
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .caption
                                                            .copyWith(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              color: Theme.of(
                                                                      context)
                                                                  .accentColor,
                                                            ),
                                                      ),
                                                    ],
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                  ),
                                                  width: 210,
                                                ),
                                                Spacer(),
                                                Column(
                                                  children: [
                                                    SizedBox(height: 50),
                                                    Container(
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                left: 3,
                                                                right: 3),
                                                        child: Text(
                                                          '${_receiptDetail['quantity']}x',
                                                          style:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .subtitle2
                                                                  .copyWith(
                                                                    color: Color(
                                                                        0xFF621C0D),
                                                                  ),
                                                        ),
                                                      ),
                                                      decoration: BoxDecoration(
                                                        color:
                                                            Color(0xFFEDE2CF),
                                                        borderRadius:
                                                            BorderRadius.all(
                                                          Radius.circular(5),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Divider(
                                          color: Theme.of(context).buttonColor,
                                          height: 0.5,
                                        ),
                                      ],
                                    );
                                  },
                                );
                              }
                            },
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 0,
                        child: Container(
                          height: 60,
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Order'),
                                  Text(
                                    'Rp ${_data._receipt['total_price']}',
                                    style: TextStyle(color: Color(0xFF9D521E)),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Tax'),
                                  Text(
                                    '5%',
                                    style: TextStyle(
                                      color: Color(0xFF9D521E),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Total'),
                                  Text(
                                    'Rp $_newtotalPrice',
                                    style: TextStyle(
                                      color: Color(0xFF9D521E),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Divider(
              color: Theme.of(context).buttonColor,
              height: 0,
              thickness: 1.0,
            ),
            Expanded(
              flex: 0,
              child: Container(
                child: StreamBuilder<DocumentSnapshot>(
                  stream: _firestoreApi
                      .collection('receipt')
                      .doc(_data._receipt.id)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Center(child: CircularProgressIndicator());
                    } else {
                      if (!snapshot.data['pickup']) {
                        return Container(
                          height: 161,
                          decoration: BoxDecoration(
                            color: Color(0xFfFAFAFA),
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(10),
                              bottomRight: Radius.circular(10),
                            ),
                          ),
                          padding: EdgeInsets.all(20),
                          child: Row(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 30),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Transaction Code',
                                      style: Theme.of(context)
                                          .textTheme
                                          .caption
                                          .copyWith(
                                              color:
                                                  Theme.of(context).accentColor,
                                              fontWeight: FontWeight.bold),
                                    ),
                                    Spacer(),
                                    Text(
                                      '${_data._receipt['receipt_id']}',
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline6
                                          .copyWith(
                                            color: Color(0xFF026242),
                                            fontSize: 20,
                                          ),
                                    )
                                  ],
                                ),
                              ),
                              Spacer(),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'QR Code',
                                    style: Theme.of(context)
                                        .textTheme
                                        .caption
                                        .copyWith(
                                            color:
                                                Theme.of(context).accentColor,
                                            fontWeight: FontWeight.bold),
                                  ),
                                  QrImage(
                                    data: '${_data._receipt['receipt_id']}',
                                    size: 100,
                                  )
                                ],
                              ),
                            ],
                          ),
                        );
                      } else {
                        return Container();
                      }
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
