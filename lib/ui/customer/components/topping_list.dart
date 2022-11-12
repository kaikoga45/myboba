import 'package:flutter/material.dart';
import 'package:myboba/ui/customer/components/circular_icon_button.dart';

import '../theme/color_palettes.dart';

class ToppingList extends StatelessWidget {
  final String _title;
  final int _value;
  final Function _onTapMinus;
  final Function _onTapPlus;

  ToppingList(
      {@required String title,
      @required int value,
      @required Function onTapMinus,
      @required Function onTapPlus})
      : _title = title,
        _value = value,
        _onTapMinus = onTapMinus,
        _onTapPlus = onTapPlus;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                _title,
                style: Theme.of(context).textTheme.subtitle1,
              ),
              Row(
                children: [
                  CircularIconButton(
                    icon: Icon(
                      Icons.remove,
                      size: 20,
                      color: Colors.white,
                    ),
                    onTap: _onTapMinus,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 6),
                    child: Text(
                      '$_value',
                      style: TextStyle(
                          color: ColorPalettes.button,
                          decoration: TextDecoration.underline),
                    ),
                  ),
                  CircularIconButton(
                    icon: Icon(
                      Icons.add,
                      size: 20,
                      color: Colors.white,
                    ),
                    onTap: _onTapPlus,
                  ),
                ],
              ),
            ],
          ),
          Divider(color: Color(0xFFC99543)),
          SizedBox(
            height: 8,
          ),
        ],
      ),
    );
  }
}
