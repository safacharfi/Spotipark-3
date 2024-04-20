class Timeslot {
  late String id;
  late String duration;
  late String Price;
  Timeslot(this.id, {required this.duration, required this.Price});

  Timeslot.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    duration = json['duration'];
    Price = json['Price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['duration'] = duration;
    data['Price'] = Price;
    return data;
  }
}
