import 'dart:async';

import 'index.dart';
import 'serializers.dart';
import 'package:built_value/built_value.dart';

part 'complement_record.g.dart';

abstract class ComplementRecord
    implements Built<ComplementRecord, ComplementRecordBuilder> {
  static Serializer<ComplementRecord> get serializer =>
      _$complementRecordSerializer;

  @nullable
  @BuiltValueField(wireName: 'name_complement')
  String get nameComplement;

  @nullable
  @BuiltValueField(wireName: 'img_complement')
  String get imgComplement;

  @nullable
  @BuiltValueField(wireName: 'price_complement')
  double get priceComplement;

  @nullable
  @BuiltValueField(wireName: 'user_id')
  DocumentReference get userId;

  @nullable
  @BuiltValueField(wireName: 'created_time')
  DateTime get createdTime;

  @nullable
  @BuiltValueField(wireName: 'stock_complement')
  bool get stockComplement;

  @nullable
  BuiltList<bool> get add;

  @nullable
  @BuiltValueField(wireName: 'add_products')
  BuiltList<DocumentReference> get addProducts;

  @nullable
  @BuiltValueField(wireName: kDocumentReferenceField)
  DocumentReference get reference;

  static void _initializeBuilder(ComplementRecordBuilder builder) => builder
    ..nameComplement = ''
    ..imgComplement = ''
    ..priceComplement = 0.0
    ..stockComplement = false
    ..add = ListBuilder()
    ..addProducts = ListBuilder();

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('complement');

  static Stream<ComplementRecord> getDocument(DocumentReference ref) => ref
      .snapshots()
      .map((s) => serializers.deserializeWith(serializer, serializedData(s)));

  static Future<ComplementRecord> getDocumentOnce(DocumentReference ref) => ref
      .get()
      .then((s) => serializers.deserializeWith(serializer, serializedData(s)));

  static ComplementRecord fromAlgolia(AlgoliaObjectSnapshot snapshot) =>
      ComplementRecord(
        (c) => c
          ..nameComplement = snapshot.data['name_complement']
          ..imgComplement = snapshot.data['img_complement']
          ..priceComplement = snapshot.data['price_complement']
          ..userId = safeGet(() => toRef(snapshot.data['user_id']))
          ..createdTime = safeGet(() => DateTime.fromMillisecondsSinceEpoch(
              snapshot.data['created_time']))
          ..stockComplement = snapshot.data['stock_complement']
          ..add = safeGet(() => ListBuilder(snapshot.data['add']))
          ..addProducts = safeGet(() =>
              ListBuilder(snapshot.data['add_products'].map((s) => toRef(s))))
          ..reference = ComplementRecord.collection.doc(snapshot.objectID),
      );

  static Future<List<ComplementRecord>> search(
          {String term,
          FutureOr<LatLng> location,
          int maxResults,
          double searchRadiusMeters}) =>
      FFAlgoliaManager.instance
          .algoliaQuery(
            index: 'complement',
            term: term,
            maxResults: maxResults,
            location: location,
            searchRadiusMeters: searchRadiusMeters,
          )
          .then((r) => r.map(fromAlgolia).toList());

  ComplementRecord._();
  factory ComplementRecord([void Function(ComplementRecordBuilder) updates]) =
      _$ComplementRecord;

  static ComplementRecord getDocumentFromData(
          Map<String, dynamic> data, DocumentReference reference) =>
      serializers.deserializeWith(serializer,
          {...mapFromFirestore(data), kDocumentReferenceField: reference});
}

Map<String, dynamic> createComplementRecordData({
  String nameComplement,
  String imgComplement,
  double priceComplement,
  DocumentReference userId,
  DateTime createdTime,
  bool stockComplement,
}) =>
    serializers.toFirestore(
        ComplementRecord.serializer,
        ComplementRecord((c) => c
          ..nameComplement = nameComplement
          ..imgComplement = imgComplement
          ..priceComplement = priceComplement
          ..userId = userId
          ..createdTime = createdTime
          ..stockComplement = stockComplement
          ..add = null
          ..addProducts = null));
