import 'package:flutter/material.dart';

class InputField extends StatefulWidget {
  final bool obscureText;
  final String hintText;
  final IconData icon;
  final ValueChanged<String> onChanged;
  final FormFieldSetter<String> onSaved;
  final FormFieldValidator<String> validator;

  InputField({
    Key key,
    this.obscureText,
    this.hintText,
    this.icon,
    this.onChanged,
    this.onSaved,
    this.validator,
  }) : super(key: key);

  @override
  _InputFieldState createState() => _InputFieldState(
        obscureText: obscureText,
        hintText: hintText,
        icon: icon,
        onChanged: onChanged,
        onSaved: onSaved,
        validator: validator,
      );
}

class _InputFieldState extends State<InputField> {
  final bool obscureText;
  final String hintText;
  final IconData icon;
  final ValueChanged<String> onChanged;
  final FormFieldSetter<String> onSaved;
  final FormFieldValidator<String> validator;

  _InputFieldState({
    this.obscureText,
    this.hintText,
    this.icon,
    this.onChanged,
    this.onSaved,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 12),
        child: TextFormField(
          keyboardType: TextInputType.emailAddress,
          obscureText: (obscureText == null || !obscureText) ? false : true,
          decoration: InputDecoration(
            filled: true,
            fillColor: Color(0xFFFAFAFA),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(100),
              borderSide: BorderSide.none,
            ),
            prefixIcon: Padding(
              padding: EdgeInsets.only(right: 20, left: 10),
              child: Icon(
                icon,
                color: Color(0xFFC99542),
                size: 40,
              ),
            ),
            hintText: hintText,
            hintStyle: TextStyle(
              color: Colors.grey,
              fontWeight: FontWeight.w700,
            ),
          ),
          style: TextStyle(
            color: Color(0xFF757575),
            fontWeight: FontWeight.w700,
          ),
          onChanged: onChanged,
          onSaved: onSaved,
          //controller: ,
          validator: validator,
        ),
      ),
    );
  }
}
