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

class SignUpTab extends StatefulWidget {
  const SignUpTab({
    Key? key,
    required LoginPageModel model,
  })  : _model = model,
        super(key: key);

  final LoginPageModel _model;

  @override
  State<SignUpTab> createState() => _SignUpTabState();
}

class _SignUpTabState extends State<SignUpTab> {
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
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(24.0, 20.0, 24.0, 0.0),
            child: TextFormField(
              controller: widget._model.emailAddressCreateController,
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
              validator: widget._model.emailAddressCreateControllerValidator
                  .asValidator(context),
            ),
          ),
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(24.0, 12.0, 24.0, 0.0),
            child: TextFormField(
              controller: widget._model.passwordCreateController,
              obscureText: !widget._model.passwordCreateVisibility,
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
                    () => widget._model.passwordCreateVisibility =
                        !widget._model.passwordCreateVisibility,
                  ),
                  focusNode: FocusNode(skipTraversal: true),
                  child: Icon(
                    widget._model.passwordCreateVisibility
                        ? Icons.visibility_outlined
                        : Icons.visibility_off_outlined,
                    color: FlutterFlowTheme.of(context).secondaryText,
                    size: 20.0,
                  ),
                ),
              ),
              style: FlutterFlowTheme.of(context).bodyMedium,
              validator: widget._model.passwordCreateControllerValidator
                  .asValidator(context),
            ),
          ),
          Padding(
              padding: EdgeInsetsDirectional.fromSTEB(24.0, 12.0, 24.0, 0.0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("I am an organizer"),
                  Checkbox(
                    checkColor: Colors.white,
                    fillColor: MaterialStateProperty.resolveWith(getColor),
                    value: isChecked,
                    onChanged: (bool? value) {
                      setState(() {
                        isChecked = value!;
                      });
                    },
                  ),
                ],
              )),
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(0.0, 16.0, 0.0, 0.0),
            child: FFButtonWidget(
              onPressed: () async {
                print('Button-SIGN UP pressed ...');
                if (isChecked == false) {
                  var response = await AuthService().signUpWithEmailAndPassword(
                      widget._model.emailAddressCreateController.text,
                      widget._model.passwordCreateController.text);
                  print("SIGN UP STATUS: " + response.toString());
                } else {
                  var response = await AuthService()
                      .signUpWithEmailAndPasswordOrganizer(
                          widget._model.emailAddressCreateController.text,
                          widget._model.passwordCreateController.text);
                  print("SIGN UP STATUS: " + response.toString());
                }
              },
              text: 'Create Account',
              options: FFButtonOptions(
                width: 190.0,
                height: 50.0,
                padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                iconPadding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                color: FlutterFlowTheme.of(context).secondary,
                textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                      fontFamily: 'Poppins',
                      color: FlutterFlowTheme.of(context).primaryBtnText,
                    ),
                elevation: 3.0,
                borderSide: BorderSide(
                  color: Colors.transparent,
                  width: 1.0,
                ),
                borderRadius: BorderRadius.circular(50.0),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 20.0, 0.0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 12.0, 0.0, 0.0),
                  child: Text(
                    isChecked
                        ? 'Social account sign up is not available \nfor Organizers'
                        : 'Sign up using a social account',
                    style: FlutterFlowTheme.of(context).bodySmall,
                  ),
                ),
              ],
            ),
          ),
          isChecked == false
              ? Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 4.0, 0.0, 0.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding:
                            EdgeInsetsDirectional.fromSTEB(8.0, 8.0, 8.0, 8.0),
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
                          onPressed: () {
                            print('IconButton pressed ...');
                          },
                        ),
                      ),
                      // Padding(
                      //   padding:
                      //       EdgeInsetsDirectional.fromSTEB(8.0, 8.0, 8.0, 8.0),
                      //   child: FlutterFlowIconButton(
                      //     borderColor: FlutterFlowTheme.of(context).lineColor,
                      //     borderRadius: 12.0,
                      //     borderWidth: 1.0,
                      //     buttonSize: 44.0,
                      //     icon: FaIcon(
                      //       FontAwesomeIcons.apple,
                      //       color: FlutterFlowTheme.of(context).primaryText,
                      //       size: 16.0,
                      //     ),
                      //     onPressed: () {
                      //       print('IconButton pressed ...');
                      //     },
                      //   ),
                      // ),
                      // Padding(
                      //   padding:
                      //       EdgeInsetsDirectional.fromSTEB(8.0, 8.0, 8.0, 8.0),
                      //   child: FlutterFlowIconButton(
                      //     borderColor: FlutterFlowTheme.of(context).lineColor,
                      //     borderRadius: 12.0,
                      //     borderWidth: 1.0,
                      //     buttonSize: 44.0,
                      //     icon: Icon(
                      //       Icons.supervisor_account_outlined,
                      //       color: FlutterFlowTheme.of(context).primaryText,
                      //       size: 20.0,
                      //     ),
                      //     onPressed: () {
                      //       print('IconButton pressed ...');
                      //     },
                      //   ),
                      // ),
                    ],
                  ),
                )
              : Container(),
        ],
      ),
    );
  }
}
