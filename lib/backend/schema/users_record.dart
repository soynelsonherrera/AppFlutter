import 'dart:async';

import 'index.dart';
import 'serializers.dart';
import 'package:built_value/built_value.dart';

part 'users_record.g.dart';

abstract class UsersRecord implements Built<UsersRecord, UsersRecordBuilder> {
  static Serializer<UsersRecord> get serializer => _$usersRecordSerializer;

  @nullable
  String get email;

  @nullable
  @BuiltValueField(wireName: 'photo_url')
  String get photoUrl;

  @nullable
  String get uid;

  @nullable
  @BuiltValueField(wireName: 'created_time')
  DateTime get createdTime;

  @nullable
  @BuiltValueField(wireName: 'phone_number')
  String get phoneNumber;

  @nullable
  BuiltList<bool> get wishlist;

  @nullable
  @BuiltValueField(wireName: 'wishlist_product')
  BuiltList<DocumentReference> get wishlistProduct;

  @nullable
  LatLng get address;

  @nullable
  String get documenttype;

  @nullable
  @BuiltValueField(wireName: 'first_name')
  String get firstName;

  @nullable
  @BuiltValueField(wireName: 'display_name')
  String get displayName;

  @nullable
  String get myqr;

  @nullable
  @BuiltValueField(wireName: 'street_address')
  String get streetAddress;

  @nullable
  String get rol;

  @nullable
  bool get status;

  @nullable
  @BuiltValueField(wireName: 'last_name')
  String get lastName;

  @nullable
  String get gender;

  @nullable
  DateTime get birthday;

  @nullable
  String get prefix;

  @nullable
  @BuiltValueField(wireName: 'document_number')
  String get documentNumber;

  @nullable
  @BuiltValueField(wireName: kDocumentReferenceField)
  DocumentReference get reference;

  static void _initializeBuilder(UsersRecordBuilder builder) => builder
    ..email = ''
    ..photoUrl = ''
    ..uid = ''
    ..phoneNumber = ''
    ..wishlist = ListBuilder()
    ..wishlistProduct = ListBuilder()
    ..documenttype = ''
    ..firstName = ''
    ..displayName = ''
    ..myqr = ''
    ..streetAddress = ''
    ..rol = ''
    ..status = false
    ..lastName = ''
    ..gender = ''
    ..prefix = ''
    ..documentNumber = '';

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('users');

  static Stream<UsersRecord> getDocument(DocumentReference ref) => ref
      .snapshots()
      .map((s) => serializers.deserializeWith(serializer, serializedData(s)));

  static Future<UsersRecord> getDocumentOnce(DocumentReference ref) => ref
      .get()
      .then((s) => serializers.deserializeWith(serializer, serializedData(s)));

  static UsersRecord fromAlgolia(AlgoliaObjectSnapshot snapshot) => UsersRecord(
        (c) => c
          ..email = snapshot.data['email']
          ..photoUrl = snapshot.data['photo_url']
          ..uid = snapshot.data['uid']
          ..createdTime = safeGet(() => DateTime.fromMillisecondsSinceEpoch(
              snapshot.data['created_time']))
          ..phoneNumber = snapshot.data['phone_number']
          ..wishlist = safeGet(() => ListBuilder(snapshot.data['wishlist']))
          ..wishlistProduct = safeGet(() => ListBuilder(
              snapshot.data['wishlist_product'].map((s) => toRef(s))))
          ..address = safeGet(() => LatLng(
                snapshot.data['_geoloc']['lat'],
                snapshot.data['_geoloc']['lng'],
              ))
          ..documenttype = snapshot.data['documenttype']
          ..firstName = snapshot.data['first_name']
          ..displayName = snapshot.data['display_name']
          ..myqr = snapshot.data['myqr']
          ..streetAddress = snapshot.data['street_address']
          ..rol = snapshot.data['rol']
          ..status = snapshot.data['status']
          ..lastName = snapshot.data['last_name']
          ..gender = snapshot.data['gender']
          ..birthday = safeGet(() =>
              DateTime.fromMillisecondsSinceEpoch(snapshot.data['birthday']))
          ..prefix = snapshot.data['prefix']
          ..documentNumber = snapshot.data['document_number']
          ..reference = UsersRecord.collection.doc(snapshot.objectID),
      );

  static Future<List<UsersRecord>> search(
          {String term,
          FutureOr<LatLng> location,
          int maxResults,
          double searchRadiusMeters}) =>
      FFAlgoliaManager.instance
          .algoliaQuery(
            index: 'users',
            term: term,
            maxResults: maxResults,
            location: location,
            searchRadiusMeters: searchRadiusMeters,
          )
          .then((r) => r.map(fromAlgolia).toList());

  UsersRecord._();
  factory UsersRecord([void Function(UsersRecordBuilder) updates]) =
      _$UsersRecord;

  static UsersRecord getDocumentFromData(
          Map<String, dynamic> data, DocumentReference reference) =>
      serializers.deserializeWith(serializer,
          {...mapFromFirestore(data), kDocumentReferenceField: reference});
}

Map<String, dynamic> createUsersRecordData({
  String email,
  String photoUrl,
  String uid,
  DateTime createdTime,
  String phoneNumber,
  LatLng address,
  String documenttype,
  String firstName,
  String displayName,
  String myqr,
  String streetAddress,
  String rol,
  bool status,
  String lastName,
  String gender,
  DateTime birthday,
  String prefix,
  String documentNumber,
}) =>
    serializers.toFirestore(
        UsersRecord.serializer,
        UsersRecord((u) => u
          ..email = email
          ..photoUrl = photoUrl
          ..uid = uid
          ..createdTime = createdTime
          ..phoneNumber = phoneNumber
          ..wishlist = null
          ..wishlistProduct = null
          ..address = address
          ..documenttype = documenttype
          ..firstName = firstName
          ..displayName = displayName
          ..myqr = myqr
          ..streetAddress = streetAddress
          ..rol = rol
          ..status = status
          ..lastName = lastName
          ..gender = gender
          ..birthday = birthday
          ..prefix = prefix
          ..documentNumber = documentNumber));
