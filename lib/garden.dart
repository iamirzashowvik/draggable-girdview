import 'dart:math';

import 'package:drag_and_drop_gridview/devdrag.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Garden extends StatefulWidget {
  List<String> p;
  int x;
  int y;
  Garden(this.p, this.x, this.y);
  @override
  _GardenState createState() => _GardenState();
}

class _GardenState extends State<Garden> {
  List<String> _imageUris = [];
  double width;
  double height; bool visible;
  int variableSet = 0;
  ScrollController _scrollController;
  @override
  void initState() {
    _imageUris = widget.p;
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(),
        body: Center(
          child: DragAndDropGridView(
            controller: _scrollController,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: widget.x,
              childAspectRatio: 3 / 4.5,
            ),
            padding: EdgeInsets.all(20),
            itemBuilder: (context, index) => Card(
              elevation: 2,
              child: LayoutBuilder(
                builder: (context, costrains) {
                  if (variableSet == 0) {
                    height = costrains.maxHeight;
                    width = costrains.maxWidth;
                    variableSet++;
                  }
                  return GestureDetector(
                    onTap: () {
                      showDialog(
                          builder: (context) => new CupertinoAlertDialog(
                                title: new Column(
                                  children: <Widget>[
                                    new Text("Tree"),
                                    new Icon(
                                      Icons.favorite,
                                      color: Colors.red,
                                    )
                                  ],
                                ),
                                content: new Text(_imageUris[index]),
                                actions: <Widget>[
                                  new TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: new Text("Ok"))
                                ],
                              ),
                          barrierDismissible: false,
                          context: context);
                    },
                    onDoubleTap: () => setState(() {
            _imageUris[index]='';
          }),
                    child: GridTile(
                        child: Container(
                            //color: Color((Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0),

                            child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                      _imageUris[index],//style: TextStyle(fontSize: 5),
                    ),
                                )))
                        // Image.network(
                        //   _imageUris[index],
                        //   fit: BoxFit.cover,
                        //   height: height,
                        //   width: width,
                        // ),
                        ),
                  );
                },
              ),
            ),
            itemCount: _imageUris.length,
            onWillAccept: (oldIndex, newIndex) {
              // Implement you own logic

              // Example reject the reorder if the moving item's value is something specific
              if (_imageUris[newIndex] == "something") {
                return false;
              }
              return true; // If you want to accept the child return true or else return false
            },
            onReorder: (oldIndex, newIndex) {
              final temp = _imageUris[oldIndex];
              _imageUris[oldIndex] = _imageUris[newIndex];
              _imageUris[newIndex] = temp;

              setState(() {});
            },
          ),
        ),
      ),
    );
  }
}
