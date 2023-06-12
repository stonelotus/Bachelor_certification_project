import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:licenta_main/constants.dart';
import 'package:licenta_main/flutter_flow/flutter_flow_theme.dart';
import 'package:licenta_main/flutter_flow/flutter_flow_util.dart';
import 'package:licenta_main/services/ticket_contract_linking.dart';
import 'package:licenta_main/services/ticketing.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class TicketValidator extends StatefulWidget {
  @override
  _TicketValidatorState createState() => _TicketValidatorState();
}

class _TicketValidatorState extends State<TicketValidator> {
  String? result;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  late TicketingContractLinking ticketingContractLinkingBuyer;
  bool statusActive = true;

  String eventSeat = "-";
  String eventTitle = "-";

  void loadBlockchain() async {
    ticketingContractLinkingBuyer =
        TicketingContractLinking(MockCredentials.buyerPK);
    await ticketingContractLinkingBuyer.initialSetup();
  }

  updateEventDetails(ticketObject) async {
    var ticket = await TicketService.getTicketObject(
        ticketObject, ticketingContractLinkingBuyer);
    setState(() {
      eventSeat = ticket['eventSeat'].toString();
      eventTitle = ticket['eventTitle'].toString();
    });
  }

  @override
  void initState() {
    loadBlockchain();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1D0526),
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 75,
            child: GestureDetector(
              onTap: () => {setState(() {})},
              child: QRView(
                key: qrKey,
                onQRViewCreated: _onQRViewCreated,
              ),
            ),
          ),
          Expanded(
            flex: 25,
            child: Container(
              width: double.infinity,
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
              child: Column(children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    "Scanning...",
                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                        fontFamily: 'Poppins',
                        color: Colors.white,
                        fontSize: 19),
                  ),
                ),
                NiceValueLabel(
                    incomingFieldName: "Event", incomingFieldValue: eventTitle),
                SizedBox(height: 10),
                NiceValueLabel(
                    incomingFieldName: "Seat", incomingFieldValue: eventSeat),
              ]),
            ),
          ),
        ],
      ),
      bottomNavigationBar: ConvexAppBar(
        items: BottomNavBarNavigationItems.navigationItems,
        initialActiveIndex: 3,
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
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) async {
    this.controller = controller;

    controller.scannedDataStream.listen((scanData) async {
      if (statusActive == true) {
        statusActive = false;
        bool isTicketValid = await TicketService.validateTicket(
            scanData.code.toString(), ticketingContractLinkingBuyer);

        if (isTicketValid == true) {
          updateEventDetails(scanData.code.toString());
          CoolAlert.show(
            context: context,
            type: CoolAlertType.success,
            text: "Your transaction was successful!",
            onCancelBtnTap: () {
              print("Cancel Button Tapped");
              statusActive = true;
              Navigator.of(context, rootNavigator: true).pop();
            },
            onConfirmBtnTap: () {
              print("Confirm Button Tapped");
              statusActive = true;
              Navigator.of(context, rootNavigator: true).pop();
            },
          );
        } else {
          eventSeat = "-";
          eventTitle = "-";
          setState(() {});
          CoolAlert.show(
              context: context,
              type: CoolAlertType.error,
              text: "Not a valid ticket!",
              onCancelBtnTap: () {
                print("Cancel Button Tapped");
                statusActive = true;
                Navigator.of(context, rootNavigator: true).pop();
              },
              onConfirmBtnTap: () {
                print("Confirm Button Tapped");
                statusActive = true;
                Navigator.of(context, rootNavigator: true).pop();
              });
        }

        // setState(() {
        //   showImage = isTicketValid;
        // });
      }
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}

class NiceValueLabel extends StatelessWidget {
  final incomingFieldName;
  final incomingFieldValue;
  const NiceValueLabel(
      {Key? key,
      required this.incomingFieldName,
      required this.incomingFieldValue})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 330.0,
      height: 60.0,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            FlutterFlowTheme.of(context).primary,
            FlutterFlowTheme.of(context).secondary
          ],
          stops: [0.0, 0.9],
          begin: AlignmentDirectional(1.0, -1),
          end: AlignmentDirectional(-1.0, 1.0),
        ),
        borderRadius: BorderRadius.circular(30.0),
        shape: BoxShape.rectangle,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
            child: Text(
              incomingFieldName,
              style: FlutterFlowTheme.of(context).bodyMedium.override(
                  fontFamily: 'Poppins', color: Colors.white, fontSize: 19),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
            child: Text(
              incomingFieldValue, //TODO update
              style: FlutterFlowTheme.of(context).bodyMedium.override(
                    fontFamily: 'Poppins',
                    color: FlutterFlowTheme.of(context).primaryBtnText,
                    fontSize: 15.0,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
