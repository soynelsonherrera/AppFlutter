import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'lat_lng.dart';
import 'place.dart';
import '../backend/backend.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../auth/auth_util.dart';

double priceQuantity(
  double quant,
  double price,
) {
  quant = quant * price;
  return quant;
}

double cantidadMulti(
  double cantidad,
  double precio,
) {
  cantidad = cantidad * precio;
  return cantidad;
}

String subTotal(
  double cantidad,
  List<String> subprecio,
) {
  // suma cantidad mas precio
  if (subprecio.length == cantidad) {
    double total = 0;

    for (int x = 0; x < subprecio.length; x++) {
      total = total + double.parse(subprecio[x]);
    }
    return total.toString();
  } else {
    return '0';
  }
}

String idOrders(String uid) {
  String _randomString = uid.toString() +
      math.Random().nextInt(99).toString() +
      math.Random().nextInt(9999).toString();
  return _randomString;
}

String currency(double price) {
  var f = NumberFormat("###,###.00", "es_PE");
  var end = f.format(price);
  var result = 'S/' '$end';
  return result;
}

String currencyToString(
  double cantidad,
  double precio,
) {
  var f = NumberFormat("###,###.00", "es_PE");
  var end = f.format(cantidad * precio);
  var result = 'S/' '$end';
  return result;
}

String sumaToDB(List<double> data) {
  // suma todo lo de la lista

  double DB_data;

  DB_data = data.reduce((value, element) => value + element);

  var end = DB_data.toStringAsFixed(2);

  // var result = $end;
  return end;
}

String sumListCart(
  double field1,
  double field2,
) {
  // items map double price * quantity value
  double totalss = field1 + field2;

  if ((field1 is int) && (field2 is int)) {
    totalss = field1 + field2;
  }

  return totalss.toStringAsFixed(2);
}

String coupon(
  double discount,
  double total,
) {
  // discount coupon percentage
  var percent = total / 100;
  if (discount > 100) {
    print("Percent should be between 0 and 100");
    return 0.0.toStringAsFixed(2);
  } else {
    double totalDiscount = percent * discount;
    print("total Discount: $totalDiscount");
    var discountFinal = (total - totalDiscount).toStringAsFixed(2);
    return 'S/$discountFinal';
  }
}

String total(
  String subtotal,
  double delivery,
  double discount,
) {
  // string subtotal + delivery

  // // double _subtotal = double.parse(subtotal);
  // double _delivery = double.parse(delivery.toStringAsFixed(1));
  // double _discount = discount;
  // double _total = _subtotal + _delivery - _discount * _subtotal / 100;
  //return _total.toStringAsFixed(2);

  double s = double.parse(subtotal);
  double d = delivery;
  double dd = discount;
  double t = s + d - dd * s / 100;

  return t.toStringAsFixed(2);
}

String distanceGeo(
  double lat1,
  double lon1,
  double lat2,
  double lon2,
) {
  // Add your function code here!
  var p = 0.017453292519943295;
  var c = math.cos;
  var a = 0.5 -
      c((lat2 - lat1) * p) / 2 +
      c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
  // Returns distance in Kilo-meters
  return (12742 * math.asin(math.sqrt(a))).toStringAsFixed(2);
}
