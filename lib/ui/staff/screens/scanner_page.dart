import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:myboba/services/firestore/scanner_helper.dart';
import 'package:myboba/ui/customer/theme/color_palettes.dart';

final _formKey = GlobalKey<FormState>();
bool _isProgress = false;

class ScannerPage extends StatefulWidget {
  static const String id = '/scanner_page';

  @override
  _ScannerPageState createState() => _ScannerPageState();
}

class _ScannerPageState extends State<ScannerPage> {
  String _name;
  bool _isScan = false;
  int _receiptId = 0;
  TextEditingController _controller = TextEditingController();

  final _firestoreApi = FirebaseFirestore.instance;
  final _scannerHelper = ScannerHelper();

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: _isProgress,
      child: Scaffold(
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
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _isScan
                  ? Expanded(
                      child: Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Card(
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Text(
                                        'Name : $_name',
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline6
                                            .copyWith(
                                                fontSize: 16.0,
                                                fontWeight: FontWeight.bold),
                                        textAlign: TextAlign.start,
                                      ),
                                    ),
                                    color: Color(0xFFFAFAFA),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 5),
                            Expanded(
                              child: Container(
                                height: 200,
                                child: StreamBuilder<QuerySnapshot>(
                                  stream: _firestoreApi
                                      .collection('order')
                                      .where('receipt_id',
                                          isEqualTo: _receiptId)
                                      .where('pickup', isEqualTo: true)
                                      .where('checkout', isEqualTo: true)
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
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                right: 15),
                                                        child: Container(
                                                          child: ClipRRect(
                                                            child: FadeInImage
                                                                .assetNetwork(
                                                              fit: BoxFit.cover,
                                                              height: 40,
                                                              width: 40,
                                                              fadeInCurve:
                                                                  Curves
                                                                      .bounceIn,
                                                              placeholder:
                                                                  'assets/img/fade_placeholder.png',
                                                              image:
                                                                  _receiptDetail[
                                                                      'menuImg'],
                                                            ),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
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
                                                              style: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .subtitle1
                                                                  .copyWith(
                                                                      fontSize:
                                                                          16.0,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold),
                                                            ),
                                                            Text(
                                                              _receiptDetail[
                                                                  'description'],
                                                              style: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .caption,
                                                              maxLines: 10,
                                                            ),
                                                            Text(
                                                              'Rp ${_receiptDetail['total_price']}',
                                                              style: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .caption
                                                                  .copyWith(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400,
                                                                    color: ColorPalettes
                                                                        .button,
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
                                                                style: Theme.of(
                                                                        context)
                                                                    .textTheme
                                                                    .subtitle2
                                                                    .copyWith(
                                                                      color: Color(
                                                                          0xFF621C0D),
                                                                    ),
                                                              ),
                                                            ),
                                                            decoration:
                                                                BoxDecoration(
                                                              color: Color(
                                                                  0xFFEDE2CF),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .all(
                                                                Radius.circular(
                                                                    5),
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
                                                color: ColorPalettes.button,
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
                            SizedBox(height: 50),
                            GestureDetector(
                              child: Container(
                                decoration: BoxDecoration(
                                  color: ColorPalettes.button,
                                  borderRadius: BorderRadius.circular(25),
                                ),
                                height: 50,
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
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
                                await _scannerHelper.setServe(_receiptId);
                                setState(() {
                                  _isScan = false;
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                    )
                  : Container(
                      child: Center(
                        child: Column(
                          children: [
                            Icon(
                              Icons.camera_alt_outlined,
                              size: 70,
                            ),
                            ElevatedButton(
                              onPressed: () async {
                                setState(() {
                                  _isProgress = !_isProgress;
                                });

                                String barcodeScanRes =
                                    await FlutterBarcodeScanner.scanBarcode(
                                  '#ff6666',
                                  'CANCEL',
                                  false,
                                  ScanMode.DEFAULT,
                                );

                                bool _isError = await _scannerHelper
                                    .setPickup(int.parse(barcodeScanRes));

                                String _dataName = await _scannerHelper
                                    .getCustomerName(int.parse(barcodeScanRes));

                                if (_isError) {
                                  setState(() {
                                    _isProgress = !_isProgress;
                                  });
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content:
                                          Text('Failed to get receipt data!'),
                                    ),
                                  );
                                } else {
                                  setState(() {
                                    _isProgress = !_isProgress;
                                    _name = _dataName;
                                    _receiptId = int.parse(barcodeScanRes);
                                    _isScan = !_isScan;
                                  });
                                  ScaffoldMessenger.of(context).showSnackBar(
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
                            ),
                            Text('OR'),
                            Form(
                              key: _formKey,
                              child: Container(
                                width: 145,
                                child: TextFormField(
                                  controller: _controller,
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.blue),
                                    ),
                                    labelText: 'Enter code order',
                                  ),
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return 'Please input code';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () async {
                                setState(() {
                                  _isProgress = !_isProgress;
                                });

                                if (_formKey.currentState.validate()) {
                                  bool _isError = await _scannerHelper
                                      .setPickup(int.parse(_controller.text));

                                  String _dataName =
                                      await _scannerHelper.getCustomerName(
                                          int.parse(_controller.text));

                                  if (_isError) {
                                    setState(() {
                                      _isProgress = !_isProgress;
                                    });
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content:
                                            Text('Failed to get receipt data!'),
                                      ),
                                    );
                                  } else {
                                    setState(() {
                                      _isProgress = !_isProgress;
                                      _name = _dataName;
                                      _receiptId = int.parse(_controller.text);
                                      _isScan = !_isScan;
                                      _controller.clear();
                                    });
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                            'Receipt data has been successfully scan!'),
                                      ),
                                    );
                                  }
                                }
                              },
                              child: Text(
                                'SUBMIT',
                                style: Theme.of(context).textTheme.button,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
