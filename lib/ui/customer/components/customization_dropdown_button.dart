import 'package:flutter/material.dart';

import '../theme/color_palettes.dart';

class CustomizationDropdownButton extends StatelessWidget {
  final String _title;
  final String _value;
  final List<DropdownMenuItem<Object>> _items;
  final Function _onChanged;

  CustomizationDropdownButton(
      {@required String title,
      @required String value,
      @required List<DropdownMenuItem<Object>> items,
      @required Function onChanged})
      : _title = title,
        _value = value,
        _items = items,
        _onChanged = onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              _title,
              style: Theme.of(context).textTheme.subtitle1,
            ),
            Spacer(),
            DropdownButtonHideUnderline(
              child: DropdownButton(
                  style: Theme.of(context)
                      .textTheme
                      .subtitle1
                      .copyWith(color: ColorPalettes.button),
                  isDense: true,
                  elevation: 0,
                  dropdownColor: Color(0xFFEDE2CF),
                  icon: Icon(Icons.arrow_forward_ios,
                      color: ColorPalettes.button),
                  iconSize: 15,
                  value: _value,
                  items: _items,
                  onChanged: _onChanged),
            ),
          ],
        ),
        Divider(color: Color(0xFFC99543)),
      ],
    );
  }
}
