class InvoiceItem {
  String? name;
  int? quantity;
  double? price;
  double? amount;

  InvoiceItem({
    this.name,
    this.quantity,
    this.price,
    this.amount,
  });

  InvoiceItem.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    quantity = json['quantity'];
    price = json['price'];
    amount = json['amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['quantity'] = this.quantity;
    data['price'] = this.price;
    data['amount'] = this.amount;
    return data;
  }

  static getList(List<dynamic>? json) {
    List<Map<String, dynamic>> customer =
        List<Map<String, dynamic>>.from(json ?? []);
    return List.generate(
        customer.length, (index) => InvoiceItem.fromJson(customer[index]));
  }
}
