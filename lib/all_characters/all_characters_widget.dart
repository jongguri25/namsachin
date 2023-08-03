import '/auth/base_auth_user_provider.dart';
import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'all_characters_model.dart';
export 'all_characters_model.dart';

class AllCharactersWidget extends StatefulWidget {
  const AllCharactersWidget({Key? key}) : super(key: key);

  @override
  _AllCharactersWidgetState createState() => _AllCharactersWidgetState();
}

class _AllCharactersWidgetState extends State<AllCharactersWidget> {
  late AllCharactersModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => AllCharactersModel());
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(_model.unfocusNode),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        appBar: AppBar(
          backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
          automaticallyImplyLeading: false,
          title: Text(
            '남사친',
            style: FlutterFlowTheme.of(context).headlineMedium,
          ),
          actions: [
            Visibility(
              visible: responsiveVisibility(
                context: context,
                phone: false,
                tablet: false,
                tabletLandscape: false,
                desktop: false,
              ),
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 12.0, 0.0),
                child: FlutterFlowIconButton(
                  borderColor: Colors.transparent,
                  borderRadius: 30.0,
                  borderWidth: 1.0,
                  buttonSize: 60.0,
                  icon: Icon(
                    Icons.add_circle_outline_rounded,
                    color: FlutterFlowTheme.of(context).secondaryText,
                    size: 30.0,
                  ),
                  onPressed: () {
                    print('IconButton pressed ...');
                  },
                ),
              ),
            ),
          ],
          centerTitle: false,
          elevation: 0.0,
        ),
        body: SafeArea(
          top: true,
          child: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              color: FlutterFlowTheme.of(context).secondaryBackground,
            ),
            child: Padding(
              padding: EdgeInsetsDirectional.fromSTEB(10.0, 0.0, 10.0, 0.0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(10.0, 10.0, 10.0, 0.0),
                      child: Container(
                        width: double.infinity,
                        height: 90.0,
                        decoration: BoxDecoration(
                          color:
                              FlutterFlowTheme.of(context).secondaryBackground,
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: Image.asset(
                              'assets/images/e61b4fd114be442c9e893028fbd37d96.jpg',
                            ).image,
                          ),
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: FlutterFlowTheme.of(context).secondaryBackground,
                      ),
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            0.0, 20.0, 0.0, 10.0),
                        child: InkWell(
                          splashColor: Colors.transparent,
                          focusColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: () async {
                            context.pushNamed('setting');
                          },
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    10.0, 0.0, 0.0, 0.0),
                                child: AuthUserStreamWidget(
                                  builder: (context) => ClipRRect(
                                    borderRadius: BorderRadius.circular(14.0),
                                    child: Image.network(
                                      loggedIn
                                          ? currentUserPhoto
                                          : 'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/livetest2-hx0jlv/assets/0rsbnw4v226f/image_106.png',
                                      width: 50.0,
                                      height: 50.0,
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                              ),
                              Column(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        16.0, 0.0, 0.0, 0.0),
                                    child: AuthUserStreamWidget(
                                      builder: (context) => Text(
                                        loggedIn
                                            ? currentUserDisplayName
                                            : '로그인해 주세요',
                                        style: FlutterFlowTheme.of(context)
                                            .labelMedium
                                            .override(
                                              fontFamily: 'Open Sans',
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .primaryText,
                                              fontSize: 16.0,
                                              fontWeight: FontWeight.bold,
                                            ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        16.0, 0.0, 0.0, 0.0),
                                    child: Text(
                                      loggedIn ? currentUserEmail : ' ',
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            fontFamily: 'Open Sans',
                                            color: FlutterFlowTheme.of(context)
                                                .secondaryText,
                                            fontSize: 12.0,
                                          ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Divider(
                      thickness: 1.0,
                      color: Color(0xFFE4E4E4),
                    ),
                    Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(10.0, 5.0, 0.0, 0.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Text(
                            '남사친',
                            style: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                                  fontFamily: 'Open Sans',
                                  color: FlutterFlowTheme.of(context)
                                      .secondaryText,
                                  fontWeight: FontWeight.w500,
                                ),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                5.0, 0.0, 0.0, 0.0),
                            child: Text(
                              '4',
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    fontFamily: 'Open Sans',
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryText,
                                    fontWeight: FontWeight.w500,
                                  ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    StreamBuilder<List<CharacterRecord>>(
                      stream: queryCharacterRecord(
                        queryBuilder: (characterRecord) =>
                            characterRecord.orderBy('name'),
                      ),
                      builder: (context, snapshot) {
                        // Customize what your widget looks like when it's loading.
                        if (!snapshot.hasData) {
                          return Center(
                            child: SizedBox(
                              width: 50.0,
                              height: 50.0,
                              child: CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  FlutterFlowTheme.of(context).primary,
                                ),
                              ),
                            ),
                          );
                        }
                        List<CharacterRecord> listViewCharacterRecordList =
                            snapshot.data!;
                        return ListView.builder(
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          itemCount: listViewCharacterRecordList.length,
                          itemBuilder: (context, listViewIndex) {
                            final listViewCharacterRecord =
                                listViewCharacterRecordList[listViewIndex];
                            return Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 10.0, 0.0, 10.0),
                              child: InkWell(
                                splashColor: Colors.transparent,
                                focusColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: () async {
                                  _model.isChatExist =
                                      await queryChatsRecordOnce(
                                    queryBuilder: (chatsRecord) => chatsRecord
                                        .where('user_a',
                                            isEqualTo: currentUserReference)
                                        .where('character',
                                            isEqualTo: listViewCharacterRecord
                                                .reference),
                                    singleRecord: true,
                                  ).then((s) => s.firstOrNull);
                                  if (_model.isChatExist != null) {
                                    context.pushNamed(
                                      'chatapge2',
                                      queryParameters: {
                                        'character': serializeParam(
                                          listViewCharacterRecord.reference,
                                          ParamType.DocumentReference,
                                        ),
                                        'chat': serializeParam(
                                          _model.isChatExist?.reference,
                                          ParamType.DocumentReference,
                                        ),
                                        'characterProfile': serializeParam(
                                          listViewCharacterRecord.profileImage,
                                          ParamType.String,
                                        ),
                                        'characterName': serializeParam(
                                          listViewCharacterRecord.name,
                                          ParamType.String,
                                        ),
                                        'prompt': serializeParam(
                                          _model.isChatExist?.prompt,
                                          ParamType.String,
                                        ),
                                      }.withoutNulls,
                                    );
                                  } else {
                                    // createChat

                                    var chatsRecordReference =
                                        ChatsRecord.collection.doc();
                                    await chatsRecordReference.set({
                                      ...createChatsRecordData(
                                        userA: currentUserReference,
                                        character:
                                            listViewCharacterRecord.reference,
                                        prompt:
                                            '‘남사친’은 듬직한 남자 사람 친구 처럼 여자들과 대화해 주는 30살 헬스 트레이너 남자 입니다. 상대방은 남사친을 지성민 으로 부릅니다. 남사친은 듬직한 말투를 사용합니다. 남사친은 가볍게 조언하거나, 가르치려 들지 않고, 상대방의 입장을 공감해 주고 들어주는 것에 집중 합니다. 너무 무섭지 않게 대화 합니다. 상대방의 대화 내용에 맞게, 남사친의 대답을 만들어주세요. 남사친의 대답을 만들 때 질문도 자주 해주세요. 남사친의 대답을 만들 때 5글자 이상으로 길게 만들어주세요. 남사친은 상대방의 관심사에 따라 이야기 합니다. \\n남사친 : 안녕 앞으로 잘 부탁해! \\n상대방 : 고마워 \\n남사친 : 잘부탁합니당 \\n상대방 : 그래 \\n남사친 : 오늘도 힘내고 기운차게 보내자\\n상대방 :응응 \\n남사친 : ${listViewCharacterRecord.introMessage1} \\n남사친 : ${listViewCharacterRecord.introMessage2}',
                                      ),
                                      'last_message_time':
                                          FieldValue.serverTimestamp(),
                                    });
                                    _model.chatMade =
                                        ChatsRecord.getDocumentFromData({
                                      ...createChatsRecordData(
                                        userA: currentUserReference,
                                        character:
                                            listViewCharacterRecord.reference,
                                        prompt:
                                            '‘남사친’은 듬직한 남자 사람 친구 처럼 여자들과 대화해 주는 30살 헬스 트레이너 남자 입니다. 상대방은 남사친을 지성민 으로 부릅니다. 남사친은 듬직한 말투를 사용합니다. 남사친은 가볍게 조언하거나, 가르치려 들지 않고, 상대방의 입장을 공감해 주고 들어주는 것에 집중 합니다. 너무 무섭지 않게 대화 합니다. 상대방의 대화 내용에 맞게, 남사친의 대답을 만들어주세요. 남사친의 대답을 만들 때 질문도 자주 해주세요. 남사친의 대답을 만들 때 5글자 이상으로 길게 만들어주세요. 남사친은 상대방의 관심사에 따라 이야기 합니다. \\n남사친 : 안녕 앞으로 잘 부탁해! \\n상대방 : 고마워 \\n남사친 : 잘부탁합니당 \\n상대방 : 그래 \\n남사친 : 오늘도 힘내고 기운차게 보내자\\n상대방 :응응 \\n남사친 : ${listViewCharacterRecord.introMessage1} \\n남사친 : ${listViewCharacterRecord.introMessage2}',
                                      ),
                                      'last_message_time': DateTime.now(),
                                    }, chatsRecordReference);
                                    // firstMessage

                                    var chatMessagesRecordReference1 =
                                        ChatMessagesRecord.collection.doc();
                                    await chatMessagesRecordReference1.set({
                                      ...createChatMessagesRecordData(
                                        user: currentUserReference,
                                        chat: _model.chatMade?.reference,
                                        text: listViewCharacterRecord
                                            .introMessage1,
                                        image: '',
                                        ai: true,
                                      ),
                                      'timestamp': FieldValue.serverTimestamp(),
                                    });
                                    _model.firstMessage =
                                        ChatMessagesRecord.getDocumentFromData({
                                      ...createChatMessagesRecordData(
                                        user: currentUserReference,
                                        chat: _model.chatMade?.reference,
                                        text: listViewCharacterRecord
                                            .introMessage1,
                                        image: '',
                                        ai: true,
                                      ),
                                      'timestamp': DateTime.now(),
                                    }, chatMessagesRecordReference1);
                                    // SecondMessage

                                    var chatMessagesRecordReference2 =
                                        ChatMessagesRecord.collection.doc();
                                    await chatMessagesRecordReference2.set({
                                      ...createChatMessagesRecordData(
                                        user: currentUserReference,
                                        chat: _model.chatMade?.reference,
                                        text: listViewCharacterRecord
                                            .introMessage2,
                                        image:
                                            listViewCharacterRecord.intorImage1,
                                        ai: true,
                                      ),
                                      'timestamp': FieldValue.serverTimestamp(),
                                    });
                                    _model.secondMessage =
                                        ChatMessagesRecord.getDocumentFromData({
                                      ...createChatMessagesRecordData(
                                        user: currentUserReference,
                                        chat: _model.chatMade?.reference,
                                        text: listViewCharacterRecord
                                            .introMessage2,
                                        image:
                                            listViewCharacterRecord.intorImage1,
                                        ai: true,
                                      ),
                                      'timestamp': DateTime.now(),
                                    }, chatMessagesRecordReference2);

                                    context.pushNamed(
                                      'chatapge2',
                                      queryParameters: {
                                        'character': serializeParam(
                                          listViewCharacterRecord.reference,
                                          ParamType.DocumentReference,
                                        ),
                                        'chat': serializeParam(
                                          _model.chatMade?.reference,
                                          ParamType.DocumentReference,
                                        ),
                                        'characterProfile': serializeParam(
                                          listViewCharacterRecord.profileImage,
                                          ParamType.String,
                                        ),
                                        'characterName': serializeParam(
                                          listViewCharacterRecord.name,
                                          ParamType.String,
                                        ),
                                        'prompt': serializeParam(
                                          _model.chatMade?.prompt,
                                          ParamType.String,
                                        ),
                                      }.withoutNulls,
                                    );
                                  }

                                  setState(() {});
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                  ),
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        10.0, 0.0, 10.0, 0.0),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  2.0, 2.0, 2.0, 2.0),
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(14.0),
                                            child: Image.network(
                                              listViewCharacterRecord
                                                  .profileImage,
                                              width: 44.0,
                                              height: 44.0,
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    12.0, 0.0, 0.0, 0.0),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  listViewCharacterRecord.name,
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .bodyLarge
                                                      .override(
                                                        fontFamily: 'Open Sans',
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                ),
                                                Text(
                                                  listViewCharacterRecord
                                                      .sangtaeMessage,
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .labelMedium
                                                      .override(
                                                        fontFamily: 'Open Sans',
                                                        fontSize: 12.0,
                                                      ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        if (listViewCharacterRecord.song !=
                                                null &&
                                            listViewCharacterRecord.song != '')
                                          Container(
                                            constraints: BoxConstraints(
                                              maxWidth: 200.0,
                                            ),
                                            decoration: BoxDecoration(
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .secondaryBackground,
                                              borderRadius:
                                                  BorderRadius.circular(20.0),
                                              border: Border.all(
                                                color: Color(0xFF82E48F),
                                              ),
                                            ),
                                            child: Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(6.0, 2.0, 6.0, 2.0),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.min,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: [
                                                  Text(
                                                    listViewCharacterRecord.song
                                                        .maybeHandleOverflow(
                                                            maxChars: 20),
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily:
                                                              'Open Sans',
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .secondaryText,
                                                          fontSize: 12.0,
                                                        ),
                                                  ),
                                                  Icon(
                                                    Icons.play_arrow_outlined,
                                                    color: Color(0xFF82E48F),
                                                    size: 18.0,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
