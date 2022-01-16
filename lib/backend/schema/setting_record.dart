import 'dart:async';

import 'index.dart';
import 'serializers.dart';
import 'package:built_value/built_value.dart';

part 'setting_record.g.dart';

abstract class SettingRecord
    implements Built<SettingRecord, SettingRecordBuilder> {
  static Serializer<SettingRecord> get serializer => _$settingRecordSerializer;

  @nullable
  @BuiltValueField(wireName: 'delivery_price')
  double get deliveryPrice;

  @nullable
  String get logo;

  @nullable
  LatLng get addres;

  @nullable
  String get yape;

  @nullable
  @BuiltValueField(wireName: 'n_yape')
  String get nYape;

  @nullable
  @BuiltValueField(wireName: 'name_yape')
  String get nameYape;

  @nullable
  @BuiltValueField(wireName: kDocumentReferenceField)
  DocumentReference get reference;

  static void _initializeBuilder(SettingRecordBuilder builder) => builder
    ..deliveryPrice = 0.0
    ..logo = ''
    ..yape = ''
    ..nYape = ''
    ..nameYape = '';

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('setting');

  static Stream<SettingRecord> getDocument(DocumentReference ref) => ref
      .snapshots()
      .map((s) => serializers.deserializeWith(serializer, serializedData(s)));

  static Future<SettingRecord> getDocumentOnce(DocumentReference ref) => ref
      .get()
      .then((s) => serializers.deserializeWith(serializer, serializedData(s)));

  SettingRecord._();
  factory SettingRecord([void Function(SettingRecordBuilder) updates]) =
      _$SettingRecord;

  static SettingRecord getDocumentFromData(
          Map<String, dynamic> data, DocumentReference reference) =>
      serializers.deserializeWith(serializer,
          {...mapFromFirestore(data), kDocumentReferenceField: reference});
}

Map<String, dynamic> createSettingRecordData({
  double deliveryPrice,
  String logo,
  LatLng addres,
  String yape,
  String nYape,
  String nameYape,
}) =>
    serializers.toFirestore(
        SettingRecord.serializer,
        SettingRecord((s) => s
          ..deliveryPrice = deliveryPrice
          ..logo = logo
          ..addres = addres
          ..yape = yape
          ..nYape = nYape
          ..nameYape = nameYape));
