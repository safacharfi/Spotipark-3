class Parking {
  late String id;
  late String name;
  late String location;
  late String capacity; // Changed to String type

  Parking(this.id,
      {required this.name, required this.location, required this.capacity});

  Parking.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    location = json['location'];
    capacity = json['capacity']; // Capacity is assigned as a String
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['location'] = location;
    data['capacity'] =
        capacity; // Capacity is added as a String in the JSON data
    return data;
  }
}
