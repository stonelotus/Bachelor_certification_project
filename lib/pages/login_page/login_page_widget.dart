import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:licenta_main/models/user_model.dart';
import 'package:licenta_main/services/auth_service.dart';
import 'package:licenta_main/services/firestore_service.dart';
import 'package:web3dart/credentials.dart';

import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'login_page_model.dart';
export 'login_page_model.dart';

class LoginPageWidget extends StatefulWidget {
  const LoginPageWidget({Key? key}) : super(key: key);

  @override
  _LoginPageWidgetState createState() => _LoginPageWidgetState();
}

class _LoginPageWidgetState extends State<LoginPageWidget>
    with TickerProviderStateMixin {
  late LoginPageModel _model;
  final AuthService _authService = AuthService();

  final scaffoldKey = GlobalKey<ScaffoldState>();

  final animationsMap = {
    'rowOnPageLoadAnimation': AnimationInfo(
      trigger: AnimationTrigger.onPageLoad,
      effects: [
        VisibilityEffect(duration: 100.ms),
        FadeEffect(
          curve: Curves.easeInOut,
          delay: 100.ms,
          duration: 600.ms,
          begin: 0.0,
          end: 1.0,
        ),
        MoveEffect(
          curve: Curves.easeInOut,
          delay: 100.ms,
          duration: 600.ms,
          begin: Offset(0.0, 20.0),
          end: Offset(0.0, 0.0),
        ),
      ],
    ),
    'containerOnPageLoadAnimation': AnimationInfo(
      trigger: AnimationTrigger.onPageLoad,
      effects: [
        VisibilityEffect(duration: 1.ms),
        FadeEffect(
          curve: Curves.easeInOut,
          delay: 0.ms,
          duration: 600.ms,
          begin: 0.0,
          end: 1.0,
        ),
        MoveEffect(
          curve: Curves.easeInOut,
          delay: 0.ms,
          duration: 600.ms,
          begin: Offset(0.0, 60.0),
          end: Offset(0.0, 0.0),
        ),
      ],
    ),
    'tabBarOnPageLoadAnimation': AnimationInfo(
      trigger: AnimationTrigger.onPageLoad,
      effects: [
        VisibilityEffect(duration: 200.ms),
        FadeEffect(
          curve: Curves.easeInOut,
          delay: 200.ms,
          duration: 600.ms,
          begin: 0.0,
          end: 1.0,
        ),
        MoveEffect(
          curve: Curves.easeInOut,
          delay: 200.ms,
          duration: 600.ms,
          begin: Offset(0.0, 30.0),
          end: Offset(0.0, 0.0),
        ),
      ],
    ),
  };

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => LoginPageModel());

    _model.emailAddressController ??= TextEditingController();
    _model.passwordController ??= TextEditingController();
    _model.emailAddressCreateController ??= TextEditingController();
    _model.passwordCreateController ??= TextEditingController();
    setupAnimations(
      animationsMap.values.where((anim) =>
          anim.trigger == AnimationTrigger.onActionTrigger ||
          !anim.applyInitialState),
      this,
    );
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  // Code for checkbox
  bool isChecked = false;

  Color getColor(Set<MaterialState> states) {
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.pressed,
      MaterialState.hovered,
      MaterialState.focused,
    };
    if (states.any(interactiveStates.contains)) {
      return Colors.blue;
    }
    return Colors.red;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          alignment: AlignmentDirectional(0.0, 1.0),
          children: [
            Align(
              alignment: AlignmentDirectional(1.0, -1.4),
              child: Container(
                width: 500.0,
                height: 500.0,
                decoration: BoxDecoration(
                  color: FlutterFlowTheme.of(context).tertiary,
                  shape: BoxShape.circle,
                ),
              ),
            ),
            if (responsiveVisibility(
              context: context,
              tabletLandscape: false,
              desktop: false,
            ))
              Align(
                alignment: AlignmentDirectional(-2.0, -1.5),
                child: Container(
                  width: 350.0,
                  height: 350.0,
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).primary,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            if (responsiveVisibility(
              context: context,
              phone: false,
              tablet: false,
            ))
              Align(
                alignment: AlignmentDirectional(-1.25, -1.5),
                child: Container(
                  width: 600.0,
                  height: 600.0,
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).primary,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            if (responsiveVisibility(
              context: context,
              tabletLandscape: false,
              desktop: false,
            ))
              Align(
                alignment: AlignmentDirectional(2.5, -1.2),
                child: Container(
                  width: 300.0,
                  height: 300.0,
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).secondary,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            if (responsiveVisibility(
              context: context,
              phone: false,
              tablet: false,
            ))
              Align(
                alignment: AlignmentDirectional(1.0, -0.95),
                child: Container(
                  width: 700.0,
                  height: 700.0,
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).secondary,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            Align(
              alignment: AlignmentDirectional(0.0, 1.0),
              child: ClipRRect(
                child: BackdropFilter(
                  filter: ImageFilter.blur(
                    sigmaX: 40.0,
                    sigmaY: 40.0,
                  ),
                  child: Align(
                    alignment: AlignmentDirectional(0.0, 1.0),
                    child: Container(
                      width: double.infinity,
                      height: double.infinity,
                      alignment: AlignmentDirectional(0.0, 1.0),
                      child: Align(
                        alignment: AlignmentDirectional(0.0, 1.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 64.0, 0.0, 24.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Stack(
                                    children: [
                                      Image.asset(
                                        'assets/images/main_logo_licenta.png',
                                        width: 380.0,
                                        height: 250.0,
                                        fit: BoxFit.fitWidth,
                                      ),
                                    ],
                                  ),
                                ],
                              ).animateOnPageLoad(
                                  animationsMap['rowOnPageLoadAnimation']!),
                            ),
                            Expanded(
                              child: Align(
                                alignment: AlignmentDirectional(0.0, 1.0),
                                child: Container(
                                  width: double.infinity,
                                  height: 500.0,
                                  constraints: BoxConstraints(
                                    maxWidth: 570.0,
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(16.0),
                                  ),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        child: DefaultTabController(
                                          length: 2,
                                          initialIndex: 0,
                                          child: Column(
                                            children: [
                                              Align(
                                                alignment: Alignment(0.0, 0),
                                                child: TabBar(
                                                  isScrollable: true,
                                                  labelColor:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .primaryText,
                                                  unselectedLabelColor:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .secondaryText,
                                                  labelPadding:
                                                      EdgeInsetsDirectional
                                                          .fromSTEB(24.0, 0.0,
                                                              24.0, 0.0),
                                                  labelStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .titleMedium,
                                                  indicatorColor:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .secondary,
                                                  indicatorWeight: 2.0,
                                                  tabs: [
                                                    Tab(
                                                      text: 'Sign In',
                                                    ),
                                                    Tab(
                                                      text: 'Sign Up',
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Expanded(
                                                child: TabBarView(
                                                  children: [
                                                    SignInTab(
                                                        model: _model,
                                                        authService:
                                                            _authService),
                                                    SingleChildScrollView(
                                                      child: Column(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        24.0,
                                                                        20.0,
                                                                        24.0,
                                                                        0.0),
                                                            child:
                                                                TextFormField(
                                                              controller: _model
                                                                  .emailAddressCreateController,
                                                              obscureText:
                                                                  false,
                                                              decoration:
                                                                  InputDecoration(
                                                                labelText:
                                                                    'Email Address',
                                                                labelStyle:
                                                                    FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodySmall,
                                                                hintText:
                                                                    'Enter your email...',
                                                                hintStyle: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodySmall,
                                                                enabledBorder:
                                                                    OutlineInputBorder(
                                                                  borderSide:
                                                                      BorderSide(
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .lineColor,
                                                                    width: 1.0,
                                                                  ),
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              8.0),
                                                                ),
                                                                focusedBorder:
                                                                    OutlineInputBorder(
                                                                  borderSide:
                                                                      BorderSide(
                                                                    color: Color(
                                                                        0x00000000),
                                                                    width: 1.0,
                                                                  ),
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              8.0),
                                                                ),
                                                                errorBorder:
                                                                    OutlineInputBorder(
                                                                  borderSide:
                                                                      BorderSide(
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .primary,
                                                                    width: 1.0,
                                                                  ),
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              8.0),
                                                                ),
                                                                focusedErrorBorder:
                                                                    OutlineInputBorder(
                                                                  borderSide:
                                                                      BorderSide(
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .primary,
                                                                    width: 1.0,
                                                                  ),
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              8.0),
                                                                ),
                                                                filled: true,
                                                                fillColor: FlutterFlowTheme.of(
                                                                        context)
                                                                    .primaryBackground,
                                                                contentPadding:
                                                                    EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            20.0,
                                                                            24.0,
                                                                            20.0,
                                                                            24.0),
                                                              ),
                                                              style: FlutterFlowTheme
                                                                      .of(context)
                                                                  .bodyMedium,
                                                              validator: _model
                                                                  .emailAddressCreateControllerValidator
                                                                  .asValidator(
                                                                      context),
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        24.0,
                                                                        12.0,
                                                                        24.0,
                                                                        0.0),
                                                            child:
                                                                TextFormField(
                                                              controller: _model
                                                                  .passwordCreateController,
                                                              obscureText: !_model
                                                                  .passwordCreateVisibility,
                                                              decoration:
                                                                  InputDecoration(
                                                                labelText:
                                                                    'Password',
                                                                labelStyle:
                                                                    FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodySmall,
                                                                hintText:
                                                                    'Enter your password...',
                                                                hintStyle: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodySmall,
                                                                enabledBorder:
                                                                    OutlineInputBorder(
                                                                  borderSide:
                                                                      BorderSide(
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .lineColor,
                                                                    width: 1.0,
                                                                  ),
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              8.0),
                                                                ),
                                                                focusedBorder:
                                                                    OutlineInputBorder(
                                                                  borderSide:
                                                                      BorderSide(
                                                                    color: Color(
                                                                        0x00000000),
                                                                    width: 1.0,
                                                                  ),
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              8.0),
                                                                ),
                                                                errorBorder:
                                                                    OutlineInputBorder(
                                                                  borderSide:
                                                                      BorderSide(
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .primary,
                                                                    width: 1.0,
                                                                  ),
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              8.0),
                                                                ),
                                                                focusedErrorBorder:
                                                                    OutlineInputBorder(
                                                                  borderSide:
                                                                      BorderSide(
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .primary,
                                                                    width: 1.0,
                                                                  ),
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              8.0),
                                                                ),
                                                                filled: true,
                                                                fillColor: FlutterFlowTheme.of(
                                                                        context)
                                                                    .primaryBackground,
                                                                contentPadding:
                                                                    EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            20.0,
                                                                            24.0,
                                                                            20.0,
                                                                            24.0),
                                                                suffixIcon:
                                                                    InkWell(
                                                                  onTap: () =>
                                                                      setState(
                                                                    () => _model
                                                                            .passwordCreateVisibility =
                                                                        !_model
                                                                            .passwordCreateVisibility,
                                                                  ),
                                                                  focusNode: FocusNode(
                                                                      skipTraversal:
                                                                          true),
                                                                  child: Icon(
                                                                    _model.passwordCreateVisibility
                                                                        ? Icons
                                                                            .visibility_outlined
                                                                        : Icons
                                                                            .visibility_off_outlined,
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .secondaryText,
                                                                    size: 20.0,
                                                                  ),
                                                                ),
                                                              ),
                                                              style: FlutterFlowTheme
                                                                      .of(context)
                                                                  .bodyMedium,
                                                              validator: _model
                                                                  .passwordCreateControllerValidator
                                                                  .asValidator(
                                                                      context),
                                                            ),
                                                          ),
                                                          Padding(
                                                              padding:
                                                                  EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          24.0,
                                                                          12.0,
                                                                          24.0,
                                                                          0.0),
                                                              child: Row(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .max,
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .center,
                                                                children: [
                                                                  Text(
                                                                      "I am an organizer"),
                                                                  Checkbox(
                                                                    checkColor:
                                                                        Colors
                                                                            .white,
                                                                    fillColor: MaterialStateProperty
                                                                        .resolveWith(
                                                                            getColor),
                                                                    value:
                                                                        isChecked,
                                                                    onChanged:
                                                                        (bool?
                                                                            value) {
                                                                      setState(
                                                                          () {
                                                                        isChecked =
                                                                            value!;
                                                                      });
                                                                    },
                                                                  ),
                                                                ],
                                                              )),
                                                          Padding(
                                                            padding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        0.0,
                                                                        16.0,
                                                                        0.0,
                                                                        0.0),
                                                            child:
                                                                FFButtonWidget(
                                                              onPressed:
                                                                  () async {
                                                                print(
                                                                    'Button-SIGN UP pressed ...');
                                                                if (isChecked ==
                                                                    false) {
                                                                  var response = await AuthService().signUpWithEmailAndPassword(
                                                                      _model
                                                                          .emailAddressCreateController
                                                                          .text,
                                                                      _model
                                                                          .passwordCreateController
                                                                          .text);
                                                                  print("SIGN UP STATUS: " +
                                                                      response
                                                                          .toString());
                                                                } else {
                                                                  var response = await AuthService().signUpWithEmailAndPasswordOrganizer(
                                                                      _model
                                                                          .emailAddressCreateController
                                                                          .text,
                                                                      _model
                                                                          .passwordCreateController
                                                                          .text);
                                                                  print("SIGN UP STATUS: " +
                                                                      response
                                                                          .toString());
                                                                }
                                                              },
                                                              text:
                                                                  'Create Account',
                                                              options:
                                                                  FFButtonOptions(
                                                                width: 190.0,
                                                                height: 50.0,
                                                                padding:
                                                                    EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            0.0,
                                                                            0.0,
                                                                            0.0,
                                                                            0.0),
                                                                iconPadding:
                                                                    EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            0.0,
                                                                            0.0,
                                                                            0.0,
                                                                            0.0),
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .secondary,
                                                                textStyle: FlutterFlowTheme.of(
                                                                        context)
                                                                    .titleSmall
                                                                    .override(
                                                                      fontFamily:
                                                                          'Poppins',
                                                                      color: FlutterFlowTheme.of(
                                                                              context)
                                                                          .primaryBtnText,
                                                                    ),
                                                                elevation: 3.0,
                                                                borderSide:
                                                                    BorderSide(
                                                                  color: Colors
                                                                      .transparent,
                                                                  width: 1.0,
                                                                ),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            50.0),
                                                              ),
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        20.0,
                                                                        0.0,
                                                                        20.0,
                                                                        0.0),
                                                            child: Row(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .max,
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Padding(
                                                                  padding: EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          0.0,
                                                                          12.0,
                                                                          0.0,
                                                                          0.0),
                                                                  child: Text(
                                                                    isChecked
                                                                        ? 'Social account sign up is not available \nfor Organizers'
                                                                        : 'Sign up using a social account',
                                                                    style: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodySmall,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          isChecked == false
                                                              ? Padding(
                                                                  padding: EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          0.0,
                                                                          4.0,
                                                                          0.0,
                                                                          0.0),
                                                                  child: Row(
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .max,
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .center,
                                                                    children: [
                                                                      Padding(
                                                                        padding: EdgeInsetsDirectional.fromSTEB(
                                                                            8.0,
                                                                            8.0,
                                                                            8.0,
                                                                            8.0),
                                                                        child:
                                                                            FlutterFlowIconButton(
                                                                          borderColor:
                                                                              FlutterFlowTheme.of(context).lineColor,
                                                                          borderRadius:
                                                                              12.0,
                                                                          borderWidth:
                                                                              1.0,
                                                                          buttonSize:
                                                                              44.0,
                                                                          icon:
                                                                              FaIcon(
                                                                            FontAwesomeIcons.google,
                                                                            color:
                                                                                FlutterFlowTheme.of(context).primaryText,
                                                                            size:
                                                                                16.0,
                                                                          ),
                                                                          onPressed:
                                                                              () {
                                                                            print('IconButton pressed ...');
                                                                          },
                                                                        ),
                                                                      ),
                                                                      // Padding(
                                                                      //   padding: EdgeInsetsDirectional
                                                                      //       .fromSTEB(
                                                                      //           8.0,
                                                                      //           8.0,
                                                                      //           8.0,
                                                                      //           8.0),
                                                                      //   child:
                                                                      //       FlutterFlowIconButton(
                                                                      //     borderColor:
                                                                      //         FlutterFlowTheme.of(context)
                                                                      //             .lineColor,
                                                                      //     borderRadius:
                                                                      //         12.0,
                                                                      //     borderWidth:
                                                                      //         1.0,
                                                                      //     buttonSize:
                                                                      //         44.0,
                                                                      //     icon:
                                                                      //         FaIcon(
                                                                      //       FontAwesomeIcons
                                                                      //           .apple,
                                                                      //       color: FlutterFlowTheme.of(
                                                                      //               context)
                                                                      //           .primaryText,
                                                                      //       size:
                                                                      //           16.0,
                                                                      //     ),
                                                                      //     onPressed:
                                                                      //         () {
                                                                      //       print(
                                                                      //           'IconButton pressed ...');
                                                                      //     },
                                                                      //   ),
                                                                      // ),
                                                                      // Padding(
                                                                      //   padding: EdgeInsetsDirectional
                                                                      //       .fromSTEB(
                                                                      //           8.0,
                                                                      //           8.0,
                                                                      //           8.0,
                                                                      //           8.0),
                                                                      //   child:
                                                                      //       FlutterFlowIconButton(
                                                                      //     borderColor:
                                                                      //         FlutterFlowTheme.of(context)
                                                                      //             .lineColor,
                                                                      //     borderRadius:
                                                                      //         12.0,
                                                                      //     borderWidth:
                                                                      //         1.0,
                                                                      //     buttonSize:
                                                                      //         44.0,
                                                                      //     icon: Icon(
                                                                      //       Icons
                                                                      //           .supervisor_account_outlined,
                                                                      //       color: FlutterFlowTheme.of(
                                                                      //               context)
                                                                      //           .primaryText,
                                                                      //       size:
                                                                      //           20.0,
                                                                      //     ),
                                                                      //     onPressed:
                                                                      //         () {
                                                                      //       print(
                                                                      //           'IconButton pressed ...');
                                                                      //     },
                                                                      //   ),
                                                                      // ),
                                                                    ],
                                                                  ),
                                                                )
                                                              : Container(),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ).animateOnPageLoad(animationsMap[
                                            'tabBarOnPageLoadAnimation']!),
                                      ),
                                    ],
                                  ),
                                ).animateOnPageLoad(animationsMap[
                                    'containerOnPageLoadAnimation']!),
                              ),
                            ),
                            if (responsiveVisibility(
                              context: context,
                              phone: false,
                              tablet: false,
                            ))
                              Container(
                                width: 200.0,
                                height: 200.0,
                                decoration: BoxDecoration(),
                              ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SignInTab extends StatefulWidget {
  const SignInTab({
    Key? key,
    required LoginPageModel model,
    required AuthService authService,
  })  : _model = model,
        _authService = authService,
        super(key: key);

  final LoginPageModel _model;
  final AuthService _authService;

  @override
  State<SignInTab> createState() => _SignInTabState();
}

class _SignInTabState extends State<SignInTab> {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentDirectional(0.2, 0.0),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(24.0, 20.0, 24.0, 0.0),
              child: TextFormField(
                controller: widget._model.emailAddressController,
                obscureText: false,
                decoration: InputDecoration(
                  labelText: 'Email Address',
                  labelStyle: FlutterFlowTheme.of(context).bodySmall,
                  hintText: 'Enter your email...',
                  hintStyle: FlutterFlowTheme.of(context).bodySmall,
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: FlutterFlowTheme.of(context).lineColor,
                      width: 1.0,
                    ),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0x00000000),
                      width: 1.0,
                    ),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: FlutterFlowTheme.of(context).primary,
                      width: 1.0,
                    ),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: FlutterFlowTheme.of(context).primary,
                      width: 1.0,
                    ),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  filled: true,
                  fillColor: FlutterFlowTheme.of(context).primaryBackground,
                  contentPadding:
                      EdgeInsetsDirectional.fromSTEB(20.0, 24.0, 20.0, 24.0),
                ),
                style: FlutterFlowTheme.of(context).bodyMedium,
                validator: widget._model.emailAddressControllerValidator
                    .asValidator(context),
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(24.0, 12.0, 24.0, 0.0),
              child: TextFormField(
                controller: widget._model.passwordController,
                obscureText: !widget._model.passwordVisibility,
                decoration: InputDecoration(
                  labelText: 'Password',
                  labelStyle: FlutterFlowTheme.of(context).bodySmall,
                  hintText: 'Enter your password...',
                  hintStyle: FlutterFlowTheme.of(context).bodySmall,
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: FlutterFlowTheme.of(context).lineColor,
                      width: 1.0,
                    ),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0x00000000),
                      width: 1.0,
                    ),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: FlutterFlowTheme.of(context).primary,
                      width: 1.0,
                    ),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: FlutterFlowTheme.of(context).primary,
                      width: 1.0,
                    ),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  filled: true,
                  fillColor: FlutterFlowTheme.of(context).primaryBackground,
                  contentPadding:
                      EdgeInsetsDirectional.fromSTEB(20.0, 24.0, 20.0, 24.0),
                  suffixIcon: InkWell(
                    onTap: () => setState(
                      () => widget._model.passwordVisibility =
                          !widget._model.passwordVisibility,
                    ),
                    focusNode: FocusNode(skipTraversal: true),
                    child: Icon(
                      widget._model.passwordVisibility
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined,
                      color: FlutterFlowTheme.of(context).secondaryText,
                      size: 20.0,
                    ),
                  ),
                ),
                style: FlutterFlowTheme.of(context).bodyMedium,
                validator: widget._model.passwordControllerValidator
                    .asValidator(context),
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(24.0, 16.0, 24.0, 0.0),
              child: Wrap(
                spacing: 24.0,
                runSpacing: 8.0,
                alignment: WrapAlignment.center,
                crossAxisAlignment: WrapCrossAlignment.center,
                direction: Axis.horizontal,
                runAlignment: WrapAlignment.center,
                verticalDirection: VerticalDirection.down,
                clipBehavior: Clip.none,
                children: [
                  FFButtonWidget(
                    onPressed: () {
                      print('Button-ForgotPassword pressed ...');
                    },
                    text: 'Forgot Password?',
                    options: FFButtonOptions(
                      width: 140.0,
                      height: 40.0,
                      padding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                      iconPadding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                      color: FlutterFlowTheme.of(context).secondaryBackground,
                      textStyle:
                          FlutterFlowTheme.of(context).bodySmall.override(
                                fontFamily: 'Poppins',
                                fontSize: 12.0,
                              ),
                      elevation: 0.0,
                      borderSide: BorderSide(
                        color: Colors.transparent,
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(50.0),
                    ),
                  ),
                  FFButtonWidget(
                    onPressed: () async {
                      print('Button-Login pressed ...');
                      final dbUser = await AuthService()
                          .signInWithEmailAndPassword(
                              widget._model.emailAddressController.text,
                              widget._model.passwordController.text);
                      if (dbUser == null) {
                        return;
                      }
                      final storage = new FlutterSecureStorage();
                      // await storage
                      //     .deleteAll();
                      String pk = await storage.read(key: "pk") ?? "";
                      String publicK =
                          await storage.read(key: 'publicKey') ?? "";
                      if (pk == "" || publicK == "") {
                        GlobalKey _keyLoader = GlobalKey();

                        String? userInputKey =
                            await showTextInputDialog(context, _keyLoader);
                        if (userInputKey != null) {
                          print(userInputKey.toString());
                          await storage.write(
                              key: "pk", value: userInputKey.toString());
                          await storage.write(
                              key: 'publicKey',
                              value:
                                  EthPrivateKey.fromHex(userInputKey.toString())
                                      .address
                                      .hexEip55);
                        }
                      }

                      final user =
                          (await FirestoreService().getUser(dbUser.uid));
                      var nextPath = "";
                      if (user.isOrganizer == true) {
                        print("is organizer");
                        if (user.isVerified == true) {
                          nextPath = "OrganizerHomePage";
                        }
                      } else {
                        print("is fan");
                        nextPath = "HomePage";
                      }
                      if (nextPath == "") {
                        return;
                      }
                      context.pushNamed(
                        nextPath,
                        extra: <String, dynamic>{
                          kTransitionInfoKey: TransitionInfo(
                            hasTransition: true,
                            transitionType: PageTransitionType.fade,
                            duration: Duration(milliseconds: 500),
                          ),
                        },
                      );
                    },
                    text: 'Sign In',
                    options: FFButtonOptions(
                      width: 130.0,
                      height: 50.0,
                      padding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                      iconPadding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                      color: FlutterFlowTheme.of(context).secondary,
                      textStyle: FlutterFlowTheme.of(context)
                          .titleSmall
                          .override(
                            fontFamily: 'Poppins',
                            color: FlutterFlowTheme.of(context).primaryBtnText,
                          ),
                      elevation: 3.0,
                      borderSide: BorderSide(
                        color: Colors.transparent,
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(60.0),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 20.0, 0.0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(0.0, 12.0, 0.0, 0.0),
                    child: Text(
                      'Or use a social account to login',
                      style: FlutterFlowTheme.of(context).bodySmall,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0.0, 4.0, 0.0, 0.0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(8.0, 8.0, 8.0, 8.0),
                    child: FlutterFlowIconButton(
                      borderColor: FlutterFlowTheme.of(context).lineColor,
                      borderRadius: 12.0,
                      borderWidth: 1.0,
                      buttonSize: 44.0,
                      icon: FaIcon(
                        FontAwesomeIcons.google,
                        color: FlutterFlowTheme.of(context).primaryText,
                        size: 16.0,
                      ),
                      onPressed: () async {
                        print("Google login button pressed");
                        final User? user =
                            await widget._authService.signInWithGoogle();
                        print(user);
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(8.0, 8.0, 8.0, 8.0),
                    child: FlutterFlowIconButton(
                      borderColor: FlutterFlowTheme.of(context).lineColor,
                      borderRadius: 12.0,
                      borderWidth: 1.0,
                      buttonSize: 44.0,
                      icon: FaIcon(
                        FontAwesomeIcons.apple,
                        color: FlutterFlowTheme.of(context).primaryText,
                        size: 16.0,
                      ),
                      onPressed: () {
                        print('IconButton pressed ...');
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(8.0, 8.0, 8.0, 8.0),
                    child: FlutterFlowIconButton(
                      borderColor: FlutterFlowTheme.of(context).lineColor,
                      borderRadius: 12.0,
                      borderWidth: 1.0,
                      buttonSize: 44.0,
                      icon: Icon(
                        Icons.supervisor_account_outlined,
                        color: FlutterFlowTheme.of(context).primaryText,
                        size: 20.0,
                      ),
                      onPressed: () {
                        print('IconButton pressed ...');
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Future<String?> showTextInputDialog(BuildContext context, GlobalKey key) async {
  final TextEditingController textEditingController = TextEditingController();

  bool? result = await showDialog<bool>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return WillPopScope(
        onWillPop: () async => false,
        child: SimpleDialog(
          key: key,
          backgroundColor: Colors.white,
          children: <Widget>[
            Center(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Please Enter Text",
                      style: TextStyle(color: Colors.blueAccent),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: textEditingController,
                      maxLines: 8,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Enter your text here',
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context)
                          .pop(true); // Close the dialog when you're done
                    },
                    child: Text('Submit'),
                  ),
                ],
              ),
            )
          ],
        ),
      );
    },
  );

  if (result != null && result) {
    // If the user pressed 'Submit', return the entered text
    return textEditingController.text;
  } else {
    // If the user cancelled the dialog without pressing 'Submit', return null
    return null;
  }
}
