import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:myboba/utils/list_title.dart';

class SeeAllMenu extends StatelessWidget {
  static const String id = '/see_all_menu';

  final QuerySnapshot _menu;
  final String _category;

  SeeAllMenu({QuerySnapshot menu, String category})
      : _menu = menu,
        _category = category;

  @override
  Widget build(BuildContext context) {
    final SeeAllMenu _data = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _data._category.toUpperCase(),
          style: Theme.of(context)
              .textTheme
              .headline6
              .copyWith(fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
          padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(20),
                child: Text(
                  shortMessageEachCategory[_data._category].toUpperCase(),
                  style: Theme.of(context)
                      .textTheme
                      .subtitle1
                      .copyWith(fontSize: 16.0, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
              Expanded(
                child: GridView.builder(
                  padding: EdgeInsets.only(bottom: 30.0),
                  itemCount: _data._menu.docs.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 10.0,
                      childAspectRatio: 0.9),
                  itemBuilder: (context, index) {
                    final DocumentSnapshot _menus = _data._menu.docs[index];
                    return Container(
                      child: Column(
                        children: [
                          Container(
                            child: ClipRRect(
                              child: FadeInImage.assetNetwork(
                                fit: BoxFit.cover,
                                height: 140,
                                width: 140,
                                fadeInCurve: Curves.bounceIn,
                                placeholder: 'assets/img/fade_placeholder.png',
                                image: _menus['img'],
                              ),
                              borderRadius: BorderRadius.circular(70),
                            ),
                            height: 140,
                            width: 140,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            _menus['name'],
                            textAlign: TextAlign.center,
                            style: Theme.of(context)
                                .textTheme
                                .subtitle2
                                .copyWith(color: Color(0xFF026242)),
                          ),
                          Text(
                            'Rp ${_menus['price']}',
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.subtitle2,
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          )),
    );
  }
}
