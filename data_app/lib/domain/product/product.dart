class Product {
  int id;
  String name;
  int price;

  Product(
      {required this.id, required this.name, required this.price}); //선택적 매게변수

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        // 이름이 있는 생성자 - 오버로딩이 안되기 때문에
        id: json["id"],
        name: json["name"],
        price: json["price"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "price": price,
      };
}
