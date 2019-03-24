class Ticket {
  final String title;
  final int price;
  final int virtualPrice;

  Ticket(this.title, this.price, [this.virtualPrice = -1]);
}
