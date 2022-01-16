import 'dart:async';

import 'index.dart';
import 'serializers.dart';
import 'package:built_value/built_value.dart';

part 'cart_record.g.dart';

abstract class CartRecord implements Built<CartRecord, CartRecordBuilder> {
  static Serializer<CartRecord> get serializer => _$cartRecordSerializer;

  @nullable
  @BuiltValueField(wireName: 'user_id')
  DocumentReference get userId;

  @nullable
  String get cartName;

  @nullable
  int get cartQuantity;

  @nullable
  double get cartPrice;

  @nullable
  double get cartSubTotal;

  @nullable
  @BuiltValueField(wireName: 'product_ref')
  DocumentReference get productRef;

  @nullable
  @BuiltValueField(wireName: kDocumentReferenceField)
  DocumentReference get reference;

  static void _initializeBuilder(CartRecordBuilder builder) => builder
    ..cartName = ''
    ..cartQuantity = 0
    ..cartPrice = 0.0
    ..cartSubTotal = 0.0;

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('cart');

  static Stream<CartRecord> getDocument(DocumentReference ref) => ref
      .snapshots()
      .map((s) => serializers.deserializeWith(serializer, serializedData(s)));

  static Future<CartRecord> getDocumentOnce(DocumentReference ref) => ref
      .get()
      .then((s) => serializers.deserializeWith(serializer, serializedData(s)));

  CartRecord._();
  factory CartRecord([void Function(CartRecordBuilder) updates]) = _$CartRecord;

  static CartRecord getDocumentFromData(
          Map<String, dynamic> data, DocumentReference reference) =>
      serializers.deserializeWith(serializer,
          {...mapFromFirestore(data), kDocumentReferenceField: reference});
}

Map<String, dynamic> createCartRecordData({
  DocumentReference userId,
  String cartName,
  int cartQuantity,
  double cartPrice,
  double cartSubTotal,
  DocumentReference productRef,
}) =>
    serializers.toFirestore(
        CartRecord.serializer,
        CartRecord((c) => c
          ..userId = userId
          ..cartName = cartName
          ..cartQuantity = cartQuantity
          ..cartPrice = cartPrice
          ..cartSubTotal = cartSubTotal
          ..productRef = productRef));
