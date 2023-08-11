import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_swipeable_stack.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:swipeable_card_stack/swipeable_card_stack.dart';
import 'all_characters_model.dart';
export 'all_characters_model.dart';

class AllCharactersWidget extends StatefulWidget {
  const AllCharactersWidget({Key? key}) : super(key: key);

  @override
  _AllCharactersWidgetState createState() => _AllCharactersWidgetState();
}

class _AllCharactersWidgetState extends State<AllCharactersWidget>
    with TickerProviderStateMixin {
  late AllCharactersModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => AllCharactersModel());

    logFirebaseEvent('screen_view',
        parameters: {'screen_name': 'AllCharacters'});
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
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: Stack(
                  children: [
                    AuthUserStreamWidget(
                      builder: (context) =>
                          StreamBuilder<List<CharacterRecord>>(
                        stream: queryCharacterRecord(
                          queryBuilder: (characterRecord) => characterRecord
                              .where('order',
                                  isGreaterThan: valueOrDefault(
                                      currentUserDocument?.characterMet, 0))
                              .orderBy('order'),
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
                          List<CharacterRecord>
                              swipeableStackCharacterRecordList =
                              snapshot.data!;
                          return FlutterFlowSwipeableStack(
                            topCardHeightFraction: 0.72,
                            middleCardHeightFraction: 0.68,
                            bottomCardHeightFraction: 0.75,
                            topCardWidthFraction: 0.9,
                            middleCardWidthFraction: 0.85,
                            bottomCardWidthFraction: 0.8,
                            onSwipeFn: (index) {},
                            onLeftSwipe: (index) async {
                              logFirebaseEvent(
                                  'ALL_CHARACTERS_SwipeableStack_v1eypxq1_O');
                              final swipeableStackCharacterRecord =
                                  swipeableStackCharacterRecordList[index];
                              logFirebaseEvent('SwipeableStack_backend_call');

                              await MatchRecord.collection.doc().set({
                                ...createMatchRecordData(
                                  character:
                                      swipeableStackCharacterRecordList[index]
                                          ?.reference,
                                  user: currentUserReference,
                                  isMatch: false,
                                ),
                                'updatedDate': FieldValue.serverTimestamp(),
                              });
                              logFirebaseEvent('SwipeableStack_backend_call');

                              await currentUserReference!.update({
                                'characterMet': FieldValue.increment(1),
                              });
                            },
                            onRightSwipe: (index) async {
                              logFirebaseEvent(
                                  'ALL_CHARACTERS_SwipeableStack_v1eypxq1_O');
                              final swipeableStackCharacterRecord =
                                  swipeableStackCharacterRecordList[index];
                              // createMatch
                              logFirebaseEvent('SwipeableStack_createMatch');

                              await MatchRecord.collection.doc().set({
                                ...createMatchRecordData(
                                  character:
                                      swipeableStackCharacterRecordList[index]
                                          ?.reference,
                                  user: currentUserReference,
                                  isMatch: true,
                                ),
                                'updatedDate': FieldValue.serverTimestamp(),
                              });
                              // createChat
                              logFirebaseEvent('SwipeableStack_createChat');

                              var chatsRecordReference =
                                  ChatsRecord.collection.doc();
                              await chatsRecordReference.set({
                                ...createChatsRecordData(
                                  userA: currentUserReference,
                                  character:
                                      swipeableStackCharacterRecordList[index]
                                          ?.reference,
                                  lastMessage:
                                      swipeableStackCharacterRecordList[index]
                                          ?.introMessage2,
                                  loveNumber: 0.1,
                                  prompt:
                                      '‘남사친’은 듬직한 남자 사람 친구 처럼 여자들과 대화해 주는 30살 헬스 트레이너 남자 입니다. 상대방은 남사친을 지성민 으로 부릅니다. 남사친은 듬직한 말투를 사용합니다. 남사친은 가볍게 조언하거나, 가르치려 들지 않고, 상대방의 입장을 공감해 주고 들어주는 것에 집중 합니다. 너무 무섭지 않게 대화 합니다. 상대방의 대화 내용에 맞게, 남사친의 대답을 만들어주세요. 남사친의 대답을 만들 때 질문도 자주 해주세요. 남사친의 대답을 만들 때 5글자 이상으로 길게 만들어주세요. 남사친은 상대방의 관심사에 따라 이야기 합니다. \\n남사친 : 안녕 앞으로 잘 부탁해! \\n상대방 : 고마워 \\n남사친 : 잘부탁합니당 \\n상대방 : 그래 \\n남사친 : 오늘도 힘내고 기운차게 보내자\\n상대방 :응응 \\n남사친 : ${swipeableStackCharacterRecordList[index]?.introMessage1}\\n남사친 : ${swipeableStackCharacterRecordList[index]?.introMessage2}',
                                  userMessageCount: 0,
                                ),
                                'last_message_time':
                                    FieldValue.serverTimestamp(),
                              });
                              _model.chatMade =
                                  ChatsRecord.getDocumentFromData({
                                ...createChatsRecordData(
                                  userA: currentUserReference,
                                  character:
                                      swipeableStackCharacterRecordList[index]
                                          ?.reference,
                                  lastMessage:
                                      swipeableStackCharacterRecordList[index]
                                          ?.introMessage2,
                                  loveNumber: 0.1,
                                  prompt:
                                      '‘남사친’은 듬직한 남자 사람 친구 처럼 여자들과 대화해 주는 30살 헬스 트레이너 남자 입니다. 상대방은 남사친을 지성민 으로 부릅니다. 남사친은 듬직한 말투를 사용합니다. 남사친은 가볍게 조언하거나, 가르치려 들지 않고, 상대방의 입장을 공감해 주고 들어주는 것에 집중 합니다. 너무 무섭지 않게 대화 합니다. 상대방의 대화 내용에 맞게, 남사친의 대답을 만들어주세요. 남사친의 대답을 만들 때 질문도 자주 해주세요. 남사친의 대답을 만들 때 5글자 이상으로 길게 만들어주세요. 남사친은 상대방의 관심사에 따라 이야기 합니다. \\n남사친 : 안녕 앞으로 잘 부탁해! \\n상대방 : 고마워 \\n남사친 : 잘부탁합니당 \\n상대방 : 그래 \\n남사친 : 오늘도 힘내고 기운차게 보내자\\n상대방 :응응 \\n남사친 : ${swipeableStackCharacterRecordList[index]?.introMessage1}\\n남사친 : ${swipeableStackCharacterRecordList[index]?.introMessage2}',
                                  userMessageCount: 0,
                                ),
                                'last_message_time': DateTime.now(),
                              }, chatsRecordReference);
                              // createMessage1
                              logFirebaseEvent('SwipeableStack_createMessage1');

                              await ChatMessagesRecord.collection.doc().set({
                                ...createChatMessagesRecordData(
                                  user: currentUserReference,
                                  chat: _model.chatMade?.reference,
                                  text: swipeableStackCharacterRecordList[index]
                                      ?.introMessage1,
                                  ai: true,
                                  nextPrompt: '',
                                ),
                                'timestamp': FieldValue.serverTimestamp(),
                              });
                              // createMessage2
                              logFirebaseEvent('SwipeableStack_createMessage2');

                              await ChatMessagesRecord.collection.doc().set({
                                ...createChatMessagesRecordData(
                                  user: currentUserReference,
                                  chat: _model.chatMade?.reference,
                                  text: swipeableStackCharacterRecordList[index]
                                      ?.introMessage2,
                                  ai: true,
                                  nextPrompt:
                                      '‘남사친’은 듬직한 남자 사람 친구 처럼 여자들과 대화해 주는 30살 헬스 트레이너 남자 입니다. 상대방은 남사친을 지성민 으로 부릅니다. 남사친은 듬직한 말투를 사용합니다. 남사친은 가볍게 조언하거나, 가르치려 들지 않고, 상대방의 입장을 공감해 주고 들어주는 것에 집중 합니다. 너무 무섭지 않게 대화 합니다. 상대방의 대화 내용에 맞게, 남사친의 대답을 만들어주세요. 남사친의 대답을 만들 때 질문도 자주 해주세요. 남사친의 대답을 만들 때 5글자 이상으로 길게 만들어주세요. 남사친은 상대방의 관심사에 따라 이야기 합니다. \\n남사친 : 안녕 앞으로 잘 부탁해! \\n상대방 : 고마워 \\n남사친 : 잘부탁합니당 \\n상대방 : 그래 \\n남사친 : 오늘도 힘내고 기운차게 보내자\\n상대방 :응응 \\n남사친 : ${swipeableStackCharacterRecordList[index]?.introMessage1}\\n남사친 : ${swipeableStackCharacterRecordList[index]?.introMessage2}',
                                  image:
                                      swipeableStackCharacterRecordList[index]
                                          ?.profileImage,
                                ),
                                'timestamp': FieldValue.serverTimestamp(),
                              });
                              // updateCount
                              logFirebaseEvent('SwipeableStack_updateCount');

                              await currentUserReference!.update({
                                'characterMet': FieldValue.increment(1),
                              });
                              logFirebaseEvent(
                                  'SwipeableStack_lottie_animation');
                              await lottieAnimationController.forward();
                              lottieAnimationController.reset();
                              logFirebaseEvent('SwipeableStack_show_snack_bar');
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    '매칭이 되었습니다! 채팅을 시작해보세요',
                                    style: TextStyle(
                                      fontFamily: 'NIXGON',
                                      color: FlutterFlowTheme.of(context)
                                          .primaryText,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  duration: Duration(milliseconds: 4000),
                                  backgroundColor:
                                      FlutterFlowTheme.of(context).secondary,
                                  action: SnackBarAction(
                                    label: '채팅하기',
                                    textColor: Colors.white,
                                    onPressed: () async {
                                      context.pushNamed(
                                        'chatapge2',
                                        queryParameters: {
                                          'character': serializeParam(
                                            swipeableStackCharacterRecordList[
                                                    index]
                                                ?.reference,
                                            ParamType.DocumentReference,
                                          ),
                                          'chat': serializeParam(
                                            _model.chatMade?.reference,
                                            ParamType.DocumentReference,
                                          ),
                                          'characterProfile': serializeParam(
                                            '',
                                            ParamType.String,
                                          ),
                                          'characterName': serializeParam(
                                            '',
                                            ParamType.String,
                                          ),
                                          'prompt': serializeParam(
                                            '',
                                            ParamType.String,
                                          ),
                                        }.withoutNulls,
                                      );
                                    },
                                  ),
                                ),
                              );

                              setState(() {});
                            },
                            onUpSwipe: (index) {},
                            onDownSwipe: (index) {},
                            itemBuilder: (context, swipeableStackIndex) {
                              final swipeableStackCharacterRecord =
                                  swipeableStackCharacterRecordList[
                                      swipeableStackIndex];
                              return Card(
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                color: FlutterFlowTheme.of(context)
                                    .secondaryBackground,
                                elevation: 4.0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Stack(
                                      alignment: AlignmentDirectional(0.0, 1.0),
                                      children: [
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                          child: Image.network(
                                            swipeableStackCharacterRecord
                                                .profileImage,
                                            width: double.infinity,
                                            height: 500.0,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  20.0, 0.0, 0.0, 20.0),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Text(
                                                swipeableStackCharacterRecord
                                                    .name,
                                                style:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily: 'NIXGON',
                                                          color: Colors.white,
                                                          fontSize: 32.0,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          useGoogleFonts: false,
                                                        ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0.0, 20.0, 0.0, 0.0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          FlutterFlowIconButton(
                                            borderColor: Color(0xFFFF2E54),
                                            borderRadius: 100.0,
                                            borderWidth: 1.0,
                                            buttonSize: 60.0,
                                            icon: Icon(
                                              Icons.cancel,
                                              color: Color(0xFFFF2E54),
                                              size: 45.0,
                                            ),
                                            onPressed: () async {
                                              logFirebaseEvent(
                                                  'ALL_CHARACTERS_PAGE_cancel_ICN_ON_TAP');
                                              logFirebaseEvent(
                                                  'IconButton_swipeable_stack');
                                              _model.swipeableStackController
                                                  .triggerSwipeLeft();
                                            },
                                          ),
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    40.0, 0.0, 0.0, 0.0),
                                            child: FlutterFlowIconButton(
                                              borderColor: Color(0xFF28E7AB),
                                              borderRadius: 100.0,
                                              borderWidth: 1.0,
                                              buttonSize: 60.0,
                                              icon: Icon(
                                                Icons.favorite,
                                                color: Color(0xFF28E7AB),
                                                size: 45.0,
                                              ),
                                              onPressed: () async {
                                                logFirebaseEvent(
                                                    'ALL_CHARACTERS_PAGE_favorite_ICN_ON_TAP');
                                                logFirebaseEvent(
                                                    'IconButton_swipeable_stack');
                                                _model.swipeableStackController
                                                    .triggerSwipeRight();
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Text(
                                      valueOrDefault(
                                              currentUserDocument?.characterMet,
                                              0)
                                          .toString(),
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            fontFamily: 'Open Sans',
                                            color: Colors.white,
                                          ),
                                    ),
                                  ],
                                ),
                              );
                            },
                            itemCount: swipeableStackCharacterRecordList.length,
                            controller: _model.swipeableStackController,
                            enableSwipeUp: false,
                            enableSwipeDown: false,
                          );
                        },
                      ),
                    ),
                    Align(
                      alignment: AlignmentDirectional(0.0, 0.0),
                      child: Lottie.network(
                        'https://lottie.host/91b6cbfc-0508-4555-8188-670797d5f8e3/yNZmPXwIwa.json',
                        width: 300.0,
                        height: 300.0,
                        fit: BoxFit.cover,
                        controller: lottieAnimationController,
                        onLoaded: (composition) => lottieAnimationController
                            .duration = composition.duration,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
