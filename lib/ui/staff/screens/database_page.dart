import 'package:flutter/material.dart';
import 'package:myboba/services/firebase_authentication/authentication.dart';
import 'package:myboba/ui/staff/components/stream_collection.dart';
import 'package:myboba/ui/staff/screens/category_page/read_category.dart';
import 'package:myboba/ui/staff/screens/menu_page/read_menu.dart';
import 'package:myboba/ui/staff/screens/order_page/read_order.dart';
import 'package:myboba/ui/staff/screens/status_page/read_status.dart';

class DatabasePage extends StatelessWidget {
  static const String id = '/database_page';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'DATABASE',
          style: Theme.of(context).textTheme.headline6!.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: StreamCollection(
                  isOrder: false,
                  collection: 'status',
                  title: 'status',
                  color: Color(0xFFF8B195),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ReadStatus(),
                      ),
                    );
                  },
                ),
              ),
              Expanded(
                child: StreamCollection(
                  isOrder: false,
                  collection: 'category',
                  title: 'category',
                  color: Color(0xFFF67280),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ReadCategory(),
                      ),
                    );
                  },
                ),
              ),
              Expanded(
                child: StreamCollection(
                  isOrder: false,
                  collection: 'menu',
                  title: 'menu',
                  color: Color(0xFFC06C84),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ReadMenu(),
                      ),
                    );
                  },
                ),
              ),
              Expanded(
                child: StreamCollection(
                  isOrder: true,
                  collection: 'order',
                  title: 'order',
                  color: Color(0xFF6C5B7B),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ReadOrder(),
                      ),
                    );
                  },
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  AuthHelper.auth.signOut();
                },
                child: Text(
                  'LOGOUT',
                  style: Theme.of(context).textTheme.button,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
