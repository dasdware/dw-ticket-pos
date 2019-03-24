class Ticket {
  final String title;
  final int price;
  final int virtualPrice;

  Ticket(this.title, this.price, [this.virtualPrice = -1]);

  bool get hasVirtualPrice => (virtualPrice > -1);
}
