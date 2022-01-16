import 'dart:async';

import 'index.dart';
import 'serializers.dart';
import 'package:built_value/built_value.dart';

part 'product_record.g.dart';

abstract class ProductRecord
    implements Built<ProductRecord, ProductRecordBuilder> {
  static Serializer<ProductRecord> get serializer => _$productRecordSerializer;

  @nullable
  @BuiltValueField(wireName: 'name_product')
  String get nameProduct;

  @nullable
  @BuiltValueField(wireName: 'img_product')
  String get imgProduct;

  @nullable
  bool get stock;

  @nullable
  @BuiltValueField(wireName: 'user_id')
  DocumentReference get userId;

  @nullable
  @BuiltValueField(wireName: 'created_time')
  DateTime get createdTime;

  @nullable
  String get category;

  @nullable
  String get description;

  @nullable
  double get rating;

  @nullable
  double get price;

  @nullable
  @BuiltValueField(wireName: 'complements_add')
  BuiltList<bool> get complementsAdd;

  @nullable
  bool get complements;

  @nullable
  @BuiltValueField(wireName: kDocumentReferenceField)
  DocumentReference get reference;

  static void _initializeBuilder(ProductRecordBuilder builder) => builder
    ..nameProduct = ''
    ..imgProduct = ''
    ..stock = false
    ..category = ''
    ..description = ''
    ..rating = 0.0
    ..price = 0.0
    ..complementsAdd = ListBuilder()
    ..complements = false;

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('product');

  static Stream<ProductRecord> getDocument(DocumentReference ref) => ref
      .snapshots()
      .map((s) => serializers.deserializeWith(serializer, serializedData(s)));

  static Future<ProductRecord> getDocumentOnce(DocumentReference ref) => ref
      .get()
      .then((s) => serializers.deserializeWith(serializer, serializedData(s)));

  static ProductRecord fromAlgolia(AlgoliaObjectSnapshot snapshot) =>
      ProductRecord(
        (c) => c
          ..nameProduct = snapshot.data['name_product']
          ..imgProduct = snapshot.data['img_product']
          ..stock = snapshot.data['stock']
          ..userId = safeGet(() => toRef(snapshot.data['user_id']))
          ..createdTime = safeGet(() => DateTime.fromMillisecondsSinceEpoch(
              snapshot.data['created_time']))
          ..category = snapshot.data['category']
          ..description = snapshot.data['description']
          ..rating = snapshot.data['rating']
          ..price = snapshot.data['price']
          ..complementsAdd =
              safeGet(() => ListBuilder(snapshot.data['complements_add']))
          ..complements = snapshot.data['complements']
          ..reference = ProductRecord.collection.doc(snapshot.objectID),
      );

  static Future<List<ProductRecord>> search(
          {String term,
          FutureOr<LatLng> location,
          int maxResults,
          double searchRadiusMeters}) =>
      FFAlgoliaManager.instance
          .algoliaQuery(
            index: 'product',
            term: term,
            maxResults: maxResults,
            location: location,
            searchRadiusMeters: searchRadiusMeters,
          )
          .then((r) => r.map(fromAlgolia).toList());

  ProductRecord._();
  factory ProductRecord([void Function(ProductRecordBuilder) updates]) =
      _$ProductRecord;

  static ProductRecord getDocumentFromData(
          Map<String, dynamic> data, DocumentReference reference) =>
      serializers.deserializeWith(serializer,
          {...mapFromFirestore(data), kDocumentReferenceField: reference});
}

Map<String, dynamic> createProductRecordData({
  String nameProduct,
  String imgProduct,
  bool stock,
  DocumentReference userId,
  DateTime createdTime,
  String category,
  String description,
  double rating,
  double price,
  bool complements,
}) =>
    serializers.toFirestore(
        ProductRecord.serializer,
        ProductRecord((p) => p
          ..nameProduct = nameProduct
          ..imgProduct = imgProduct
          ..stock = stock
          ..userId = userId
          ..createdTime = createdTime
          ..category = category
          ..description = description
          ..rating = rating
          ..price = price
          ..complementsAdd = null
          ..complements = complements));
