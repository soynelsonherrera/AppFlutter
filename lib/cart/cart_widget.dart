import '../auth/auth_util.dart';
import '../backend/backend.dart';
import '../flutter_flow/flutter_flow_icon_button.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import '../main.dart';
import '../resume/resume_widget.dart';
import '../flutter_flow/custom_functions.dart' as functions;
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CartWidget extends StatefulWidget {
  const CartWidget({
    Key key,
    this.cartProducts,
  }) : super(key: key);

  final DocumentReference cartProducts;

  @override
  _CartWidgetState createState() => _CartWidgetState();
}

class _CartWidgetState extends State<CartWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<CartRecord>>(
      stream: queryCartRecord(
        queryBuilder: (cartRecord) =>
            cartRecord.where('user_id', isEqualTo: currentUserReference),
      ),
      builder: (context, snapshot) {
        // Customize what your widget looks like when it's loading.
        if (!snapshot.hasData) {
          return Center(
            child: SizedBox(
              width: 50,
              height: 50,
              child: CircularProgressIndicator(
                color: FlutterFlowTheme.boton,
              ),
            ),
          );
        }
        List<CartRecord> cartCartRecordList = snapshot.data;
        return Scaffold(
          key: scaffoldKey,
          backgroundColor: Color(0xFFF5F5F5),
          body: StreamBuilder<List<ProductRecord>>(
            stream: queryProductRecord(
              singleRecord: true,
            ),
            builder: (context, snapshot) {
              // Customize what your widget looks like when it's loading.
              if (!snapshot.hasData) {
                return Center(
                  child: SizedBox(
                    width: 50,
                    height: 50,
                    child: CircularProgressIndicator(
                      color: FlutterFlowTheme.boton,
                    ),
                  ),
                );
              }
              List<ProductRecord> columnProductRecordList = snapshot.data;
              // Return an empty Container when the document does not exist.
              if (snapshot.data.isEmpty) {
                return Container();
              }
              final columnProductRecord = columnProductRecordList.isNotEmpty
                  ? columnProductRecordList.first
                  : null;
              return Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    height: 90,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Color(0x55000000),
                        )
                      ],
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20),
                        topLeft: Radius.circular(0),
                        topRight: Radius.circular(0),
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(16, 35, 16, 0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () async {
                              await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      NavBarPage(initialPage: 'Home'),
                                ),
                              );
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: Color(0xFFD7D7D7),
                                boxShadow: [
                                  BoxShadow(
                                    color: Color(0xFFB2B2B2),
                                  )
                                ],
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(4, 4, 4, 4),
                                child: Icon(
                                  Icons.chevron_left_outlined,
                                  color: Color(0xFFABABAB),
                                  size: 20,
                                ),
                              ),
                            ),
                          ),
                          Text(
                            'Tu canasta ',
                            style: FlutterFlowTheme.bodyText1.override(
                              fontFamily: 'Poppins',
                              color: Color(0xFF4F4F4F),
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: Color(0xFFD7D7D7),
                              boxShadow: [
                                BoxShadow(
                                  color: Color(0xFFB2B2B2),
                                )
                              ],
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  if ((cartCartRecordList.length) < 1)
                    Expanded(
                      child: FutureBuilder<List<CartRecord>>(
                        future: queryCartRecordOnce(
                          limit: 1,
                        ),
                        builder: (context, snapshot) {
                          // Customize what your widget looks like when it's loading.
                          if (!snapshot.hasData) {
                            return Center(
                              child: SizedBox(
                                width: 50,
                                height: 50,
                                child: CircularProgressIndicator(
                                  color: FlutterFlowTheme.boton,
                                ),
                              ),
                            );
                          }
                          List<CartRecord> containerCartRecordList =
                              snapshot.data;
                          return Container(
                            width: double.infinity,
                            height: 400,
                            decoration: BoxDecoration(),
                            child: Align(
                              alignment: AlignmentDirectional(0.16, 0.92),
                              child: Text(
                                'No tienes productos agregados',
                                style: FlutterFlowTheme.bodyText1.override(
                                  fontFamily: 'Poppins',
                                  color: Color(0xFF747474),
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  Expanded(
                    child: StreamBuilder<List<CartRecord>>(
                      stream: queryCartRecord(
                        queryBuilder: (cartRecord) => cartRecord
                            .where('user_id', isEqualTo: currentUserReference),
                      ),
                      builder: (context, snapshot) {
                        // Customize what your widget looks like when it's loading.
                        if (!snapshot.hasData) {
                          return Center(
                            child: SizedBox(
                              width: 50,
                              height: 50,
                              child: CircularProgressIndicator(
                                color: FlutterFlowTheme.boton,
                              ),
                            ),
                          );
                        }
                        List<CartRecord> columnProductCartRecordList =
                            snapshot.data;
                        return SingleChildScrollView(
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: List.generate(
                                columnProductCartRecordList.length,
                                (columnProductIndex) {
                              final columnProductCartRecord =
                                  columnProductCartRecordList[
                                      columnProductIndex];
                              return Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    15, 10, 15, 0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                        blurRadius: 10,
                                        color: Color(0xFFCBCBCB),
                                        spreadRadius: 1,
                                      )
                                    ],
                                    borderRadius: BorderRadius.circular(25),
                                    shape: BoxShape.rectangle,
                                  ),
                                  child: Stack(
                                    alignment: AlignmentDirectional(0, 0.55),
                                    children: [
                                      Align(
                                        alignment:
                                            AlignmentDirectional(7.44, 1.44),
                                        child: Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  10, 10, 10, 10),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              StreamBuilder<
                                                  List<ProductRecord>>(
                                                stream: queryProductRecord(
                                                  queryBuilder: (productRecord) =>
                                                      productRecord
                                                          .where('name_product',
                                                              isEqualTo:
                                                                  columnProductCartRecord
                                                                      .cartName)
                                                          .where('price',
                                                              isEqualTo:
                                                                  columnProductCartRecord
                                                                      .cartPrice),
                                                  singleRecord: true,
                                                ),
                                                builder: (context, snapshot) {
                                                  // Customize what your widget looks like when it's loading.
                                                  if (!snapshot.hasData) {
                                                    return Center(
                                                      child: SizedBox(
                                                        width: 50,
                                                        height: 50,
                                                        child:
                                                            CircularProgressIndicator(
                                                          color:
                                                              FlutterFlowTheme
                                                                  .boton,
                                                        ),
                                                      ),
                                                    );
                                                  }
                                                  List<ProductRecord>
                                                      imageProductRecordList =
                                                      snapshot.data;
                                                  // Return an empty Container when the document does not exist.
                                                  if (snapshot.data.isEmpty) {
                                                    return Container();
                                                  }
                                                  final imageProductRecord =
                                                      imageProductRecordList
                                                              .isNotEmpty
                                                          ? imageProductRecordList
                                                              .first
                                                          : null;
                                                  return ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                    child: Image.network(
                                                      imageProductRecord
                                                          .imgProduct,
                                                      width: 70,
                                                      height: 70,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  );
                                                },
                                              ),
                                              Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(10, 0, 100, 0),
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    Column(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Container(
                                                          width: 230,
                                                          height: 35,
                                                          decoration:
                                                              BoxDecoration(),
                                                          child: AutoSizeText(
                                                            columnProductCartRecord
                                                                .cartName,
                                                            textAlign:
                                                                TextAlign.start,
                                                            style:
                                                                FlutterFlowTheme
                                                                    .bodyText1
                                                                    .override(
                                                              fontFamily:
                                                                  'Poppins',
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                            ),
                                                          ),
                                                        ),
                                                        Row(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          children: [
                                                            Text(
                                                              formatNumber(
                                                                columnProductCartRecord
                                                                    .cartPrice,
                                                                formatType:
                                                                    FormatType
                                                                        .custom,
                                                                currency: 'S/',
                                                                format: '.00',
                                                                locale: 'es_PE',
                                                              ),
                                                              textAlign:
                                                                  TextAlign
                                                                      .start,
                                                              style:
                                                                  FlutterFlowTheme
                                                                      .bodyText1
                                                                      .override(
                                                                fontFamily:
                                                                    'Poppins',
                                                                color: Color(
                                                                    0xFFA3A3A3),
                                                                fontSize: 10,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        Row(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Text(
                                                              functions.currencyToString(
                                                                  columnProductCartRecord
                                                                      .cartQuantity
                                                                      .toDouble(),
                                                                  columnProductCartRecord
                                                                      .cartPrice),
                                                              textAlign:
                                                                  TextAlign
                                                                      .start,
                                                              style:
                                                                  FlutterFlowTheme
                                                                      .bodyText1
                                                                      .override(
                                                                fontFamily:
                                                                    'Poppins',
                                                                color: Color(
                                                                    0xFF343434),
                                                                fontSize: 13,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Align(
                                        alignment:
                                            AlignmentDirectional(0.84, 0.14),
                                        child: Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  120, 0, 0, 0),
                                          child: Container(
                                            width: 120,
                                            height: 40,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              shape: BoxShape.rectangle,
                                            ),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                FlutterFlowIconButton(
                                                  borderColor:
                                                      Colors.transparent,
                                                  borderRadius: 30,
                                                  borderWidth: 1,
                                                  buttonSize: 50,
                                                  icon: Icon(
                                                    Icons.horizontal_rule,
                                                    color:
                                                        FlutterFlowTheme.boton,
                                                    size: 20,
                                                  ),
                                                  onPressed: () async {
                                                    final cartUpdateData = {
                                                      ...createCartRecordData(
                                                        cartSubTotal: functions
                                                            .cantidadMulti(
                                                                columnProductCartRecord
                                                                    .cartQuantity
                                                                    .toDouble(),
                                                                columnProductCartRecord
                                                                    .cartPrice),
                                                      ),
                                                      'cartQuantity':
                                                          FieldValue.increment(
                                                              -1),
                                                    };
                                                    await columnProductCartRecord
                                                        .reference
                                                        .update(cartUpdateData);
                                                    if ((columnProductCartRecord
                                                            .cartQuantity) <
                                                        2) {
                                                      await columnProductCartRecord
                                                          .reference
                                                          .delete();
                                                    }
                                                  },
                                                ),
                                                Container(
                                                  width: 30,
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    boxShadow: [
                                                      BoxShadow(
                                                        blurRadius: 5,
                                                        color:
                                                            Color(0xFFD4D4D4),
                                                      )
                                                    ],
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            6),
                                                    border: Border.all(
                                                      color: Color(0xFFD2D2D2),
                                                    ),
                                                  ),
                                                  child: Text(
                                                    columnProductCartRecord
                                                        .cartQuantity
                                                        .toString(),
                                                    textAlign: TextAlign.center,
                                                    style: FlutterFlowTheme
                                                        .bodyText1
                                                        .override(
                                                      fontFamily: 'Poppins',
                                                      color: Color(0xFF9E9E9E),
                                                      fontSize: 15,
                                                    ),
                                                  ),
                                                ),
                                                FlutterFlowIconButton(
                                                  borderColor:
                                                      Colors.transparent,
                                                  borderRadius: 30,
                                                  borderWidth: 1,
                                                  buttonSize: 50,
                                                  icon: Icon(
                                                    Icons.add,
                                                    color:
                                                        FlutterFlowTheme.boton,
                                                    size: 20,
                                                  ),
                                                  onPressed: () async {
                                                    final cartUpdateData = {
                                                      ...createCartRecordData(
                                                        cartSubTotal: functions
                                                            .priceQuantity(
                                                                columnProductCartRecord
                                                                    .cartQuantity
                                                                    .toDouble(),
                                                                columnProductCartRecord
                                                                    .cartPrice),
                                                      ),
                                                      'cartQuantity':
                                                          FieldValue.increment(
                                                              1),
                                                    };
                                                    await columnProductCartRecord
                                                        .reference
                                                        .update(cartUpdateData);
                                                  },
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }),
                          ),
                        );
                      },
                    ),
                  ),
                  if ((currentUserReference) == (currentUserReference))
                    Align(
                      alignment: AlignmentDirectional(0, 1),
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(10, 0, 10, 60),
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(),
                          child: Visibility(
                            visible: (cartCartRecordList.length) > 0,
                            child: Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 0, 0, 20),
                              child: FutureBuilder<List<CartRecord>>(
                                future: queryCartRecordOnce(),
                                builder: (context, snapshot) {
                                  // Customize what your widget looks like when it's loading.
                                  if (!snapshot.hasData) {
                                    return Center(
                                      child: SizedBox(
                                        width: 50,
                                        height: 50,
                                        child: CircularProgressIndicator(
                                          color: FlutterFlowTheme.boton,
                                        ),
                                      ),
                                    );
                                  }
                                  List<CartRecord>
                                      bottomButtonAreaCartRecordList =
                                      snapshot.data;
                                  return Container(
                                    width:
                                        MediaQuery.of(context).size.width * 0.9,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                          blurRadius: 20,
                                          color: Color(0x3A000000),
                                        )
                                      ],
                                      borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(0),
                                        bottomRight: Radius.circular(0),
                                        topLeft: Radius.circular(35),
                                        topRight: Radius.circular(35),
                                      ),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          16, 16, 16, 16),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Row(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(0, 0, 5, 0),
                                                child: Text(
                                                  'SubTotal:',
                                                  style: FlutterFlowTheme
                                                      .bodyText1
                                                      .override(
                                                    fontFamily: 'Poppins',
                                                    color: Color(0xFFA2A2A2),
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                              ),
                                              Text(
                                                functions.sumaToDB(
                                                    FFAppState().list.toList()),
                                                style: FlutterFlowTheme
                                                    .bodyText1
                                                    .override(
                                                  fontFamily: 'Poppins',
                                                  color: Color(0xCC000000),
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ],
                                          ),
                                          FFButtonWidget(
                                            onPressed: () async {
                                              await Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      ResumeWidget(
                                                    resumenTotal: '',
                                                  ),
                                                ),
                                              );
                                            },
                                            text: 'Ir a pagar',
                                            options: FFButtonOptions(
                                              width: 130,
                                              height: 40,
                                              color: FlutterFlowTheme.boton,
                                              textStyle: FlutterFlowTheme
                                                  .subtitle2
                                                  .override(
                                                fontFamily: 'Lexend Deca',
                                                color: Colors.white,
                                                fontSize: 13,
                                                fontWeight: FontWeight.w500,
                                              ),
                                              elevation: 3,
                                              borderSide: BorderSide(
                                                color: Colors.transparent,
                                                width: 1,
                                              ),
                                              borderRadius: 30,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              );
            },
          ),
        );
      },
    );
  }
}
