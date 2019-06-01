class Event {
  String name;
  DateTime date;
  Event.now(this.name) {
    date = DateTime.now();
  }
}
