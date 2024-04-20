class Vehicle {
  late String id;
  late String brand;
  late String lisencePlate;
  late String model;

  Vehicle(this.id,
      {required this.brand, required this.lisencePlate, required this.model});

  Vehicle.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    brand = json['brand'];
    lisencePlate = json['lisencePlate'];
    model = json['model'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['brand'] = brand;
    data['lisencePlate'] = lisencePlate;
    data['model'] = model;
    return data;
  }
}
