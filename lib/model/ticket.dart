class Ticket {
  final String title;
  final int price;
  final int realPrice;

  Ticket(this.title, this.price, [this.realPrice = -1]);
}