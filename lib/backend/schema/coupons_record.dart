import 'dart:async';

import 'index.dart';
import 'serializers.dart';
import 'package:built_value/built_value.dart';

part 'coupons_record.g.dart';

abstract class CouponsRecord
    implements Built<CouponsRecord, CouponsRecordBuilder> {
  static Serializer<CouponsRecord> get serializer => _$couponsRecordSerializer;

  @nullable
  @BuiltValueField(wireName: 'user_id')
  DocumentReference get userId;

  @nullable
  @BuiltValueField(wireName: 'coupon_name')
  String get couponName;

  @nullable
  double get discount;

  @nullable
  @BuiltValueField(wireName: 'created_time')
  DateTime get createdTime;

  @nullable
  String get keyword;

  @nullable
  @BuiltValueField(wireName: kDocumentReferenceField)
  DocumentReference get reference;

  static void _initializeBuilder(CouponsRecordBuilder builder) => builder
    ..couponName = ''
    ..discount = 0.0
    ..keyword = '';

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('coupons');

  static Stream<CouponsRecord> getDocument(DocumentReference ref) => ref
      .snapshots()
      .map((s) => serializers.deserializeWith(serializer, serializedData(s)));

  static Future<CouponsRecord> getDocumentOnce(DocumentReference ref) => ref
      .get()
      .then((s) => serializers.deserializeWith(serializer, serializedData(s)));

  CouponsRecord._();
  factory CouponsRecord([void Function(CouponsRecordBuilder) updates]) =
      _$CouponsRecord;

  static CouponsRecord getDocumentFromData(
          Map<String, dynamic> data, DocumentReference reference) =>
      serializers.deserializeWith(serializer,
          {...mapFromFirestore(data), kDocumentReferenceField: reference});
}

Map<String, dynamic> createCouponsRecordData({
  DocumentReference userId,
  String couponName,
  double discount,
  DateTime createdTime,
  String keyword,
}) =>
    serializers.toFirestore(
        CouponsRecord.serializer,
        CouponsRecord((c) => c
          ..userId = userId
          ..couponName = couponName
          ..discount = discount
          ..createdTime = createdTime
          ..keyword = keyword));
