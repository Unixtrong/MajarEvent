import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:majar_event/const/const.dart';
import 'package:majar_event/data/model/event.dart';
import 'package:majar_event/tools/logger.dart';
import 'package:majar_event/tools/snack_bar.dart';

class CardItem extends StatelessWidget {
  final Event item;
  final Animation<double> animation;
  final VoidCallback onTap;

  const CardItem(
      {Key key, @required this.item, this.onTap, @required this.animation})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.display1;
    return new Padding(
        padding: const EdgeInsets.all(2.0),
        child: SizeTransition(
            axis: Axis.vertical,
            sizeFactor: animation,
            child: new GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: onTap,
                child: SizedBox(
                    height: 128.0,
                    child: new Card(
                        color: Colors.white,
                        child: new Center(
                          child: new Text('${item.name}', style: textStyle),
                        ))))));
  }
}

class EventListPage extends StatefulWidget {
  final String title;

  EventListPage({Key key, this.title}) : super(key: key);
  @override
  _EventListState createState() => _EventListState();
}

class ListModel<E> {
  final GlobalKey<AnimatedListState> listKey;
  final List<E> _items;
  final dynamic removedItemBuilder;
  ListModel(
      {@required this.listKey,
      @required this.removedItemBuilder,
      Iterable<E> initialItems})
      : assert(listKey != null),
        _items = new List<E>.from(initialItems ?? <E>[]);
  int get length => _items.length;
  AnimatedListState get _animatedList => listKey.currentState;

  E operator [](int index) => _items[index];

  void insert(int index, E item) {
    _items.insert(index, item);
    _animatedList.insertItem(index);
  }
}

class _EventListState extends State<EventListPage> {
  final GlobalKey<AnimatedListState> _listKey =
      new GlobalKey<AnimatedListState>();
  ListModel<Event> _list;

  @override
  Widget build(BuildContext context) {
    Logger.debug();
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: new Padding(
            padding: const EdgeInsets.all(16.0),
            child: new AnimatedList(
              key: _listKey,
              initialItemCount: _list.length,
              itemBuilder: _buildCardItem,
            )),
        floatingActionButton: new Builder(
            builder: (context) =>
                new FloatingActionButton(onPressed: _openAddEventDialog)));
  }

  @override
  void initState() {
    super.initState();
    var event1 = Event.now('儿童节吃鸭血火锅');
    var event2 = Event.now('梯子换了 8089 端口');
    _list = new ListModel(
        listKey: _listKey,
        removedItemBuilder: null,
        initialItems: <Event>[event1, event2]);
  }

  Widget _buildCardItem(
      BuildContext context, int index, Animation<double> animation) {
    return new CardItem(
        item: _list[index],
        animation: animation,
        onTap: Const.isDebug
            ? () {
                SnackTool.show(context, "text: $index");
              }
            : null);
  }

  void _openAddEventDialog() async {
    var event = await Navigator.of(context).pushNamed('/add_event');
    Logger.debug((event as Event).name);
    _list.insert(0, event);
  }
}
