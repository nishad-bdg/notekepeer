import 'package:flutter/material.dart';

class NoteDetail extends StatefulWidget {
  String appBarTitle;
  NoteDetail(this.appBarTitle);
  @override
  _NoteDetailState createState() => _NoteDetailState(this.appBarTitle);
}

class _NoteDetailState extends State<NoteDetail> {
  String appBarTitle;

  var _formKey = GlobalKey<FormState>();

  var _options = ["High", "Low"];
  var _currentOption = '';

  void initState() {
    super.initState();
    _currentOption = _options[0];
  }

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  _NoteDetailState(this.appBarTitle);
  @override
  Widget build(BuildContext context) {
    //TextStyle textStyle = Theme.of(context).textTheme.title;

    return WillPopScope(
      onWillPop: () {
        moveToLastScreen();
      },
      child: Scaffold(
          appBar: AppBar(
            title: Text(appBarTitle),
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
              onPressed: () {
                moveToLastScreen();
              },
            ),
          ),
          body: Form(
            key: _formKey,
            child: ListView(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: DropdownButton<String>(
                          items: _options.map((String value) {
                            return DropdownMenuItem(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          value: _currentOption,
                          onChanged: (String newSelectedValue) {
                            setState(() {
                              _currentOption = newSelectedValue;
                            });
                          },
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          controller: titleController,
                          validator: (String value) {
                            if (value.isEmpty) {
                              return 'Please enter title';
                            }
                          },
                          decoration: InputDecoration(
                              labelText: 'Title',
                              hintText: 'Enter Title',
                              errorStyle: TextStyle(fontSize: 15.0),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5.0))),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          controller: descriptionController,
                          validator: (String value) {
                            if (value.isEmpty) {
                              return "Please enter description";
                            }
                          },
                          decoration: InputDecoration(
                              labelText: 'Description',
                              hintText: 'Enter Description',
                              errorStyle: TextStyle(fontSize: 15.0),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5.0))),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(5.0),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: RaisedButton(
                                color: Colors.deepPurple,
                                child: Text(
                                  "Save",
                                  style: TextStyle(color: Colors.white),
                                ),
                                onPressed: () {
                                  setState(() {
                                    if (_formKey.currentState.validate()) {
                                      print("Error in form");
                                    }
                                  });
                                },
                              ),
                            ),
                            Container(width: 10.0),
                            Expanded(
                              child: RaisedButton(
                                color: Colors.deepPurple,
                                child: Text("Delete",
                                    style: TextStyle(color: Colors.white)),
                                onPressed: () {
                                  setState(() {
                                    _reset();
                                  });
                                },
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          )),
    );
  }

  void _reset() {
    titleController.text = "";
    descriptionController.text = "";
    _currentOption = _options[0];
  }

   void moveToLastScreen(){
     Navigator.pop(context);
   }
}
