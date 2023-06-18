import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:licenta_main/constants.dart';
import 'package:licenta_main/models/event_model.dart';
import 'package:licenta_main/models/ticket_model.dart';
import 'package:licenta_main/services/firestore_service.dart';
import 'package:licenta_main/widgets/bottom_nav_magic.dart';

import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'tickets_list_model.dart';
export 'tickets_list_model.dart';

class TicketsListWidget extends StatefulWidget {
  const TicketsListWidget({Key? key}) : super(key: key);

  @override
  _TicketsListWidgetState createState() => _TicketsListWidgetState();
}

class _TicketsListWidgetState extends State<TicketsListWidget> {
  late TicketsListModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _unfocusNode = FocusNode();
  List<TicketModel> _tickets = [];
  List<EventModel> _events = [];
  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => TicketsListModel());
    loadTickets();
    loadEventsFromTickets();
  }

  @override
  void dispose() {
    _model.dispose();

    _unfocusNode.dispose();
    super.dispose();
  }

  Future<void> loadTickets() async {
    _tickets = await FirestoreService()
        .getAllUserTickets('S8Aa95jYU8MlzBjFUEXit1zbuTP2');
    setState(
        () {}); // Call setState to trigger a rebuild of the widget with the loaded data.
  }

  Future<void> loadEventsFromTickets() async {
    for (var ticket in _tickets) {
      var event = await FirestoreService().getEventFromTicket(ticket);
      _events.add(event);
    }
    print(_events);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(_unfocusNode),
      child: Scaffold(
          key: scaffoldKey,
          backgroundColor: Color(0xFF1D0526),
          body: SafeArea(
            top: true,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(20, 20, 20, 20),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SelectionArea(
                          child: Text(
                        'My Tickets',
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                              fontFamily: 'Poppins',
                              color: Colors.white,
                              fontSize: 18,
                            ),
                      )),
                      FlutterFlowIconButton(
                        borderColor: Colors.transparent,
                        borderRadius: 30,
                        borderWidth: 1,
                        buttonSize: 40,
                        fillColor: Color(0x34FFFFFF),
                        icon: Icon(
                          Icons.ios_share,
                          color: Colors.white,
                          size: 20,
                        ),
                        onPressed: () {
                          print('IconButton pressed ...');
                        },
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(10, 0, 10, 0),
                    child: Stack(
                      children: [
                        Padding(
                          padding:
                              EdgeInsetsDirectional.fromSTEB(20, 0, 20, 20),
                          child: ListView.builder(
                            itemCount: _tickets.length,
                            itemBuilder: (context, index) {
                              return TicketWidget(ticket: _tickets[index]);
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
          bottomNavigationBar: BottomNavMagic(initialIndex: 2, user: false)),
    );
  }
}

class TicketWidget extends StatelessWidget {
  final TicketModel ticket;

  const TicketWidget({
    Key? key,
    required this.ticket,
  }) : super(key: key);

  Future<EventModel> loadEvent() async {
    return await FirestoreService().getEventFromTicket(ticket);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<EventModel>(
        future: loadEvent(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator(); // Show loading indicator while waiting for future to complete
          } else if (snapshot.hasError) {
            return Text(
                'Error: ${snapshot.error}'); // Show error message if future completes with an error
          } else {
            EventModel event = snapshot.data!; // Get the completed EventModel

            return InkWell(
              onTap: () => {
                print('Card pressed ...'),
                context.pushNamed(
                  'TicketDetails',
                  params: {
                    'ticketDBId':
                        event.id.toString() + "_" + ticket.seatNumber.toString()
                  },
                  extra: <String, dynamic>{
                    kTransitionInfoKey: TransitionInfo(
                      hasTransition: true,
                      transitionType: PageTransitionType.fade,
                      duration: Duration(milliseconds: 500),
                    ),
                  },
                )
              },
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 20),
                child: Container(
                  width: double.infinity,
                  height: 294,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        FlutterFlowTheme.of(context).primary,
                        FlutterFlowTheme.of(context).secondary
                      ],
                      stops: [0.3, 1],
                      begin: AlignmentDirectional(0, -1),
                      end: AlignmentDirectional(0, 1),
                    ),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(30),
                            child: event.photoUrl != null &&
                                    event.photoUrl != "" &&
                                    Uri.tryParse(event.photoUrl ?? "rip")
                                            ?.hasAbsolutePath ==
                                        true
                                ? Image.network(
                                    event.photoUrl.toString(),
                                    width: double.infinity,
                                    height: 200,
                                    fit: BoxFit.cover,
                                  )
                                : Image.asset(
                                    'assets/images/big_nice_pumpkin.png',
                                    width: double.infinity,
                                    height: 200,
                                    fit: BoxFit.cover,
                                  )),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(20, 0, 20, 0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SelectionArea(
                                    child: Text(
                                  event.title,
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: 'Poppins',
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500,
                                      ),
                                )),
                                SelectionArea(
                                    child: Text(
                                  'By ' + event.generatedBy,
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: 'Poppins',
                                        color: Color(0x7BFFFFFF),
                                        fontSize: 12,
                                        fontWeight: FontWeight.normal,
                                      ),
                                )),
                              ],
                            ),
                            Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Text(
                                  event.date,
                                  style:
                                      FlutterFlowTheme.of(context).bodyMedium,
                                ),
                                Text(
                                  'Entry ' + event.time,
                                  style:
                                      FlutterFlowTheme.of(context).bodyMedium,
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
            );
          }
        });
  }
}
