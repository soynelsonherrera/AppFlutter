import 'dart:async';

import 'index.dart';
import 'serializers.dart';
import 'package:built_value/built_value.dart';

part 'paymentmethods_record.g.dart';

abstract class PaymentmethodsRecord
    implements Built<PaymentmethodsRecord, PaymentmethodsRecordBuilder> {
  static Serializer<PaymentmethodsRecord> get serializer =>
      _$paymentmethodsRecordSerializer;

  @nullable
  String get type;

  @nullable
  String get bank;

  @nullable
  @BuiltValueField(wireName: kDocumentReferenceField)
  DocumentReference get reference;

  static void _initializeBuilder(PaymentmethodsRecordBuilder builder) => builder
    ..type = ''
    ..bank = '';

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('Paymentmethods');

  static Stream<PaymentmethodsRecord> getDocument(DocumentReference ref) => ref
      .snapshots()
      .map((s) => serializers.deserializeWith(serializer, serializedData(s)));

  static Future<PaymentmethodsRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then(
          (s) => serializers.deserializeWith(serializer, serializedData(s)));

  PaymentmethodsRecord._();
  factory PaymentmethodsRecord(
          [void Function(PaymentmethodsRecordBuilder) updates]) =
      _$PaymentmethodsRecord;

  static PaymentmethodsRecord getDocumentFromData(
          Map<String, dynamic> data, DocumentReference reference) =>
      serializers.deserializeWith(serializer,
          {...mapFromFirestore(data), kDocumentReferenceField: reference});
}

Map<String, dynamic> createPaymentmethodsRecordData({
  String type,
  String bank,
}) =>
    serializers.toFirestore(
        PaymentmethodsRecord.serializer,
        PaymentmethodsRecord((p) => p
          ..type = type
          ..bank = bank));
