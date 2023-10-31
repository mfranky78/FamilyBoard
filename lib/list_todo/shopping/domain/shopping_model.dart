

class Shopping {
  
  String name;
  int quantity;

  Shopping({required this.name, required this.quantity});

  factory Shopping.fromJson(Map<String, dynamic> json) =>
      Shopping(name: json["name"], quantity: json['quantity'] );
}