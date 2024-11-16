import 'package:cloud_firestore/cloud_firestore.dart';

class Ordermodel {
  String idOrder;
  String idstore;
  String nameUser;
  String phone;
  String status;
  String price;
  String type;
  Timestamp date;
  String recipientPhone;

  Ordermodel(
      {required this.idOrder,
      required this.idstore,
      required this.nameUser,
      required this.phone,
      required this.status,
      required this.price,
      required this.type,
      required this.date,
      required this.recipientPhone});

  factory Ordermodel.fromJson(Map<String, dynamic> json) {
    return Ordermodel(
        idOrder: json['idOrder'],
        idstore: json['idstore'],
        nameUser: json['nameUser'],
        phone: json['phone'],
        status: json['status'],
        price: json['price'],
        type: json['type'],
        date: json['date'],
        recipientPhone: json['recipientPhone']);
  }

  Map<String, dynamic> toJson() {
    return {
      'idOrder': idOrder,
      'idstore': idstore,
      'nameUser': nameUser,
      'phone': phone,
      'status': status,
      'price': price,
      'type': type,
      'date': date,
      'recipientPhone': recipientPhone
    };
  }
}
