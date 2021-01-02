import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:myboba/services/firebase/firestore_data_management_helper.dart';

final _formKey = GlobalKey<FormState>();
final _scaffoldKey = GlobalKey<ScaffoldState>();

class CreateUpdateStatus extends StatefulWidget {
  final DocumentSnapshot _statusDoc;
  CreateUpdateStatus({DocumentSnapshot statusDoc}) : _statusDoc = statusDoc;

  @override
  _CreateUpdateStatusState createState() => _CreateUpdateStatusState();
}

class _CreateUpdateStatusState extends State<CreateUpdateStatus> {
  final _staffFirestoreHelper = FirestoreDataManagementHelper.instance;
  TextEditingController _controllerName = TextEditingController();
  TextEditingController _controllerDescription = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _controllerName.text =
        widget._statusDoc == null ? '' : widget._statusDoc['name'];
    _controllerDescription.text =
        widget._statusDoc == null ? '' : widget._statusDoc['description'];

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(
          widget._statusDoc == null ? 'CREATE STATUS' : 'UPDATE STATUS',
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
                controller: _controllerName,
                maxLength: 25,
                decoration: InputDecoration(
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue),
                  ),
                  labelText: 'Name Of Status',
                ),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _controllerDescription,
                decoration: InputDecoration(
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue),
                  ),
                  labelText: 'Status description',
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
                      if (widget._statusDoc == null) {
                        bool _isError =
                            await _staffFirestoreHelper.createStatus(
                                name: _controllerName.text,
                                description: _controllerDescription.text);

                        _isError
                            ? _scaffoldKey.currentState.showSnackBar(SnackBar(
                                content: Text('Failed to added data!')))
                            : _scaffoldKey.currentState.showSnackBar(SnackBar(
                                content: Text('Data completed added!')));

                        _controllerName.clear();
                        _controllerDescription.clear();
                      } else {
                        bool _isError =
                            await _staffFirestoreHelper.updateStatus(
                                docId: widget._statusDoc.id,
                                previousStatus: widget._statusDoc['name'],
                                newStatus: _controllerName.text,
                                description: _controllerDescription.text);
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
