class SavedInvoiceCustomer {
  String? name;
  String? phone;
  String? email;
  String? address;

  SavedInvoiceCustomer({
    this.name,
    this.email,
    this.phone,
    this.address,
  });

  SavedInvoiceCustomer.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    address = json['address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['address'] = this.address;
    return data;
  }

  static getList(List<dynamic>? json) {
    List<Map<String, dynamic>> customer =
        List<Map<String, dynamic>>.from(json ?? []);
    return List.generate(customer.length,
        (index) => SavedInvoiceCustomer.fromJson(customer[index]));
  }
}
