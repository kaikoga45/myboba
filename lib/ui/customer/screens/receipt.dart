import 'package:flutter/material.dart';
import 'package:myboba/ui/customer/components/stream_receipt.dart';

import '../theme/color_palettes.dart';

class Receipt extends StatelessWidget {
  static const String id = '/receipt';

  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          elevation: 0,
          bottom: TabBar(
            indicatorColor: ColorPalettes.golderBrown,
            indicatorWeight: 5.0,
            tabs: [
              Tab(
                child: Text('ACTIVE ORDER',
                    style: Theme.of(context)
                        .textTheme
                        .subtitle2
                        .copyWith(fontSize: 14, fontWeight: FontWeight.w400)),
              ),
              Tab(
                child: Text('LIST TRANSACTION',
                    style: Theme.of(context)
                        .textTheme
                        .subtitle2
                        .copyWith(fontSize: 14, fontWeight: FontWeight.w400)),
              ),
            ],
          ),
          title: Text(
            'RECEIPT ORDER',
            style: Theme.of(context)
                .textTheme
                .headline6
                .copyWith(fontWeight: FontWeight.bold),
          ),
        ),
        body: TabBarView(
          children: [
            StreamReceipt(
              isPickup: false,
            ),
            StreamReceipt(
              isPickup: true,
            ),
          ],
        ),
      ),
    );
  }
}
