abstract class DetailEvent {}

class DetailRequestEvent extends DetailEvent {
  String category;
  DetailRequestEvent(this.category);
}
