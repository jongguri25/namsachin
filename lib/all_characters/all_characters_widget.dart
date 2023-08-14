import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/push_notifications/push_notifications_util.dart';
import '/components/no_more_card_widget.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_swipeable_stack.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
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

  final animationsMap = {
    'swipeableStackOnActionTriggerAnimation': AnimationInfo(
      trigger: AnimationTrigger.onActionTrigger,
      applyInitialState: true,
      effects: [
        ScaleEffect(
          curve: Curves.easeInOut,
          delay: 0.ms,
          duration: 600.ms,
          begin: Offset(1.0, 1.0),
          end: Offset(1.0, 1.0),
        ),
      ],
    ),
  };

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => AllCharactersModel());

    logFirebaseEvent('screen_view',
        parameters: {'screen_name': 'AllCharacters'});
    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      logFirebaseEvent('ALL_CHARACTERS_AllCharacters_ON_INIT_STA');
      if (dateTimeFormat(
            'yMd',
            currentUserDocument?.updatedDate,
            locale: FFLocalizations.of(context).languageCode,
          ) !=
          dateTimeFormat(
            'yMd',
            getCurrentTimestamp,
            locale: FFLocalizations.of(context).languageCode,
          )) {
        logFirebaseEvent('AllCharacters_backend_call');

        await currentUserReference!.update(createUsersRecordData(
          dailyCharacterMet: 0,
          updatedDate: getCurrentTimestamp,
        ));
      }
    });

    setupAnimations(
      animationsMap.values.where((anim) =>
          anim.trigger == AnimationTrigger.onActionTrigger ||
          !anim.applyInitialState),
      this,
    );

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
                    if (valueOrDefault(
                            currentUserDocument?.dailyCharacterMet, 0) <=
                        10)
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
                            if (swipeableStackCharacterRecordList.isEmpty) {
                              return Container(
                                width: double.infinity,
                                height: double.infinity,
                                child: NoMoreCardWidget(),
                              );
                            }
                            return FlutterFlowSwipeableStack(
                              topCardHeightFraction: 1.0,
                              middleCardHeightFraction: 0.0,
                              bottomCardHeightFraction: 0.0,
                              topCardWidthFraction: 1.0,
                              middleCardWidthFraction: 0.0,
                              bottomCardWidthFraction: 0.0,
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
                                  'dailyCharacterMet': FieldValue.increment(1),
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
                                        '${swipeableStackCharacterRecordList[index]?.description}${swipeableStackCharacterRecordList[index]?.introMessage1}\\n남사친 : ${swipeableStackCharacterRecordList[index]?.introMessage2}',
                                    userMessageCount: 0,
                                    imageCount: 1,
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
                                        '${swipeableStackCharacterRecordList[index]?.description}${swipeableStackCharacterRecordList[index]?.introMessage1}\\n남사친 : ${swipeableStackCharacterRecordList[index]?.introMessage2}',
                                    userMessageCount: 0,
                                    imageCount: 1,
                                  ),
                                  'last_message_time': DateTime.now(),
                                }, chatsRecordReference);
                                // createMessage1
                                logFirebaseEvent(
                                    'SwipeableStack_createMessage1');

                                var chatMessagesRecordReference1 =
                                    ChatMessagesRecord.collection.doc();
                                await chatMessagesRecordReference1.set({
                                  ...createChatMessagesRecordData(
                                    user: currentUserReference,
                                    chat: _model.chatMade?.reference,
                                    text:
                                        swipeableStackCharacterRecordList[index]
                                            ?.introMessage1,
                                    ai: true,
                                    nextPrompt: '',
                                  ),
                                  'timestamp': FieldValue.serverTimestamp(),
                                });
                                _model.createMessage1 =
                                    ChatMessagesRecord.getDocumentFromData({
                                  ...createChatMessagesRecordData(
                                    user: currentUserReference,
                                    chat: _model.chatMade?.reference,
                                    text:
                                        swipeableStackCharacterRecordList[index]
                                            ?.introMessage1,
                                    ai: true,
                                    nextPrompt: '',
                                  ),
                                  'timestamp': DateTime.now(),
                                }, chatMessagesRecordReference1);
                                // createMessage2
                                logFirebaseEvent(
                                    'SwipeableStack_createMessage2');

                                var chatMessagesRecordReference2 =
                                    ChatMessagesRecord.collection.doc();
                                await chatMessagesRecordReference2.set({
                                  ...createChatMessagesRecordData(
                                    user: currentUserReference,
                                    chat: _model.chatMade?.reference,
                                    text:
                                        swipeableStackCharacterRecordList[index]
                                            ?.introMessage2,
                                    ai: true,
                                    nextPrompt:
                                        '${swipeableStackCharacterRecordList[index]?.description}${swipeableStackCharacterRecordList[index]?.introMessage1}\\n남사친 : ${swipeableStackCharacterRecordList[index]?.introMessage2}',
                                    image:
                                        swipeableStackCharacterRecordList[index]
                                            ?.profileImage,
                                    imageNumber: 1,
                                  ),
                                  'timestamp': FieldValue.serverTimestamp(),
                                });
                                _model.createMessage2 =
                                    ChatMessagesRecord.getDocumentFromData({
                                  ...createChatMessagesRecordData(
                                    user: currentUserReference,
                                    chat: _model.chatMade?.reference,
                                    text:
                                        swipeableStackCharacterRecordList[index]
                                            ?.introMessage2,
                                    ai: true,
                                    nextPrompt:
                                        '${swipeableStackCharacterRecordList[index]?.description}${swipeableStackCharacterRecordList[index]?.introMessage1}\\n남사친 : ${swipeableStackCharacterRecordList[index]?.introMessage2}',
                                    image:
                                        swipeableStackCharacterRecordList[index]
                                            ?.profileImage,
                                    imageNumber: 1,
                                  ),
                                  'timestamp': DateTime.now(),
                                }, chatMessagesRecordReference2);
                                // updateCount
                                logFirebaseEvent('SwipeableStack_updateCount');

                                await currentUserReference!.update({
                                  'characterMet': FieldValue.increment(1),
                                  'dailyCharacterMet': FieldValue.increment(1),
                                });
                                logFirebaseEvent(
                                    'SwipeableStack_lottie_animation');
                                await lottieAnimationController.forward();
                                lottieAnimationController.reset();
                                logFirebaseEvent(
                                    'SwipeableStack_show_snack_bar');
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      '매치 성공! 채팅을 시작하세요',
                                      style: TextStyle(
                                        color: FlutterFlowTheme.of(context)
                                            .primaryText,
                                      ),
                                    ),
                                    duration: Duration(milliseconds: 5000),
                                    backgroundColor:
                                        FlutterFlowTheme.of(context).secondary,
                                    action: SnackBarAction(
                                      label: '채팅',
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
                                              _model.chatMade,
                                              ParamType.Document,
                                            ),
                                            'characterProfile': serializeParam(
                                              swipeableStackCharacterRecordList[
                                                      index]
                                                  ?.profileImage,
                                              ParamType.String,
                                            ),
                                            'characterName': serializeParam(
                                              swipeableStackCharacterRecordList[
                                                      index]
                                                  ?.name,
                                              ParamType.String,
                                            ),
                                            'prompt': serializeParam(
                                              _model.chatMade?.prompt,
                                              ParamType.String,
                                            ),
                                            'chatReference': serializeParam(
                                              _model.chatMade?.reference,
                                              ParamType.DocumentReference,
                                            ),
                                          }.withoutNulls,
                                          extra: <String, dynamic>{
                                            'chat': _model.chatMade,
                                          },
                                        );
                                      },
                                    ),
                                  ),
                                );
                                // push_1message
                                logFirebaseEvent(
                                    'SwipeableStack_push_1message');
                                triggerPushNotification(
                                  notificationTitle: '남사친',
                                  notificationText: _model.createMessage1!.text,
                                  userRefs: [currentUserReference!],
                                  initialPageName: 'chatapge2',
                                  parameterData: {
                                    'character':
                                        swipeableStackCharacterRecordList[index]
                                            ?.reference,
                                    'chatReference': _model.chatMade?.reference,
                                    'characterProfile':
                                        swipeableStackCharacterRecordList[index]
                                            ?.profileImage,
                                    'prompt': _model.chatMade?.prompt,
                                    'chat': _model.chatMade,
                                    'characterName':
                                        swipeableStackCharacterRecordList[index]
                                            ?.name,
                                  },
                                );
                                logFirebaseEvent('SwipeableStack_wait__delay');
                                await Future.delayed(
                                    const Duration(milliseconds: 2000));
                                // push_2message
                                logFirebaseEvent(
                                    'SwipeableStack_push_2message');
                                triggerPushNotification(
                                  notificationTitle: '남사친',
                                  notificationText: _model.createMessage2!.text,
                                  userRefs: [currentUserReference!],
                                  initialPageName: 'chatapge2',
                                  parameterData: {
                                    'character':
                                        swipeableStackCharacterRecordList[index]
                                            ?.reference,
                                    'chatReference': _model.chatMade?.reference,
                                    'characterProfile':
                                        swipeableStackCharacterRecordList[index]
                                            ?.profileImage,
                                    'prompt': _model.chatMade?.prompt,
                                    'chat': _model.chatMade,
                                    'characterName':
                                        swipeableStackCharacterRecordList[index]
                                            ?.name,
                                  },
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
                                        alignment:
                                            AlignmentDirectional(0.0, 1.0),
                                        children: [
                                          ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                            child: Image.network(
                                              swipeableStackCharacterRecord
                                                  .profileImage,
                                              width: double.infinity,
                                              height: MediaQuery.sizeOf(context)
                                                      .height *
                                                  0.7,
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
                                                  style: FlutterFlowTheme.of(
                                                          context)
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
                                            0.0, 20.0, 0.0, 20.0),
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
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(
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
                                                  _model
                                                      .swipeableStackController
                                                      .triggerSwipeRight();
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Text(
                                        valueOrDefault(
                                                currentUserDocument
                                                    ?.characterMet,
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
                              itemCount:
                                  swipeableStackCharacterRecordList.length,
                              controller: _model.swipeableStackController,
                              enableSwipeUp: false,
                              enableSwipeDown: false,
                            ).animateOnActionTrigger(
                              animationsMap[
                                  'swipeableStackOnActionTriggerAnimation']!,
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
                    if (valueOrDefault(
                            currentUserDocument?.dailyCharacterMet, 0) >
                        10)
                      AuthUserStreamWidget(
                        builder: (context) => wrapWithModel(
                          model: _model.noMoreCardModel,
                          updateCallback: () => setState(() {}),
                          child: NoMoreCardWidget(),
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
