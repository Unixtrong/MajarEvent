import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:majar_event/data/model/event.dart';
import 'package:majar_event/res/strings.dart';
import 'package:majar_event/tools/logger.dart';
import 'package:majar_event/tools/snack_bar.dart';

class AddEventPage extends StatefulWidget {
  final String title;

  AddEventPage({Key key, this.title}) : super(key: key);
  @override
  _AddEventState createState() => _AddEventState();
}

class _AddEventState extends State<AddEventPage> {
  String _input = "";
  bool _confirmEnable = false;

  @override
  Widget build(BuildContext context) {
    Logger.debug();
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: _buildBody());
  }

  Widget _buildBody() => new Builder(
      builder: (context) => new Column(
            children: <Widget>[
              // 输入框
              new Expanded(
                child: new TextField(
                  onChanged: onInputChanged,
                  maxLines: 5,
                  autofocus: true,
                ),
              ),
              // 操作条
              new Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    new FlatButton(
                      child: new Text(Strings.confirm,
                          style: TextStyle(
                              color: _confirmEnable
                                  ? Colors.black
                                  : Colors.black38,
                              fontWeight: FontWeight.bold)),
                      onPressed: _confirmEnable
                          ? () {
                              onConfirm(context);
                            }
                          : null,
                    )
                  ])
            ],
          ));

  void onInputChanged(String text) {
    Logger.debug('$text');
    setState(() {
      _confirmEnable = text.isNotEmpty;
    });
    _input = text;
  }

  void onConfirm(BuildContext context) {
    Logger.debug();
    if (_input.isNotEmpty) {
      var event = Event.now(_input);
      Navigator.of(context).pop<Event>(event);
    }
  }
}
