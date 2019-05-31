import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class EventList extends StatefulWidget {
  EventList({Key key, this.title}) : super(key: key);

  final String title;
  @override
  _EventListState createState() => _EventListState();
}

class _EventListState extends State<EventList> {
  final GlobalKey<AnimatedListState> _listKey =
      new GlobalKey<AnimatedListState>();
  ListModel<int> _list;

  @override
  void initState() {
    super.initState();
    _list = new ListModel(
        listKey: _listKey, initialItems: <int>[0, 1, 2, 3, 4, 5, 6, 7, 8]);
  }

  Widget _buildItem(
      BuildContext context, int index, Animation<double> animation) {
    return new CardItem(
        item: index,
        animation: animation,
        onTap: () {
          final scaffold = Scaffold.of(context);
          scaffold.showSnackBar(new SnackBar(
              content: new Text("index: $index"),
              action: SnackBarAction(
                  label: 'UNDO', onPressed: scaffold.hideCurrentSnackBar)));
        });
  }

  @override
  Widget build(BuildContext context) {
    debugPrint("$runtimeType.build, list size: ${_list.length}");
    return Scaffold(
        appBar: AppBar(
          title: Text('EventList'),
        ),
        body: new Padding(
            padding: const EdgeInsets.all(16.0),
            child: new AnimatedList(
              key: _listKey,
              initialItemCount: _list.length,
              itemBuilder: _buildItem,
            )));
  }
}

class ListModel<E> {
  final GlobalKey<AnimatedListState> listKey;
  final List<E> _items;

  ListModel({@required this.listKey, Iterable<E> initialItems})
      : assert(listKey != null),
        _items = new List<E>.from(initialItems ?? <E>[]);

  void insert(int index, E item) {
    _items.insert(index, item);
  }

  int get length => _items.length;
  E operator [](int index) => _items[index];
}

class CardItem extends StatelessWidget {
  final int item;
  final Animation<double> animation;
  final VoidCallback onTap;

  const CardItem({@required this.item, this.onTap, @required this.animation});

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
                          child: new Text('事件 $item', style: textStyle),
                        ))))));
  }
}
