import 'package:flutter/material.dart';
import 'package:myboba/ui/customer/theme/color_palettes.dart';

class CircularIconButton extends StatelessWidget {
  final Icon _icon;
  final Function _onTap;

  CircularIconButton({required Icon icon, required Function onTap})
      : _icon = icon,
        _onTap = onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        child: _icon,
        decoration: BoxDecoration(
          color: ColorPalettes.button,
          borderRadius: BorderRadius.all(Radius.circular(25)),
        ),
      ),
      onTap: _onTap as void Function()?,
    );
  }
}
