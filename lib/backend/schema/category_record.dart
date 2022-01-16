import 'dart:async';

import 'index.dart';
import 'serializers.dart';
import 'package:built_value/built_value.dart';

part 'category_record.g.dart';

abstract class CategoryRecord
    implements Built<CategoryRecord, CategoryRecordBuilder> {
  static Serializer<CategoryRecord> get serializer =>
      _$categoryRecordSerializer;

  @nullable
  @BuiltValueField(wireName: 'user_id')
  DocumentReference get userId;

  @nullable
  String get uid;

  @nullable
  String get name;

  @nullable
  @BuiltValueField(wireName: 'image_category')
  String get imageCategory;

  @nullable
  bool get visibility;

  @nullable
  @BuiltValueField(wireName: 'created_time')
  DateTime get createdTime;

  @nullable
  String get priority;

  @nullable
  @BuiltValueField(wireName: kDocumentReferenceField)
  DocumentReference get reference;

  static void _initializeBuilder(CategoryRecordBuilder builder) => builder
    ..uid = ''
    ..name = ''
    ..imageCategory = ''
    ..visibility = false
    ..priority = '';

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('category');

  static Stream<CategoryRecord> getDocument(DocumentReference ref) => ref
      .snapshots()
      .map((s) => serializers.deserializeWith(serializer, serializedData(s)));

  static Future<CategoryRecord> getDocumentOnce(DocumentReference ref) => ref
      .get()
      .then((s) => serializers.deserializeWith(serializer, serializedData(s)));

  CategoryRecord._();
  factory CategoryRecord([void Function(CategoryRecordBuilder) updates]) =
      _$CategoryRecord;

  static CategoryRecord getDocumentFromData(
          Map<String, dynamic> data, DocumentReference reference) =>
      serializers.deserializeWith(serializer,
          {...mapFromFirestore(data), kDocumentReferenceField: reference});
}

Map<String, dynamic> createCategoryRecordData({
  DocumentReference userId,
  String uid,
  String name,
  String imageCategory,
  bool visibility,
  DateTime createdTime,
  String priority,
}) =>
    serializers.toFirestore(
        CategoryRecord.serializer,
        CategoryRecord((c) => c
          ..userId = userId
          ..uid = uid
          ..name = name
          ..imageCategory = imageCategory
          ..visibility = visibility
          ..createdTime = createdTime
          ..priority = priority));
