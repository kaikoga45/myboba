import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:myboba/services/firestore/firestore_data_management_helper.dart';

final _formKey = GlobalKey<FormState>();
final _scaffoldKey = GlobalKey<ScaffoldState>();

class CreateUpdateMenu extends StatefulWidget {
  final DocumentSnapshot _menuDoc;
  CreateUpdateMenu({DocumentSnapshot menuDoc}) : _menuDoc = menuDoc;

  @override
  _CreateUpdateMenuState createState() => _CreateUpdateMenuState();
}

class _CreateUpdateMenuState extends State<CreateUpdateMenu> {
  final _staffFirestoreHelper = FirestoreDataManagementHelper();

  TextEditingController _controllerMenuName = TextEditingController();
  TextEditingController _controllerMenuDescription = TextEditingController();
  TextEditingController _controllerMenuPrice = TextEditingController();
  TextEditingController _controllerMenuImg = TextEditingController();

  String _selectedStatus;
  String _selectedCategory;

  @override
  void initState() {
    super.initState();
    _controllerMenuName.text =
        widget._menuDoc == null ? '' : widget._menuDoc['name'];
    _controllerMenuDescription.text =
        widget._menuDoc == null ? '' : widget._menuDoc['description'];
    _controllerMenuPrice.text =
        widget._menuDoc == null ? '' : widget._menuDoc['price'].toString();
    _controllerMenuImg.text =
        widget._menuDoc == null ? '' : widget._menuDoc['img'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(
          widget._menuDoc == null ? 'CREATE MENU' : 'UPDATE MENU',
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
                controller: _controllerMenuName,
                maxLength: 30,
                decoration: InputDecoration(
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue),
                  ),
                  labelText: 'Name Of Menu',
                ),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _controllerMenuDescription,
                decoration: InputDecoration(
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue),
                  ),
                  labelText: 'Menu Description',
                ),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter some menu description!';
                  }
                  return null;
                },
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                controller: _controllerMenuPrice,
                decoration: InputDecoration(
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue),
                  ),
                  labelText: 'Menu Price',
                ),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter the price!';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _controllerMenuImg,
                decoration: InputDecoration(
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue),
                  ),
                  labelText: 'URL Link Menu Photo',
                ),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter the url link menu photo!';
                  }
                  return null;
                },
              ),
              FutureBuilder<QuerySnapshot>(
                future: FirebaseFirestore.instance.collection('status').get(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return CircularProgressIndicator();
                  } else {
                    List<String> _status = [];

                    snapshot.data.docs.forEach((element) {
                      _status.add(element['name']);
                    });

                    WidgetsBinding.instance
                        .addPostFrameCallback((_) => setState(() {
                              if (_selectedStatus == null) {
                                if (widget._menuDoc == null) {
                                  _selectedStatus = _status.elementAt(0);
                                } else {
                                  _selectedStatus = widget._menuDoc['status'];
                                }
                              }
                            }));

                    return DropdownButton(
                      hint: Text('Please choose menu status'),
                      value: _selectedStatus,
                      isExpanded: true,
                      items: _status.map<DropdownMenuItem<String>>(
                        (String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        },
                      ).toList(),
                      onChanged: (value) {
                        setState(() {
                          _selectedStatus = value;
                        });
                      },
                    );
                  }
                },
              ),
              FutureBuilder<QuerySnapshot>(
                future: FirebaseFirestore.instance.collection('category').get(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return CircularProgressIndicator();
                  } else {
                    List<String> _category = [];

                    snapshot.data.docs.forEach((element) {
                      _category.add(element['name']);
                    });

                    WidgetsBinding.instance
                        .addPostFrameCallback((_) => setState(() {
                              if (_selectedCategory == null) {
                                if (widget._menuDoc == null) {
                                  _selectedCategory = _category.elementAt(0);
                                } else {
                                  _selectedCategory =
                                      widget._menuDoc['category'];
                                }
                              }
                            }));

                    return DropdownButton(
                      hint: Text('Please choose menu category'),
                      value: _selectedCategory,
                      isExpanded: true,
                      items: _category.map<DropdownMenuItem<String>>(
                        (String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        },
                      ).toList(),
                      onChanged: (value) {
                        setState(() {
                          _selectedCategory = value;
                        });
                      },
                    );
                  }
                },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState.validate()) {
                      if (_selectedStatus == null ||
                          _selectedCategory == null) {
                        _scaffoldKey.currentState.showSnackBar(SnackBar(
                            content: Text(_selectedCategory == null
                                ? 'Please select menu category'
                                : 'Please select menu status')));
                      } else {
                        if (widget._menuDoc == null) {
                          bool _isError =
                              await _staffFirestoreHelper.createMenu(
                                  name: _controllerMenuName.text,
                                  description: _controllerMenuDescription.text,
                                  price: int.parse(_controllerMenuPrice.text),
                                  img: _controllerMenuImg.text,
                                  status: _selectedStatus,
                                  category: _selectedCategory);
                          _isError
                              ? _scaffoldKey.currentState.showSnackBar(SnackBar(
                                  content: Text('Failed to added data!')))
                              : _scaffoldKey.currentState.showSnackBar(SnackBar(
                                  content: Text('Data completed added!')));
                        } else {
                          bool _isError =
                              await _staffFirestoreHelper.updateMenu(
                                  docId: widget._menuDoc.id,
                                  name: _controllerMenuName.text,
                                  description: _controllerMenuDescription.text,
                                  price: int.parse(_controllerMenuPrice.text),
                                  img: _controllerMenuImg.text,
                                  status: _selectedStatus,
                                  category: _selectedCategory);
                          _isError
                              ? _scaffoldKey.currentState.showSnackBar(SnackBar(
                                  content: Text('Failed to update data!')))
                              : _scaffoldKey.currentState.showSnackBar(SnackBar(
                                  content: Text('Data completed update!')));
                        }
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
