
class Student{
  String? key;
  UserStructure? userStructure;

  Student({this.key,this.userStructure});
}

class UserStructure {
  late String name;
  late String number;
  late String age;
  late String message;

  UserStructure(this.name, this.number, this.age, this.message);

  UserStructure.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    number = json['number'];
    age = json['age'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['number'] = number;
    data['age'] = age;
    data['message'] = message;
    return data;
  }
}



