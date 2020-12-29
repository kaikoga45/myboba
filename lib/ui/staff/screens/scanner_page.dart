import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:myboba/utils/staff/receipt_helper.dart';

class ScannerPage extends StatefulWidget {
  static const String id = '/scanner_page';

  @override
  _ScannerPageState createState() => _ScannerPageState();
}

class _ScannerPageState extends State<ScannerPage> {
  bool isScan = false;
  int receiptId = 0;

  final _firestore = FirebaseFirestore.instance;
  final _receiptHelper = ReceiptHelper.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'SCAN ORDER',
          style: Theme.of(context).textTheme.headline6.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment:
              isScan ? MainAxisAlignment.start : MainAxisAlignment.center,
          children: [
            isScan
                ? Column(
                    children: [
                      Container(
                        height: 490,
                        child: StreamBuilder<QuerySnapshot>(
                          stream: _firestore
                              .collection('order')
                              .where('receipt_id', isEqualTo: receiptId)
                              .where('pickup', isEqualTo: true)
                              .where('checkout', isEqualTo: true)
                              .snapshots(),
                          builder: (context, snapshot) {
                            if (!snapshot.hasData) {
                              return Center(child: CircularProgressIndicator());
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
                                                padding: const EdgeInsets.only(
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
                                                                FontWeight.w400,
                                                            color: Theme.of(
                                                                    context)
                                                                .accentColor,
                                                          ),
                                                    ),
                                                  ],
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
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
                                                          const EdgeInsets.only(
                                                              left: 3,
                                                              right: 3),
                                                      child: Text(
                                                        '${_receiptDetail['quantity']}x',
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .subtitle2
                                                            .copyWith(
                                                              color: Color(
                                                                  0xFF621C0D),
                                                            ),
                                                      ),
                                                    ),
                                                    decoration: BoxDecoration(
                                                      color: Color(0xFFEDE2CF),
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
                      SizedBox(height: 50),
                      GestureDetector(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Theme.of(context).buttonColor,
                            borderRadius: BorderRadius.circular(25),
                          ),
                          height: 50,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Center(
                                  child: Text(
                                'SERVE COMPLETED',
                                style: Theme.of(context).textTheme.button,
                              )),
                            ],
                          ),
                        ),
                        onTap: () async {
                          await _receiptHelper.setServe(receiptId);
                          setState(() {
                            isScan = false;
                          });
                        },
                      ),
                    ],
                  )
                : Container(
                    child: Center(
                      child: Column(
                        children: [
                          Icon(
                            Icons.camera_alt_outlined,
                            size: 70,
                          ),
                          RaisedButton(
                            onPressed: () async {
                              String barcodeScanRes =
                                  await FlutterBarcodeScanner.scanBarcode(
                                '#ff6666',
                                'CANCEL',
                                false,
                                ScanMode.DEFAULT,
                              );

                              bool _isError = await _receiptHelper
                                  .setPickup(int.parse(barcodeScanRes));

                              if (_isError) {
                                Scaffold.of(context).showSnackBar(
                                  SnackBar(
                                    content:
                                        Text('Failed to get receipt data!'),
                                  ),
                                );
                              } else {
                                setState(() {
                                  receiptId = int.parse(barcodeScanRes);
                                  isScan = !isScan;
                                });
                                Scaffold.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                        'Receipt data has been successfully scan!'),
                                  ),
                                );
                              }
                            },
                            child: Text(
                              'SCAN QR CODE',
                              style: Theme.of(context).textTheme.button,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
