import 'dart:ffi';

import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:licenta_main/flutter_flow/flutter_flow_animations.dart';
import 'package:licenta_main/flutter_flow/flutter_flow_icon_button.dart';
import 'package:licenta_main/flutter_flow/flutter_flow_theme.dart';
import 'package:licenta_main/flutter_flow/flutter_flow_util.dart';
import 'package:licenta_main/flutter_flow/flutter_flow_widgets.dart';
import 'package:licenta_main/main.dart';
import 'package:licenta_main/models/event_model.dart';
import 'package:licenta_main/pages/create_event/create_event_model.dart';
import 'package:licenta_main/services/firestore_service.dart';

class CreateEventWidget extends StatefulWidget {
  const CreateEventWidget({Key? key}) : super(key: key);

  @override
  State<CreateEventWidget> createState() => _CreateEventWidgetState();
}

class _CreateEventWidgetState extends State<CreateEventWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  late CreateEventModel _model;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _model = createModel(context, () => CreateEventModel());

    _model.dateController ??= TextEditingController();
    _model.descriptionController ??= TextEditingController();
    _model.generatedByController ??= TextEditingController();
    _model.id ??= TextEditingController();
    _model.locationController ??= TextEditingController();
    _model.ticketCount ??= TextEditingController();
    _model.timeController ??= TextEditingController();
    _model.titleController ??= TextEditingController();
    _model.ticketPrice ??= TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
        body: SafeArea(
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      FlutterFlowTheme.of(context).primary,
                      FlutterFlowTheme.of(context).secondary
                    ],
                    stops: [0.3, 1],
                    begin: AlignmentDirectional(-1.0, -1),
                    end: AlignmentDirectional(0, 2),
                  ),
                ),
              ),
              SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 40.0, 0.0, 0.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Create Event',
                            style: FlutterFlowTheme.of(context).title1.override(
                                fontFamily: 'Poppins', color: Colors.white),
                          )
                        ],
                      ),
                    ),
                    TextInputTile(
                        controller: _model.titleController,
                        labelText: 'Title',
                        hintText: 'Enter title'),
                    TextInputTile(
                        controller: _model.descriptionController,
                        labelText: 'Description',
                        hintText: 'Enter description'),
                    TextInputTile(
                        controller: _model.locationController,
                        labelText: 'Location',
                        hintText: 'Enter location'),
                    TextInputTile(
                        controller: _model.dateController,
                        labelText: 'Date',
                        hintText: 'Enter date'),
                    TextInputTile(
                        controller: _model.timeController,
                        labelText: 'Time',
                        hintText: 'Enter time'),
                    TextInputTile(
                        controller: _model.ticketCount,
                        labelText: 'Ticket Count',
                        hintText: 'Enter ticket count'),
                    TextInputTile(
                        controller: _model.ticketPrice,
                        labelText: 'Ticket Price',
                        hintText: 'Enter ticket price'),
                    Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 16.0, 0.0, 0.0),
                      child: FFButtonWidget(
                        onPressed: () async {
                          print('Creating event ...');
                          print(_model);
                          if (_model.titleController?.text == null ||
                              _model.titleController?.text == "") {
                            debugPrint("Title is null");
                            return;
                          } else if (_model.descriptionController?.text ==
                                  null ||
                              _model.descriptionController?.text == "") {
                            debugPrint("Description is null");
                            return;
                          } else if (_model.locationController?.text == null ||
                              _model.locationController?.text == "") {
                            debugPrint("Location is null");
                            return;
                          } else if (_model.dateController?.text == null ||
                              _model.dateController?.text == "") {
                            debugPrint("Date is null");
                            return;
                          } else if (_model.timeController?.text == null ||
                              _model.timeController?.text == "") {
                            debugPrint("Time is null");
                            return;
                          } else if (_model.ticketCount?.text == null ||
                              _model.ticketCount?.text == "") {
                            debugPrint("Ticket count is null");
                            return;
                          } else if (_model.ticketPrice?.text == null ||
                              _model.ticketPrice?.text == "") {
                            debugPrint(_model.ticketPrice.toString());
                            debugPrint("Ticket price is null");
                            return;
                          }

                          final numberOfEvents =
                              await FirestoreService().getNumberOfEvents();
                          EventModel newEvent = EventModel(
                              id: numberOfEvents + 1,
                              title: _model.titleController?.text ?? "Test",
                              description:
                                  _model.descriptionController?.text ?? "Test",
                              location:
                                  _model.locationController?.text ?? "Test",
                              date: _model.dateController?.text ?? "Test",
                              time: _model.timeController?.text ?? "Test",
                              ticketCount:
                                  int.parse(_model.ticketCount?.text ?? "0"),
                              generatedBy: globalUser.displayName ?? "Iulian",
                              photoUrl: "",
                              ticketPrice:
                                  double.parse(_model.ticketPrice.text),
                              ticketsAvailable:
                                  int.parse(_model.ticketCount?.text ?? "0"));
                          debugPrint("Will write to DB");
                          await FirestoreService()
                              .writeEventToFirestore(newEvent);

                          debugPrint("Event created done");
                          CoolAlert.show(
                              context: context,
                              type: CoolAlertType.success,
                              text: "Success!",
                              onCancelBtnTap: () {
                                print("Cancel Button Tapped");
                                Navigator.of(context, rootNavigator: true)
                                    .pop();
                              },
                              onConfirmBtnTap: () {
                                print("Confirm Button Tapped");
                                context.pushNamed(
                                  'EventPage',
                                  queryParams: {
                                    'eventID': newEvent.id.toString(),
                                  },
                                  extra: <String, dynamic>{
                                    kTransitionInfoKey: TransitionInfo(
                                      hasTransition: true,
                                      transitionType: PageTransitionType.fade,
                                      duration: Duration(milliseconds: 500),
                                    ),
                                  },
                                );
                              });
                        },
                        text: 'Create Event',
                        options: FFButtonOptions(
                          width: 190.0,
                          height: 50.0,
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 0.0, 0.0),
                          iconPadding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 0.0, 0.0),
                          color: FlutterFlowTheme.of(context).secondary,
                          textStyle: FlutterFlowTheme.of(context)
                              .titleSmall
                              .override(
                                fontFamily: 'Poppins',
                                color:
                                    FlutterFlowTheme.of(context).primaryBtnText,
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
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}

class TextInputTile extends StatelessWidget {
  final controller;
  final labelText;
  final hintText;
  const TextInputTile({
    Key? key,
    required this.controller,
    required this.labelText,
    required this.hintText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(24.0, 20.0, 24.0, 0.0),
      child: TextFormField(
        controller: controller,
        obscureText: false,
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle: FlutterFlowTheme.of(context).bodySmall,
          hintText: hintText,
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
      ),
    );
  }
}
