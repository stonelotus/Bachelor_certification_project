import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:licenta_main/constants.dart';
import 'package:licenta_main/flutter_flow/flutter_flow_animations.dart';
import 'package:licenta_main/flutter_flow/flutter_flow_icon_button.dart';
import 'package:licenta_main/flutter_flow/flutter_flow_theme.dart';
import 'package:licenta_main/flutter_flow/flutter_flow_util.dart';
import 'package:licenta_main/flutter_flow/nav/nav.dart';
import 'package:licenta_main/main.dart';
import 'package:licenta_main/models/event_model.dart';
import 'package:licenta_main/services/contract_linking.dart';
import 'package:licenta_main/services/custom_transaction_tester.dart';
import 'package:licenta_main/services/firestore_service.dart';
import 'package:licenta_main/widgets/bottom_nav_magic.dart';
import 'package:licenta_main/widgets/event_card.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:walletconnect_dart/walletconnect_dart.dart';
import 'package:web3dart/web3dart.dart';
import 'package:http/http.dart' as http;

class OrganizerHomePageWidget extends StatefulWidget {
  const OrganizerHomePageWidget({Key? key}) : super(key: key);

  @override
  State<OrganizerHomePageWidget> createState() => _OrganizerHomePageWidget();
}

class _OrganizerHomePageWidget extends State<OrganizerHomePageWidget> {
  EventModel upcomingEvent = EventModel.empty();
  bool loaded = false;
  int upcomingEventsNumber = 0;
  int attendeesNumber = 0;
  double revenue = 0;
  @override
  void initState() {
    super.initState();
    loadUpcomingEvent();
  }

  var connector = WalletConnect(
      bridge: 'https://bridge.walletconnect.org',
      clientMeta: const PeerMeta(
          name: 'My App',
          description: 'An app for converting pictures to NFT',
          url: 'https://walletconnect.org',
          icons: [
            'https://files.gitbook.com/v0/b/gitbook-legacy-files/o/spaces%2F-LJJeCjcLrr53DcT1Ml7%2Favatar.png?alt=media'
          ]));
  var _session, _uri;

  loginUsingMetamask(BuildContext context) async {
    if (!connector.connected) {
      try {
        var session = await connector.createSession(
            chainId: 1337,
            onDisplayUri: (uri) async {
              _uri = uri;
              await launchUrlString(uri, mode: LaunchMode.externalApplication);
            });
        print(session.accounts[0]);

        setState(() {
          debugPrint(session.toString());
          _session = session;
        });
      } catch (exp) {
        print(exp);
      }
    }
  }

  Future<void> loadUpcomingEvent() async {
    // upcoming events number
    var upcomingEvents = await FirestoreService()
        .getEventsByOrganizerDisplayName(globalUser.displayName);
    upcomingEventsNumber = upcomingEvents.length;
    print("upcomingEventsNumber: $upcomingEventsNumber");
    // attendees
    attendeesNumber = upcomingEvents.fold(
        0,
        (previousValue, element) =>
            previousValue + element.ticketCount - element.ticketsAvailable);
    print("attendeesNumber: $attendeesNumber");
    // revenue

    revenue = upcomingEvents.fold(
        0.0,
        (previousValue, element) =>
            previousValue +
            element.ticketPrice *
                (element.ticketCount - element.ticketsAvailable));
    print("revenue: $revenue");
    setState(() {
      loaded = true;
    });
  }

