import 'package:flutter/material.dart';
import 'package:gird/garden.dart';

class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  List<String> trees = ['mango', 'apple','orange'];
  List<String> selectedtree = [];
  final _loginForm = GlobalKey<FormState>();
  TextEditingController _userName = TextEditingController();
  TextEditingController _password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text(
              'Select Trees',
              style: TextStyle(color: Colors.green, fontSize: 35),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                selectedtree.length.toString(),
                style: TextStyle(color: Colors.green, fontSize: 35),
              ),
            ),
            Expanded(
              flex: 1,
              //height: 300,
              child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: trees.length,
                  itemBuilder: (BuildContext ctxt, int index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              selectedtree.add(trees[index]);
                            });
                          },
                          child: Text(trees[index])),
                    );
                  }),
            ),
            Form(
              key: _loginForm,
              child: Column(
                children: [
                  TFFxM(_userName, 'width'),
                  TFFxM(_password, 'length'),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      onPressed: () {
                        if (_loginForm.currentState.validate()) {
                          double r=int.parse(_userName.text) /7;
                          print(_userName.text);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => Garden(
                                      selectedtree,
                                     r.toInt(),
                                      2)));
                        } else {}
                      },
                      child: Text('See Garden'),
                    ),
                  ),
                ],
              ),
            )
          ]),
        ),
      ),
    );
  }
}

class TFFxM extends StatelessWidget {
  TFFxM(this._userName, this.imptyText);

  final TextEditingController _userName;
  final String imptyText;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextFormField(
          controller: _userName,
          validator: (value) {
            if (value.isEmpty) {
              return '$imptyText can not be empty';
            }

            return null;
          },
       keyboardType: TextInputType.number,
          decoration: new InputDecoration(
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white, width: 0.0),
                borderRadius: BorderRadius.circular(10)),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey[200], width: 0.0),
                borderRadius: BorderRadius.circular(10)),
            errorBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.red[300], width: 0.0),
                borderRadius: BorderRadius.circular(10)),
            focusedErrorBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.red[300], width: 0.0),
                borderRadius: BorderRadius.circular(10)),
            filled: true,
            
            border: InputBorder.none,
            hintText: imptyText,
          
          ),
        ),
      ),
    );
  }
}
