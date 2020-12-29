import 'package:flutter/material.dart';

class CircularIconButton extends StatelessWidget {
  final Icon _icon;
  final Function _onTap;

  CircularIconButton({@required Icon icon, @required Function onTap})
      : _icon = icon,
        _onTap = onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        child: _icon,
        decoration: BoxDecoration(
          color: Theme.of(context).buttonColor,
          borderRadius: BorderRadius.all(Radius.circular(25)),
        ),
      ),
      onTap: _onTap,
    );
  }
}
