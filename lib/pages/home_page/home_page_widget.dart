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
import 'package:licenta_main/models/event_model.dart';
import 'package:licenta_main/services/firestore_service.dart';
import 'package:licenta_main/widgets/event_card.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:walletconnect_dart/walletconnect_dart.dart';

class HomePageWidget extends StatefulWidget {
  const HomePageWidget({Key? key}) : super(key: key);

  @override
  State<HomePageWidget> createState() => _HomePageWidgetState();
}

class _HomePageWidgetState extends State<HomePageWidget> {
  EventModel upcomingEvent = EventModel.empty();

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
        var session = await connector.createSession(onDisplayUri: (uri) async {
          _uri = uri;
          await launchUrlString(uri, mode: LaunchMode.externalApplication);
        });
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
    upcomingEvent = await FirestoreService().getUpcomingEvent(
        "S8Aa95jYU8MlzBjFUEXit1zbuTP2"); //TODO update with current user id
    setState(() {});
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
            borderRadius: BorderRadius.circular(30),
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
              SizedBox(height: 50),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(20, 0, 0, 0),
                  child: Text(
                    'Your upcoming event ',
                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                          fontFamily: 'Poppins',
                          color: Color(0x7BFFFFFF),
                          fontSize: 24.0,
                          fontWeight: FontWeight.w300,
                        ),
                  ),
                ),
              ),
              Row(
                children: [Expanded(child: EventCard(event: upcomingEvent))],
              ),
              Row(
                children: [
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(20, 0, 0, 0),
                    child: FlutterFlowIconButton(
                      borderColor: Colors.transparent,
                      borderRadius: 30.0,
                      borderWidth: 1.0,
                      buttonSize: 60.0,
                      fillColor: FlutterFlowTheme.of(context).secondary,
                      icon: FaIcon(
                        FontAwesomeIcons.ethereum,
                        color: Colors.white,
                        size: 30.0,
                      ),
                      onPressed: () {
                        debugPrint('Will login to MetaMask...');
                        loginUsingMetamask(context);
                      },
                    ).animateOnPageLoad(
                        animationsMap['iconButtonOnPageLoadAnimation']!),
                  ),
                ],
              ),
            ],
          ),
        ),
        bottomNavigationBar: ConvexAppBar(
          items: BottomNavBarNavigationItems.navigationItems,
          initialActiveIndex: 0,
          onTap: (int i) => {
            debugPrint("Switching to screen: $i"),
            context.pushNamed(
              NavigationRouteIDs.routeIDs[i],
              extra: <String, dynamic>{
                kTransitionInfoKey: TransitionInfo(
                  hasTransition: true,
                  transitionType: PageTransitionType.fade,
                  duration: Duration(milliseconds: 500),
                ),
              },
            )
          },
        ));
  }
}
