import 'dart:async';

import 'index.dart';
import 'serializers.dart';
import 'package:built_value/built_value.dart';

part 'orders_record.g.dart';

abstract class OrdersRecord
    implements Built<OrdersRecord, OrdersRecordBuilder> {
  static Serializer<OrdersRecord> get serializer => _$ordersRecordSerializer;

  @nullable
  @BuiltValueField(wireName: 'user_id')
  DocumentReference get userId;

  @nullable
  String get idOrden;

  @nullable
  @BuiltValueField(wireName: 'created_time')
  DateTime get createdTime;

  @nullable
  @BuiltValueField(wireName: 'modify_date')
  DateTime get modifyDate;

  @nullable
  @BuiltValueField(wireName: 'order_status')
  String get orderStatus;

  @nullable
  @BuiltValueField(wireName: 'voucher_img')
  String get voucherImg;

  @nullable
  @BuiltValueField(wireName: 'id_voucher')
  String get idVoucher;

  @nullable
  String get total;

  @nullable
  BuiltList<DocumentReference> get product;

  @nullable
  @BuiltValueField(wireName: kDocumentReferenceField)
  DocumentReference get reference;

  static void _initializeBuilder(OrdersRecordBuilder builder) => builder
    ..idOrden = ''
    ..orderStatus = ''
    ..voucherImg = ''
    ..idVoucher = ''
    ..total = ''
    ..product = ListBuilder();

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('orders');

  static Stream<OrdersRecord> getDocument(DocumentReference ref) => ref
      .snapshots()
      .map((s) => serializers.deserializeWith(serializer, serializedData(s)));

  static Future<OrdersRecord> getDocumentOnce(DocumentReference ref) => ref
      .get()
      .then((s) => serializers.deserializeWith(serializer, serializedData(s)));

  static OrdersRecord fromAlgolia(AlgoliaObjectSnapshot snapshot) =>
      OrdersRecord(
        (c) => c
          ..userId = safeGet(() => toRef(snapshot.data['user_id']))
          ..idOrden = snapshot.data['idOrden']
          ..createdTime = safeGet(() => DateTime.fromMillisecondsSinceEpoch(
              snapshot.data['created_time']))
          ..modifyDate = safeGet(() =>
              DateTime.fromMillisecondsSinceEpoch(snapshot.data['modify_date']))
          ..orderStatus = snapshot.data['order_status']
          ..voucherImg = snapshot.data['voucher_img']
          ..idVoucher = snapshot.data['id_voucher']
          ..total = snapshot.data['total']
          ..product = safeGet(
              () => ListBuilder(snapshot.data['product'].map((s) => toRef(s))))
          ..reference = OrdersRecord.collection.doc(snapshot.objectID),
      );

  static Future<List<OrdersRecord>> search(
          {String term,
          FutureOr<LatLng> location,
          int maxResults,
          double searchRadiusMeters}) =>
      FFAlgoliaManager.instance
          .algoliaQuery(
            index: 'orders',
            term: term,
            maxResults: maxResults,
            location: location,
            searchRadiusMeters: searchRadiusMeters,
          )
          .then((r) => r.map(fromAlgolia).toList());

  OrdersRecord._();
  factory OrdersRecord([void Function(OrdersRecordBuilder) updates]) =
      _$OrdersRecord;

  static OrdersRecord getDocumentFromData(
          Map<String, dynamic> data, DocumentReference reference) =>
      serializers.deserializeWith(serializer,
          {...mapFromFirestore(data), kDocumentReferenceField: reference});
}

Map<String, dynamic> createOrdersRecordData({
  DocumentReference userId,
  String idOrden,
  DateTime createdTime,
  DateTime modifyDate,
  String orderStatus,
  String voucherImg,
  String idVoucher,
  String total,
}) =>
    serializers.toFirestore(
        OrdersRecord.serializer,
        OrdersRecord((o) => o
          ..userId = userId
          ..idOrden = idOrden
          ..createdTime = createdTime
          ..modifyDate = modifyDate
          ..orderStatus = orderStatus
          ..voucherImg = voucherImg
          ..idVoucher = idVoucher
          ..total = total
          ..product = null));
