import '/auth/firebase_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/random_data_util.dart' as random_data;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';
import 'chatapge2_model.dart';
export 'chatapge2_model.dart';

class Chatapge2Widget extends StatefulWidget {
  const Chatapge2Widget({
    Key? key,
    required this.character,
    required this.chat,
    required this.characterProfile,
    required this.characterName,
    required this.prompt,
  }) : super(key: key);

  final DocumentReference? character;
  final DocumentReference? chat;
  final String? characterProfile;
  final String? characterName;
  final String? prompt;

  @override
  _Chatapge2WidgetState createState() => _Chatapge2WidgetState();
}

class _Chatapge2WidgetState extends State<Chatapge2Widget>
    with TickerProviderStateMixin {
  late Chatapge2Model _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => Chatapge2Model());

    logFirebaseEvent('screen_view', parameters: {'screen_name': 'chatapge2'});
    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      logFirebaseEvent('CHATAPGE2_PAGE_chatapge2_ON_INIT_STATE');
      logFirebaseEvent('chatapge2_scroll_to');
      await _model.listViewController?.animateTo(
        _model.listViewController!.position.maxScrollExtent,
        duration: Duration(milliseconds: 1),
        curve: Curves.ease,
      );
      logFirebaseEvent('chatapge2_scroll_to');
      await _model.columnController?.animateTo(
        _model.columnController!.position.maxScrollExtent,
        duration: Duration(milliseconds: 1),
        curve: Curves.ease,
      );
    });

    _model.fullNameController ??= TextEditingController();
    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();
    final lottieAnimationController = AnimationController(vsync: this);
    return StreamBuilder<ChatsRecord>(
      stream: ChatsRecord.getDocument(widget.chat!),
      builder: (context, snapshot) {
        // Customize what your widget looks like when it's loading.
        if (!snapshot.hasData) {
          return Scaffold(
            backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
            body: Center(
              child: SizedBox(
                width: 50.0,
                height: 50.0,
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                    FlutterFlowTheme.of(context).primary,
                  ),
                ),
              ),
            ),
          );
        }
        final chatapge2ChatsRecord = snapshot.data!;
        return GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(_model.unfocusNode),
          child: Scaffold(
            key: scaffoldKey,
            backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
            body: SafeArea(
              top: true,
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0xFFABC0D1),
                ),
                child: Stack(
                  children: [
                    Align(
                      alignment: AlignmentDirectional(0.0, 0.0),
                      child: Lottie.network(
                        'https://lottie.host/1fe9dc8b-ffc6-4623-97bc-0ac46ebdb7b8/FFKuouyTVc.json',
                        width: 300.0,
                        height: 500.0,
                        fit: BoxFit.cover,
                        controller: lottieAnimationController,
                        onLoaded: (composition) => lottieAnimationController
                            .duration = composition.duration,
                      ),
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            FlutterFlowIconButton(
                              borderColor: Colors.transparent,
                              borderRadius: 30.0,
                              borderWidth: 1.0,
                              buttonSize: 60.0,
                              icon: Icon(
                                Icons.arrow_back_rounded,
                                color: Color(0xFF101417),
                                size: 30.0,
                              ),
                              onPressed: () async {
                                logFirebaseEvent(
                                    'CHATAPGE2_arrow_back_rounded_ICN_ON_TAP');
                                logFirebaseEvent('IconButton_navigate_to');

                                context.pushNamed('AllChatsPage');
                              },
                            ),
                            Column(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.characterName!,
                                  style: FlutterFlowTheme.of(context)
                                      .headlineMedium
                                      .override(
                                        fontFamily: 'NIXGON',
                                        color: Color(0xFF101417),
                                        fontSize: 22.0,
                                        useGoogleFonts: false,
                                      ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0.0, 4.0, 0.0, 0.0),
                                  child: LinearPercentIndicator(
                                    percent: chatapge2ChatsRecord.loveNumber,
                                    width: 300.0,
                                    lineHeight: 18.0,
                                    animation: true,
                                    progressColor: Color(0xFFFDE500),
                                    backgroundColor:
                                        FlutterFlowTheme.of(context).accent4,
                                    barRadius: Radius.circular(10.0),
                                    padding: EdgeInsets.zero,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Expanded(
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Expanded(
                                child: SingleChildScrollView(
                                  controller: _model.columnController,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            20.0, 0.0, 20.0, 10.0),
                                        child: StreamBuilder<
                                            List<ChatMessagesRecord>>(
                                          stream: queryChatMessagesRecord(
                                            queryBuilder:
                                                (chatMessagesRecord) =>
                                                    chatMessagesRecord
                                                        .where('chat',
                                                            isEqualTo:
                                                                widget.chat)
                                                        .orderBy('timestamp'),
                                          ),
                                          builder: (context, snapshot) {
                                            // Customize what your widget looks like when it's loading.
                                            if (!snapshot.hasData) {
                                              return Center(
                                                child: SizedBox(
                                                  width: 50.0,
                                                  height: 50.0,
                                                  child:
                                                      CircularProgressIndicator(
                                                    valueColor:
                                                        AlwaysStoppedAnimation<
                                                            Color>(
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .primary,
                                                    ),
                                                  ),
                                                ),
                                              );
                                            }
                                            List<ChatMessagesRecord>
                                                listViewChatMessagesRecordList =
                                                snapshot.data!;
                                            return ListView.builder(
                                              padding: EdgeInsets.zero,
                                              primary: false,
                                              shrinkWrap: true,
                                              scrollDirection: Axis.vertical,
                                              itemCount:
                                                  listViewChatMessagesRecordList
                                                      .length,
                                              itemBuilder:
                                                  (context, listViewIndex) {
                                                final listViewChatMessagesRecord =
                                                    listViewChatMessagesRecordList[
                                                        listViewIndex];
                                                return Column(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  children: [
                                                    if (listViewChatMessagesRecord
                                                            .ai ==
                                                        true)
                                                      Padding(
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    0.0,
                                                                    10.0,
                                                                    0.0,
                                                                    0.0),
                                                        child: Row(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Container(
                                                              width: 45.0,
                                                              height: 45.0,
                                                              clipBehavior: Clip
                                                                  .antiAlias,
                                                              decoration:
                                                                  BoxDecoration(
                                                                shape: BoxShape
                                                                    .circle,
                                                              ),
                                                              child:
                                                                  Image.network(
                                                                widget
                                                                    .characterProfile!,
                                                                fit: BoxFit
                                                                    .cover,
                                                              ),
                                                            ),
                                                            Column(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .max,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Padding(
                                                                  padding: EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          16.0,
                                                                          0.0,
                                                                          0.0,
                                                                          0.0),
                                                                  child: Text(
                                                                    widget
                                                                        .characterName!,
                                                                    style: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyMedium
                                                                        .override(
                                                                          fontFamily:
                                                                              'NIXGON',
                                                                          color:
                                                                              Color(0xFF637380),
                                                                          useGoogleFonts:
                                                                              false,
                                                                        ),
                                                                  ),
                                                                ),
                                                                Row(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .max,
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .end,
                                                                  children: [
                                                                    Padding(
                                                                      padding: EdgeInsetsDirectional.fromSTEB(
                                                                          8.0,
                                                                          4.0,
                                                                          0.0,
                                                                          0.0),
                                                                      child:
                                                                          Container(
                                                                        decoration:
                                                                            BoxDecoration(
                                                                          color:
                                                                              FlutterFlowTheme.of(context).secondaryBackground,
                                                                          borderRadius:
                                                                              BorderRadius.only(
                                                                            bottomLeft:
                                                                                Radius.circular(24.0),
                                                                            bottomRight:
                                                                                Radius.circular(24.0),
                                                                            topLeft:
                                                                                Radius.circular(3.0),
                                                                            topRight:
                                                                                Radius.circular(24.0),
                                                                          ),
                                                                        ),
                                                                        child:
                                                                            Padding(
                                                                          padding: EdgeInsetsDirectional.fromSTEB(
                                                                              16.0,
                                                                              12.0,
                                                                              16.0,
                                                                              12.0),
                                                                          child:
                                                                              Row(
                                                                            mainAxisSize:
                                                                                MainAxisSize.max,
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.spaceBetween,
                                                                            children: [
                                                                              Column(
                                                                                mainAxisSize: MainAxisSize.max,
                                                                                mainAxisAlignment: MainAxisAlignment.center,
                                                                                children: [
                                                                                  Wrap(
                                                                                    spacing: 0.0,
                                                                                    runSpacing: 0.0,
                                                                                    alignment: WrapAlignment.start,
                                                                                    crossAxisAlignment: WrapCrossAlignment.start,
                                                                                    direction: Axis.horizontal,
                                                                                    runAlignment: WrapAlignment.start,
                                                                                    verticalDirection: VerticalDirection.down,
                                                                                    clipBehavior: Clip.none,
                                                                                    children: [
                                                                                      Container(
                                                                                        constraints: BoxConstraints(
                                                                                          maxWidth: 200.0,
                                                                                          maxHeight: double.infinity,
                                                                                        ),
                                                                                        decoration: BoxDecoration(
                                                                                          color: FlutterFlowTheme.of(context).secondaryBackground,
                                                                                        ),
                                                                                        child: Text(
                                                                                          listViewChatMessagesRecord.text,
                                                                                          style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                fontFamily: 'NIXGON',
                                                                                                color: Color(0xFF202020),
                                                                                                useGoogleFonts: false,
                                                                                                lineHeight: 1.2,
                                                                                              ),
                                                                                        ),
                                                                                      ),
                                                                                    ],
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Padding(
                                                                      padding: EdgeInsetsDirectional.fromSTEB(
                                                                          4.0,
                                                                          0.0,
                                                                          0.0,
                                                                          0.0),
                                                                      child:
                                                                          Text(
                                                                        dateTimeFormat(
                                                                          'relative',
                                                                          listViewChatMessagesRecord
                                                                              .timestamp!,
                                                                          locale:
                                                                              FFLocalizations.of(context).languageCode,
                                                                        ),
                                                                        style: FlutterFlowTheme.of(context)
                                                                            .bodyMedium
                                                                            .override(
                                                                              fontFamily: 'NIXGON',
                                                                              color: Color(0xFF687A88),
                                                                              fontSize: 10.0,
                                                                              useGoogleFonts: false,
                                                                            ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                                if (listViewChatMessagesRecord
                                                                            .image !=
                                                                        null &&
                                                                    listViewChatMessagesRecord
                                                                            .image !=
                                                                        '')
                                                                  Padding(
                                                                    padding: EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            16.0,
                                                                            10.0,
                                                                            0.0,
                                                                            0.0),
                                                                    child:
                                                                        Container(
                                                                      width:
                                                                          215.0,
                                                                      height:
                                                                          150.0,
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        color: FlutterFlowTheme.of(context)
                                                                            .secondaryBackground,
                                                                        image:
                                                                            DecorationImage(
                                                                          fit: BoxFit
                                                                              .cover,
                                                                          image:
                                                                              Image.network(
                                                                            listViewChatMessagesRecord.image,
                                                                          ).image,
                                                                        ),
                                                                        borderRadius:
                                                                            BorderRadius.only(
                                                                          bottomLeft:
                                                                              Radius.circular(24.0),
                                                                          bottomRight:
                                                                              Radius.circular(24.0),
                                                                          topLeft:
                                                                              Radius.circular(3.0),
                                                                          topRight:
                                                                              Radius.circular(24.0),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    if (listViewChatMessagesRecord
                                                            .ai ==
                                                        false)
                                                      Padding(
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    0.0,
                                                                    10.0,
                                                                    0.0,
                                                                    0.0),
                                                        child: Row(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .end,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Container(
                                                              decoration:
                                                                  BoxDecoration(),
                                                              child: Row(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .max,
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .end,
                                                                children: [
                                                                  Padding(
                                                                    padding: EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            4.0,
                                                                            0.0,
                                                                            0.0,
                                                                            0.0),
                                                                    child: Text(
                                                                      dateTimeFormat(
                                                                        'relative',
                                                                        listViewChatMessagesRecord
                                                                            .timestamp!,
                                                                        locale:
                                                                            FFLocalizations.of(context).languageCode,
                                                                      ),
                                                                      style: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodyMedium
                                                                          .override(
                                                                            fontFamily:
                                                                                'NIXGON',
                                                                            color:
                                                                                Color(0xFF687A88),
                                                                            fontSize:
                                                                                10.0,
                                                                            useGoogleFonts:
                                                                                false,
                                                                          ),
                                                                    ),
                                                                  ),
                                                                  Wrap(
                                                                    spacing:
                                                                        0.0,
                                                                    runSpacing:
                                                                        0.0,
                                                                    alignment:
                                                                        WrapAlignment
                                                                            .start,
                                                                    crossAxisAlignment:
                                                                        WrapCrossAlignment
                                                                            .start,
                                                                    direction: Axis
                                                                        .vertical,
                                                                    runAlignment:
                                                                        WrapAlignment
                                                                            .start,
                                                                    verticalDirection:
                                                                        VerticalDirection
                                                                            .down,
                                                                    clipBehavior:
                                                                        Clip.none,
                                                                    children: [
                                                                      Padding(
                                                                        padding: EdgeInsetsDirectional.fromSTEB(
                                                                            8.0,
                                                                            4.0,
                                                                            0.0,
                                                                            0.0),
                                                                        child:
                                                                            Container(
                                                                          constraints:
                                                                              BoxConstraints(
                                                                            maxWidth:
                                                                                MediaQuery.sizeOf(context).width * 3.0,
                                                                            maxHeight:
                                                                                double.infinity,
                                                                          ),
                                                                          decoration:
                                                                              BoxDecoration(
                                                                            color:
                                                                                Color(0xFFFDE500),
                                                                            borderRadius:
                                                                                BorderRadius.only(
                                                                              bottomLeft: Radius.circular(24.0),
                                                                              bottomRight: Radius.circular(24.0),
                                                                              topLeft: Radius.circular(24.0),
                                                                              topRight: Radius.circular(3.0),
                                                                            ),
                                                                          ),
                                                                          child:
                                                                              Padding(
                                                                            padding: EdgeInsetsDirectional.fromSTEB(
                                                                                16.0,
                                                                                12.0,
                                                                                16.0,
                                                                                12.0),
                                                                            child:
                                                                                Row(
                                                                              mainAxisSize: MainAxisSize.min,
                                                                              mainAxisAlignment: MainAxisAlignment.end,
                                                                              children: [
                                                                                Column(
                                                                                  mainAxisSize: MainAxisSize.min,
                                                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                                                  crossAxisAlignment: CrossAxisAlignment.end,
                                                                                  children: [
                                                                                    Wrap(
                                                                                      spacing: 0.0,
                                                                                      runSpacing: 0.0,
                                                                                      alignment: WrapAlignment.start,
                                                                                      crossAxisAlignment: WrapCrossAlignment.start,
                                                                                      direction: Axis.horizontal,
                                                                                      runAlignment: WrapAlignment.start,
                                                                                      verticalDirection: VerticalDirection.down,
                                                                                      clipBehavior: Clip.none,
                                                                                      children: [
                                                                                        Container(
                                                                                          constraints: BoxConstraints(
                                                                                            maxWidth: 200.0,
                                                                                            maxHeight: double.infinity,
                                                                                          ),
                                                                                          decoration: BoxDecoration(),
                                                                                          child: Text(
                                                                                            listViewChatMessagesRecord.text,
                                                                                            textAlign: TextAlign.start,
                                                                                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                  fontFamily: 'NIXGON',
                                                                                                  color: Color(0xFF202020),
                                                                                                  useGoogleFonts: false,
                                                                                                  lineHeight: 1.2,
                                                                                                ),
                                                                                          ),
                                                                                        ),
                                                                                      ],
                                                                                    ),
                                                                                  ],
                                                                                ),
                                                                              ],
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                  ],
                                                );
                                              },
                                              controller:
                                                  _model.listViewController,
                                            );
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Container(
                              width: MediaQuery.sizeOf(context).width * 1.0,
                              decoration: BoxDecoration(
                                color: FlutterFlowTheme.of(context)
                                    .secondaryBackground,
                              ),
                              child: Container(
                                width: double.infinity,
                                constraints: BoxConstraints(
                                  maxWidth: 570.0,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      blurRadius: 3.0,
                                      color: Color(0x33000000),
                                      offset: Offset(0.0, -1.0),
                                    )
                                  ],
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          8.0, 8.0, 0.0, 8.0),
                                      child: FlutterFlowIconButton(
                                        borderColor: Colors.transparent,
                                        borderRadius: 8.0,
                                        borderWidth: 1.0,
                                        buttonSize: 44.0,
                                        icon: Icon(
                                          Icons.add,
                                          color: Color(0xFF57636C),
                                          size: 24.0,
                                        ),
                                        onPressed: () {
                                          print('IconButton pressed ...');
                                        },
                                      ),
                                    ),
                                    Expanded(
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: FlutterFlowTheme.of(context)
                                              .secondaryBackground,
                                        ),
                                        child: Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  5.0, 5.0, 8.0, 5.0),
                                          child: TextFormField(
                                            controller:
                                                _model.fullNameController,
                                            obscureText: false,
                                            decoration: InputDecoration(
                                              labelStyle: FlutterFlowTheme.of(
                                                      context)
                                                  .bodySmall
                                                  .override(
                                                    fontFamily: 'NIXGON',
                                                    color: Color(0xFF57636C),
                                                    fontSize: 14.0,
                                                    fontWeight: FontWeight.w500,
                                                    useGoogleFonts: false,
                                                  ),
                                              hintStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .bodySmall
                                                      .override(
                                                        fontFamily: 'Inter',
                                                        color:
                                                            Color(0xFF57636C),
                                                        fontSize: 14.0,
                                                        fontWeight:
                                                            FontWeight.normal,
                                                      ),
                                              enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: Color(0xFFF8F8F8),
                                                  width: 1.0,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(12.0),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: Color(0x00000000),
                                                  width: 1.0,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(12.0),
                                              ),
                                              errorBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: Color(0x00000000),
                                                  width: 1.0,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(12.0),
                                              ),
                                              focusedErrorBorder:
                                                  OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: Color(0x00000000),
                                                  width: 1.0,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(12.0),
                                              ),
                                              filled: true,
                                              fillColor: Color(0xFFF8F8F8),
                                              contentPadding:
                                                  EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          12.0, 8.0, 20.0, 8.0),
                                            ),
                                            style: FlutterFlowTheme.of(context)
                                                .bodyMedium
                                                .override(
                                                  fontFamily: 'NIXGON',
                                                  color: Color(0xFF111417),
                                                  fontSize: 14.0,
                                                  fontWeight: FontWeight.normal,
                                                  useGoogleFonts: false,
                                                ),
                                            maxLines: 5,
                                            minLines: 1,
                                            validator: _model
                                                .fullNameControllerValidator
                                                .asValidator(context),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      controller: _model.rowController,
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Align(
                                            alignment:
                                                AlignmentDirectional(0.0, 1.0),
                                            child: Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(8.0, 8.0, 8.0, 8.0),
                                              child: FlutterFlowIconButton(
                                                borderColor: Color(0xFFFFE302),
                                                borderRadius: 30.0,
                                                borderWidth: 3.0,
                                                buttonSize: 45.0,
                                                fillColor: Color(0xFFFFE302),
                                                icon: Icon(
                                                  Icons.arrow_upward_sharp,
                                                  color: Colors.black,
                                                  size: 30.0,
                                                ),
                                                onPressed: () async {
                                                  logFirebaseEvent(
                                                      'CHATAPGE2_arrow_upward_sharp_ICN_ON_TAP');
                                                  // createUserMessage
                                                  logFirebaseEvent(
                                                      'IconButton_createUserMessage');

                                                  var chatMessagesRecordReference1 =
                                                      ChatMessagesRecord
                                                          .collection
                                                          .doc();
                                                  await chatMessagesRecordReference1
                                                      .set({
                                                    ...createChatMessagesRecordData(
                                                      user:
                                                          currentUserReference,
                                                      chat: widget.chat,
                                                      text: _model
                                                          .fullNameController
                                                          .text,
                                                      ai: false,
                                                      nextPrompt:
                                                          '${widget.prompt} \\n상대방 : ${_model.fullNameController.text} \\n남사친 :',
                                                      image: '',
                                                    ),
                                                    'timestamp': FieldValue
                                                        .serverTimestamp(),
                                                  });
                                                  _model.createUserMessage =
                                                      ChatMessagesRecord
                                                          .getDocumentFromData({
                                                    ...createChatMessagesRecordData(
                                                      user:
                                                          currentUserReference,
                                                      chat: widget.chat,
                                                      text: _model
                                                          .fullNameController
                                                          .text,
                                                      ai: false,
                                                      nextPrompt:
                                                          '${widget.prompt} \\n상대방 : ${_model.fullNameController.text} \\n남사친 :',
                                                      image: '',
                                                    ),
                                                    'timestamp': DateTime.now(),
                                                  }, chatMessagesRecordReference1);
                                                  logFirebaseEvent(
                                                      'IconButton_scroll_to');
                                                  await _model
                                                      .listViewController
                                                      ?.animateTo(
                                                    _model
                                                        .listViewController!
                                                        .position
                                                        .maxScrollExtent,
                                                    duration: Duration(
                                                        milliseconds: 1),
                                                    curve: Curves.ease,
                                                  );
                                                  logFirebaseEvent(
                                                      'IconButton_scroll_to');
                                                  await _model.columnController
                                                      ?.animateTo(
                                                    _model
                                                        .columnController!
                                                        .position
                                                        .maxScrollExtent,
                                                    duration: Duration(
                                                        milliseconds: 1),
                                                    curve: Curves.ease,
                                                  );
                                                  logFirebaseEvent(
                                                      'IconButton_clear_text_fields');
                                                  setState(() {
                                                    _model.fullNameController
                                                        ?.clear();
                                                  });
                                                  logFirebaseEvent(
                                                      'IconButton_backend_call');
                                                  _model.apiResult94f =
                                                      await ClovaCall.call(
                                                    text: _model
                                                        .createUserMessage
                                                        ?.nextPrompt,
                                                  );
                                                  if ((_model.apiResult94f
                                                          ?.succeeded ??
                                                      true)) {
                                                    // createAIMessage
                                                    logFirebaseEvent(
                                                        'IconButton_createAIMessage');

                                                    var chatMessagesRecordReference2 =
                                                        ChatMessagesRecord
                                                            .collection
                                                            .doc();
                                                    await chatMessagesRecordReference2
                                                        .set({
                                                      ...createChatMessagesRecordData(
                                                        user:
                                                            currentUserReference,
                                                        chat: widget.chat,
                                                        text: getJsonField(
                                                          (_model.apiResult94f
                                                                  ?.jsonBody ??
                                                              ''),
                                                          r'''$.result.outputText''',
                                                        ).toString(),
                                                        ai: true,
                                                        nextPrompt:
                                                            '${_model.createUserMessage?.nextPrompt}${getJsonField(
                                                          (_model.apiResult94f
                                                                  ?.jsonBody ??
                                                              ''),
                                                          r'''$.result.outputText''',
                                                        ).toString()}',
                                                        image: '',
                                                      ),
                                                      'timestamp': FieldValue
                                                          .serverTimestamp(),
                                                    });
                                                    _model.createAIMessage =
                                                        ChatMessagesRecord
                                                            .getDocumentFromData({
                                                      ...createChatMessagesRecordData(
                                                        user:
                                                            currentUserReference,
                                                        chat: widget.chat,
                                                        text: getJsonField(
                                                          (_model.apiResult94f
                                                                  ?.jsonBody ??
                                                              ''),
                                                          r'''$.result.outputText''',
                                                        ).toString(),
                                                        ai: true,
                                                        nextPrompt:
                                                            '${_model.createUserMessage?.nextPrompt}${getJsonField(
                                                          (_model.apiResult94f
                                                                  ?.jsonBody ??
                                                              ''),
                                                          r'''$.result.outputText''',
                                                        ).toString()}',
                                                        image: '',
                                                      ),
                                                      'timestamp':
                                                          DateTime.now(),
                                                    }, chatMessagesRecordReference2);
                                                    // updateChat
                                                    logFirebaseEvent(
                                                        'IconButton_updateChat');

                                                    await widget.chat!.update({
                                                      ...createChatsRecordData(
                                                        lastMessage: _model
                                                            .createAIMessage
                                                            ?.text,
                                                        prompt: _model
                                                            .createAIMessage
                                                            ?.nextPrompt,
                                                      ),
                                                      'last_message_time':
                                                          FieldValue
                                                              .serverTimestamp(),
                                                      'love_number':
                                                          FieldValue.increment(
                                                              random_data
                                                                  .randomDouble(
                                                                      0.01,
                                                                      0.1)),
                                                    });
                                                  } else {
                                                    logFirebaseEvent(
                                                        'IconButton_show_snack_bar');
                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .showSnackBar(
                                                      SnackBar(
                                                        content: Text(
                                                          'error',
                                                          style: TextStyle(
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .primaryText,
                                                          ),
                                                        ),
                                                        duration: Duration(
                                                            milliseconds: 4000),
                                                        backgroundColor:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .secondary,
                                                      ),
                                                    );
                                                  }

                                                  logFirebaseEvent(
                                                      'IconButton_scroll_to');
                                                  await _model
                                                      .listViewController
                                                      ?.animateTo(
                                                    _model
                                                        .listViewController!
                                                        .position
                                                        .maxScrollExtent,
                                                    duration: Duration(
                                                        milliseconds: 1),
                                                    curve: Curves.ease,
                                                  );
                                                  logFirebaseEvent(
                                                      'IconButton_scroll_to');
                                                  await _model.columnController
                                                      ?.animateTo(
                                                    _model
                                                        .columnController!
                                                        .position
                                                        .maxScrollExtent,
                                                    duration: Duration(
                                                        milliseconds: 1),
                                                    curve: Curves.ease,
                                                  );
                                                  logFirebaseEvent(
                                                      'IconButton_lottie_animation');
                                                  await lottieAnimationController
                                                      .forward();
                                                  lottieAnimationController
                                                      .reset();

                                                  setState(() {});
                                                },
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