  final animationsMap = {
    'iconButtonOnPageLoadAnimation': AnimationInfo(
      loop: true,
      trigger: AnimationTrigger.onPageLoad,
      effects: [
        RotateEffect(
          curve: Curves.easeInOut,
          delay: 0.ms,
          duration: 2000.ms,
          begin: 0.0,
          end: 1.0,
        ),
      ],
    ),
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          width: double.infinity,
          height: double.infinity,
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
          ),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              SizedBox(height: 30),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: Image.asset(
                    'assets/images/4183289.jpg',
                    width: double.infinity,
                    height: 200,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(20, 0, 0, 0),
                    child: Text(
                      'Hello there, Iulian ',
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                            fontFamily: 'Poppins',
                            color: Color(0x7BFFFFFF),
                            fontSize: 24.0,
                            fontWeight: FontWeight.w300,
                          ),
                    ),
                  )
                ],
              ),
              SizedBox(height: 10),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(20, 0, 0, 0),
                  child: Text("There are no updates... Scary!",
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                            fontFamily: 'Poppins',
                            color: Colors.white,
                          )),
                ),
              ),
              SizedBox(height: 30),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(20, 0, 0, 0),
                  child: Text(
                    'This month\'s stats',
                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                          fontFamily: 'Poppins',
                          color: Color(0x7BFFFFFF),
                          fontSize: 24.0,
                          fontWeight: FontWeight.w300,
                        ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                    child: InkWell(
                        onTap: () => {},
                        child: KpiWidget(kpiString: "Upcoming events")),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 18, 0),
                    child: InkWell(
                        onTap: () => {},
                        child: KpiValueWidget(
                          kpiString: upcomingEventsNumber.toString(),
                        )),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                    child: InkWell(
                        onTap: () => {},
                        child: KpiWidget(kpiString: "Attendees")),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 18, 0),
                    child: InkWell(
                        onTap: () => {},
                        child: KpiValueWidget(
                          kpiString: attendeesNumber.toString(),
                        )),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                    child: InkWell(
                        onTap: () => {},
                        child: KpiWidget(kpiString: "Revenue (USD)")),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 18, 0),
                    child: InkWell(
                        onTap: () => {},
                        child: KpiValueWidget(
                          kpiString: revenue.toString(),
                        )),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(20, 0, 18, 0),
                    child: InkWell(
                      onTap: () => {
                        context.pushNamed(
                          'CreateEvent',
                          extra: <String, dynamic>{
                            kTransitionInfoKey: TransitionInfo(
                              hasTransition: true,
                              transitionType: PageTransitionType.fade,
                              duration: Duration(milliseconds: 500),
                            ),
                          },
                        )
                      },
                      child: Container(
                        width: 180.0,
                        height: 60.0,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              FlutterFlowTheme.of(context).primary,
                              FlutterFlowTheme.of(context).secondary
                            ],
                            stops: [0.0, 0.9],
                            begin: AlignmentDirectional(0.4, -0.98),
                            end: AlignmentDirectional(-1.0, 0.98),
                          ),
                          borderRadius: BorderRadius.circular(30.0),
                          shape: BoxShape.rectangle,
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              'Create event',
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    fontFamily: 'Poppins',
                                    color: Colors.white,
                                  ),
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
        bottomNavigationBar:
            BottomNavMagic(initialIndex: 0, user: globalUser?.isOrganizer));
  }
}

class KpiWidget extends StatelessWidget {
  final kpiString;
  const KpiWidget({
    Key? key,
    required String? this.kpiString,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      width: 150,
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.white, // Border color
          width: 2.0, // Border width
        ),
        color: Colors.transparent,
      ),
      child: Center(
        child: Text(
          kpiString,
          style: FlutterFlowTheme.of(context).bodyMedium.override(
                fontFamily: 'Poppins',
                color: Colors.white,
              ),
        ),
      ),
    );
  }
}

class KpiValueWidget extends StatelessWidget {
  final kpiString;
  const KpiValueWidget({Key? key, required String? this.kpiString})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      width: 70,
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.white, // Border color
          width: 2.0, // Border width
        ),
        color: Colors.transparent,
      ),
      child: Center(
        child: Text(
          kpiString,
          style: FlutterFlowTheme.of(context).bodyMedium.override(
                fontFamily: 'Poppins',
                color: Colors.white,
              ),
        ),
      ),
    );
  }
}
