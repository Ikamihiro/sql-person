import 'package:flutter/material.dart';

class CustomListTile extends StatefulWidget {
  final String title;
  final String subtitle;
  final bool longPressEnabled;
  final VoidCallback callback;

  CustomListTile(
      {Key key,
      this.title,
      this.subtitle,
      this.longPressEnabled,
      this.callback})
      : super(key: key);

  @override
  _CustomListTileState createState() => _CustomListTileState();
}

class _CustomListTileState extends State<CustomListTile> {
  bool selected = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () {
        setState(() {
          selected = !selected;
        });
        widget.callback();
      },
      onTap: () {
        if (widget.longPressEnabled) {
          setState(() {
            selected = !selected;
          });
          widget.callback();
        }
      },
      child: Container(
        margin: EdgeInsets.all(5.0),
        child: ListTile(
          leading: Icon(Icons.people),
          title: Text("Last name: ${widget.title}"),
          subtitle: Text("First name: ${widget.subtitle}"),
        ),
        decoration:
            selected ? BoxDecoration(color: Colors.black38) : BoxDecoration(),
      ),
    );
  }
}
