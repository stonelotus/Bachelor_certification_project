import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
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
import 'package:pointycastle/ecc/curves/secp256k1.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:walletconnect_dart/walletconnect_dart.dart';
import 'package:web3dart/web3dart.dart';
import 'package:http/http.dart' as http;

class HomePageWidget extends StatefulWidget {
  const HomePageWidget({Key? key}) : super(key: key);

  @override
  State<HomePageWidget> createState() => _HomePageWidgetState();
}

class _HomePageWidgetState extends State<HomePageWidget> {
  EventModel upcomingEvent = EventModel.empty();
  bool loaded = false;
  @override
  void initState() {
    super.initState();
    loadUpcomingEvent();
  }

  final storage = new FlutterSecureStorage();

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
    upcomingEvent = await FirestoreService().getUpcomingEvent(
        "S8Aa95jYU8MlzBjFUEXit1zbuTP2"); //TODO update with current user id
    setState(() {
      print("Got upcoming event: $upcomingEvent");
      print(upcomingEvent.title);
      loaded = true;
    });
  }

  bool isValidPrivateKey(String privateKey) {
    // final regex = RegExp(r'^5[HJK][1-9A-Za-z]{49}$');
    // return regex.hasMatch(privateKey);
    if (privateKey.startsWith("0x")) {
      return true;
    }
    return false;
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
          child: SingleChildScrollView(
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
                        'Hello there, ' + 'Iulian',
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
                SizedBox(height: 20),
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
                  children: [
                    Expanded(
                        child: (upcomingEvent.title != '' && loaded == true) ||
                                loaded == false
                            ? EventCard(event: upcomingEvent)
                            : Text("No upcoming events")) //TODO update this
                  ],
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(20, 0, 0, 0),
                      child: FlutterFlowIconButton(
                        borderColor: Colors.transparent,
                        borderRadius: 30.0,
                        borderWidth: 1.0,
                        buttonSize: 60.0,
                        fillColor: FlutterFlowTheme.of(context).tertiary,
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
                    Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(0, 0, 18, 0),
                      child: InkWell(
                        onTap: () async {
                          GlobalKey _keyLoader = GlobalKey();

                          String? userInputKey =
                              await showTextInputDialog(context, _keyLoader);
                          if (userInputKey != null &&
                              userInputKey != '' &&
                              isValidPrivateKey(userInputKey.toString()) &&
                              EthPrivateKey.fromHex(userInputKey.toString())
                                      .address
                                      .hexEip55 !=
                                  '') {
                            await storage.write(
                                key: "pk", value: userInputKey.toString());
                            await storage.write(
                                key: 'publicKey',
                                value: EthPrivateKey.fromHex(
                                        userInputKey.toString())
                                    .address
                                    .hexEip55);
                            CoolAlert.show(
                              animType: CoolAlertAnimType.rotate,
                              context: context,
                              type: CoolAlertType.success,
                              text: "Successfully updated Private key!",
                              onCancelBtnTap: () {
                                print("Cancel Button Tapped");
                                Navigator.of(context, rootNavigator: true)
                                    .pop();
                              },
                              onConfirmBtnTap: () {
                                print("Confirm Button Tapped");
                                Navigator.of(context, rootNavigator: true)
                                    .pop();
                              },
                            );
                          } else {
                            CoolAlert.show(
                                animType: CoolAlertAnimType.slideInDown,
                                context: context,
                                type: CoolAlertType.error,
                                text: "Not a valid Private Key!",
                                onCancelBtnTap: () {
                                  print("Cancel Button Tapped");
                                  Navigator.of(context, rootNavigator: true)
                                      .pop();
                                },
                                onConfirmBtnTap: () {
                                  print("Confirm Button Tapped");
                                  Navigator.of(context, rootNavigator: true)
                                      .pop();
                                });
                            print("Invalid key");
                          }
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
                                'Update Private Key',
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
        ),
        bottomNavigationBar: BottomNavMagic(initialIndex: 0, user: false));
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
          backgroundColor: FlutterFlowTheme.of(context).secondary,
          shape: ShapeBorder.lerp(
              RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  side: BorderSide(color: Colors.black)),
              RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  side: BorderSide(color: Colors.black)),
              1),
          children: <Widget>[
            Center(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Please enter Private Key",
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                            fontFamily: 'Poppins',
                            color: Colors.white,
                          ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: textEditingController,
                      maxLines: 8,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Enter your private key here',
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          FlutterFlowTheme.of(context).primary,
                          FlutterFlowTheme.of(context).secondary,
                        ],
                        stops: [0.0, 0.9],
                        begin: AlignmentDirectional(0.4, -0.98),
                        end: AlignmentDirectional(-1.0, 0.98),
                      ),
                      borderRadius: BorderRadius.circular(30.0),
                      shape: BoxShape.rectangle,
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(30.0),
                        onTap: () {
                          Navigator.of(context).pop(true); // Clos
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Text(
                            "Submit!",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
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
