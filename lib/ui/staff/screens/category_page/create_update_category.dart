import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:myboba/services/firebase/firestore_data_management_helper.dart';

final _formKey = GlobalKey<FormState>();
final _scaffoldKey = GlobalKey<ScaffoldState>();

class CreateUpdateCategory extends StatefulWidget {
  final DocumentSnapshot _categoryDoc;
  CreateUpdateCategory({DocumentSnapshot categoryDoc})
      : _categoryDoc = categoryDoc;

  @override
  _CreateUpdateCategoryState createState() => _CreateUpdateCategoryState();
}

class _CreateUpdateCategoryState extends State<CreateUpdateCategory> {
  final _staffFirestoreHelper = FirestoreDataManagementHelper.instance;
  TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _controller.text =
        widget._categoryDoc == null ? '' : widget._categoryDoc['name'];

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(
          widget._categoryDoc == null ? 'CREATE CATEGORY' : 'UPDATE CATEGORY',
          style: Theme.of(context).textTheme.headline6.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: _controller,
                maxLength: 20,
                decoration: InputDecoration(
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue),
                  ),
                  labelText: 'Name Of Category',
                ),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState.validate()) {
                      if (widget._categoryDoc == null) {
                        bool _isError = await _staffFirestoreHelper
                            .createCategory(categoryValue: _controller.text);
                        _isError
                            ? _scaffoldKey.currentState.showSnackBar(SnackBar(
                                content: Text('Failed to added data!')))
                            : _scaffoldKey.currentState.showSnackBar(SnackBar(
                                content: Text('Data completed added!')));
                        _controller.clear();
                      } else {
                        bool _isError =
                            await _staffFirestoreHelper.updateCategory(
                                docId: widget._categoryDoc.id,
                                previousCategory: widget._categoryDoc['name'],
                                newCategory: _controller.text);
                        _isError
                            ? _scaffoldKey.currentState.showSnackBar(SnackBar(
                                content: Text('Failed to update data!')))
                            : _scaffoldKey.currentState.showSnackBar(SnackBar(
                                content: Text('Data completed update!')));
                      }
                    }
                  },
                  child: Text('Submit'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
