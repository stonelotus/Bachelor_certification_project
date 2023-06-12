import 'package:licenta_main/constants.dart';
import 'package:licenta_main/models/event_model.dart';
import 'package:licenta_main/models/ticket_model.dart';
import 'package:licenta_main/services/firestore_service.dart';
import 'package:licenta_main/services/ticket_contract_linking.dart';

import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_static_map.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/lat_lng.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mapbox_search/mapbox_search.dart';
import 'package:provider/provider.dart';
import 'event_page_model.dart';
export 'event_page_model.dart';

class EventPageWidget extends StatefulWidget {
  const EventPageWidget({Key? key}) : super(key: key);

  @override
  _EventPageWidgetState createState() => _EventPageWidgetState();
}

class _EventPageWidgetState extends State<EventPageWidget>
    with TickerProviderStateMixin {
  late EventPageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _unfocusNode = FocusNode();
  EventModel event = EventModel.empty();
  bool eventLoaded = false;
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
  void initState() {
    super.initState();
    _model = createModel(context, () => EventPageModel());
  }

  @override
  void dispose() {
    _model.dispose();

    _unfocusNode.dispose();
    super.dispose();
  }

  void loadEventDetails() async {
    if (eventLoaded == true) {
      debugPrint("Loaded Event: " + event.toString());
      return;
    }
    final routeData = GoRouter.of(context).location;
    final queryParams = Uri.parse(routeData).queryParameters;
    final eventID = queryParams['eventID'];
    debugPrint("Loaded Event with ID: " + eventID!.toString());
    event = await FirestoreService().getEventByID(eventID);
    eventLoaded = true;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    loadEventDetails();

    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(_unfocusNode),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: Color(0xFF1D0526),
        body: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                width: double.infinity,
                child: Stack(
                  children: [
                    Image.asset(
                      'assets/images/4183289.jpg',
                      width: double.infinity,
                      height: 250.0,
                      fit: BoxFit.cover,
                    ),
                    Container(
                      height: 200.0,
                      decoration: BoxDecoration(),
                    ),
                    Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(15.0, 40.0, 15.0, 0.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            child: FlutterFlowIconButton(
                              borderColor: Colors.transparent,
                              borderRadius: 30.0,
                              borderWidth: 1.0,
                              buttonSize: 50.0,
                              fillColor: Color(0x80FFFFFF),
                              icon: Icon(
                                Icons.chevron_left,
                                color: Colors.white,
                                size: 30.0,
                              ),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ),
                          // FlutterFlowIconButton(
                          //   borderColor: Colors.transparent,
                          //   borderRadius: 30.0,
                          //   borderWidth: 1.0,
                          //   buttonSize: 50.0,
                          //   fillColor: Color(0x80FFFFFF),
                          //   icon: Icon(
                          //     Icons.bookmark_border,
                          //     color: Colors.white,
                          //     size: 30.0,
                          //   ),
                          //   onPressed: () {
                          //     print('IconButton pressed ...');
                          //   },
                          // ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(5.0, 30.0, 5.0, 0.0),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: double.infinity,
                      height: 50.0,
                      decoration: BoxDecoration(
                        color: Color(0x00FFFFFF),
                      ),
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            20.0, 0.0, 20.0, 0.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0.0, 0.0, 0.0, 2.0),
                                  child: SelectionArea(
                                      child: Text(
                                    event.title,
                                    style: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                          fontFamily: 'Poppins',
                                          color: Colors.white,
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.w500,
                                        ),
                                  )),
                                ),
                                SelectionArea(
                                    child: Text(
                                  "by " + event.generatedBy,
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: 'Poppins',
                                        color: Color(0x7BFFFFFF),
                                        fontSize: 12.0,
                                        fontWeight: FontWeight.normal,
                                      ),
                                )),
                              ],
                            ),
                            Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Container(
                                  width: 50.0,
                                  height: 50.0,
                                  decoration: BoxDecoration(
                                    color: Color(0x32FFFFFF),
                                    borderRadius: BorderRadius.circular(10.0),
                                    shape: BoxShape.rectangle,
                                  ),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SelectionArea(
                                          child: Text(
                                        'NOV', //TODO: Change to event date
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                              fontFamily: 'Poppins',
                                              color: Colors.white,
                                              fontWeight: FontWeight.w500,
                                            ),
                                      )),
                                      SelectionArea(
                                          child: Text(
                                        '28', //TODO  Change to event date
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                              fontFamily: 'Poppins',
                                              color: Color(0xFFFD7138),
                                              fontWeight: FontWeight.bold,
                                            ),
                                      )),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(20.0, 5.0, 20.0, 20.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 0.0, 10.0, 0.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0.0, 0.0, 5.0, 0.0),
                                  child: Icon(
                                    Icons.location_on_outlined,
                                    color:
                                        FlutterFlowTheme.of(context).tertiary,
                                    size: 20.0,
                                  ),
                                ),
                                SelectionArea(
                                    child: Text(
                                  event.location,
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: 'Poppins',
                                        color: Color(0x7BFFFFFF),
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.w300,
                                      ),
                                )),
                              ],
                            ),
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 0.0, 5.0, 0.0),
                                child: Icon(
                                  Icons.access_time,
                                  color: FlutterFlowTheme.of(context).tertiary,
                                  size: 20.0,
                                ),
                              ),
                              SelectionArea(
                                  child: Text(
                                event.time.toString(),
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      fontFamily: 'Poppins',
                                      color: Color(0x7BFFFFFF),
                                      fontWeight: FontWeight.w300,
                                    ),
                              )),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: 350.0,
                      height: 100.0,
                      decoration: BoxDecoration(
                        color: Color(0x1AFFFFFF),
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                20.0, 20.0, 20.0, 20.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SelectionArea(
                                    child: Text(
                                  'Rating',
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: 'Poppins',
                                        color: Colors.white,
                                        fontWeight: FontWeight.normal,
                                      ),
                                )),
                                SelectionArea(
                                    child: Text(
                                  '4.5',
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: 'Poppins',
                                        color: Colors.white,
                                        fontSize: 18.0,
                                      ),
                                )),
                                RatingBar.builder(
                                  onRatingUpdate: (newValue) => setState(
                                      () => _model.ratingBarValue = newValue),
                                  itemBuilder: (context, index) => Icon(
                                    Icons.star_rounded,
                                    color: Color(0xFFFD7138),
                                  ),
                                  direction: Axis.horizontal,
                                  initialRating: _model.ratingBarValue ??= 4.5,
                                  unratedColor: Color(0xFF9E9E9E),
                                  itemCount: 5,
                                  itemSize: 10.0,
                                  glowColor: Color(0xFFFD7138),
                                ),
                              ],
                            ),
                          ),
                          Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 0.0, 0.0, 10.0),
                                child: SelectionArea(
                                    child: Text(
                                  'People Joined',
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: 'Poppins',
                                        color: Colors.white,
                                        fontWeight: FontWeight.normal,
                                      ),
                                )),
                              ),
                              Stack(
                                children: [
                                  Container(
                                    width: 30.0,
                                    height: 30.0,
                                    clipBehavior: Clip.antiAlias,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                    ),
                                    child: Image.network(
                                      'https://i.pravatar.cc/150?img=3',
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        20.0, 0.0, 0.0, 0.0),
                                    child: Container(
                                      width: 30.0,
                                      height: 30.0,
                                      clipBehavior: Clip.antiAlias,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                      ),
                                      child: Image.network(
                                        'https://i.pravatar.cc/150?img=6',
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        40.0, 0.0, 0.0, 0.0),
                                    child: Container(
                                      width: 30.0,
                                      height: 30.0,
                                      clipBehavior: Clip.antiAlias,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                      ),
                                      child: Image.network(
                                        'https://i.pravatar.cc/150?img=10',
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        60.0, 0.0, 0.0, 0.0),
                                    child: Container(
                                      width: 30.0,
                                      height: 30.0,
                                      decoration: BoxDecoration(
                                        color: Color(0xFFFD7138),
                                        shape: BoxShape.circle,
                                      ),
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0.0, 6.0, 0.0, 0.0),
                                        child: SelectionArea(
                                            child: Text(
                                          '+62',
                                          textAlign: TextAlign.center,
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                                fontFamily: 'Poppins',
                                                color: Colors.white,
                                                fontSize: 12.0,
                                                fontWeight: FontWeight.normal,
                                              ),
                                        )),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 0.0, 10.0, 0.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                FlutterFlowStaticMap(
                                  location: LatLng(40.740121, -73.990593),
                                  apiKey:
                                      'pk.eyJ1IjoicHJpbGx5amVhbmFsZGk2NjYiLCJhIjoiY2xhMTlsMnFrMDVlejN1bHp1dXMwZ3V1cSJ9.KGVhgtNP1NIxnqnFP7B-4A',
                                  style: MapBoxStyle.Streets,
                                  width: 80.0,
                                  height: 80.0,
                                  fit: BoxFit.contain,
                                  borderRadius: BorderRadius.circular(10.0),
                                  markerColor: Color(0xFFFD7138),
                                  zoom: 6,
                                  tilt: 0,
                                  rotation: 0,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(20.0, 20.0, 20.0, 20.0),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 0.0, 10.0),
                          child: SelectionArea(
                              child: Text(
                            'About Event',
                            style: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                                  fontFamily: 'Poppins',
                                  color: Colors.white,
                                  fontSize: 20.0,
                                ),
                          )),
                        ),
                      ],
                    ),
                    SelectionArea(
                        child: Text(
                      event.description,
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                            fontFamily: 'Poppins',
                            color: Color(0x7BFFFFFF),
                            fontWeight: FontWeight.w300,
                          ),
                    )),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 20.0, 0.0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    FlutterFlowIconButton(
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
                        print('IconButton pressed ...');
                      },
                    ).animateOnPageLoad(
                        animationsMap['iconButtonOnPageLoadAnimation']!),
                    InkWell(
                      splashColor: Colors.transparent,
                      focusColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () async {
                        //TODO update seatsNumber and price

                        int soldTickets = await FirestoreService()
                            .getNumberOfSoldTicketsOfEvent(event.id);
                        int seatNumber = soldTickets + 1;

                        debugPrint("Generating nft...");
                        // get seller TicketContractLinking
                        TicketingContractLinking
                            ticketingContractLinkingSeller =
                            TicketingContractLinking(
                                MockCredentials.eventOrganizerPK);
                        await ticketingContractLinkingSeller.initialSetup();

                        // generate nft
                        var ticketIdBlockchain =
                            await ticketingContractLinkingSeller.issueTicket(
                                event.title,
                                event.ticketPrice,
                                event.ticketCount,
                                seatNumber,
                                event.date.toString());

                        debugPrint(ticketIdBlockchain?.toString());
                        var sellerID = await ticketingContractLinkingSeller
                            .getOwner(ticketIdBlockchain);

                        debugPrint("Seller id: " + sellerID.toString());

                        ///////////////////////////////////
                        debugPrint("Buying nft ...");
                        TicketingContractLinking ticketingContractLinkingBuyer =
                            TicketingContractLinking(MockCredentials.buyerPK);
                        await ticketingContractLinkingBuyer.initialSetup();
                        await ticketingContractLinkingBuyer
                            .buyTicket(ticketIdBlockchain);
                        debugPrint("Nft bought");

                        await FirestoreService()
                            .writeTicketToFirestore(TicketModel(
                                seatNumber: seatNumber, //TODO TDB
                                eventId: event.id,
                                price: event.ticketPrice,
                                batchNo: event.ticketCount,
                                blockchainTicketId: ticketIdBlockchain,
                                eventName: event.title));
                        /////////////////////
                        ///
                        var ownerID = await ticketingContractLinkingBuyer
                            .getOwner(ticketIdBlockchain);
                        debugPrint("Owner id: " + ownerID.toString());
                        context.pushNamed(
                          'TicketDetails',
                          params: {
                            'ticketDBId': event.id.toString() +
                                "_" +
                                seatNumber.toString(),
                          },
                          extra: <String, dynamic>{
                            kTransitionInfoKey: TransitionInfo(
                              hasTransition: true,
                              transitionType: PageTransitionType.topToBottom,
                              duration: Duration(milliseconds: 500),
                            ),
                          },
                        );
                      },
                      child: Container(
                        width: 280.0,
                        height: 60.0,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              FlutterFlowTheme.of(context).primary,
                              FlutterFlowTheme.of(context).secondary
                            ],
                            stops: [0.0, 0.9],
                            begin: AlignmentDirectional(1.0, -0.98),
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
                              'Buy Ticket Now ',
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    fontFamily: 'Poppins',
                                    color: Colors.white,
                                  ),
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0.0, 0.0, 5.0, 0.0),
                                  child: Text(
                                    '5', //TODO update
                                    style: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                          fontFamily: 'Poppins',
                                          color: FlutterFlowTheme.of(context)
                                              .primaryBtnText,
                                          fontSize: 20.0,
                                        ),
                                  ),
                                ),
                                Text(
                                  'USD',
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: 'Poppins',
                                        color: Colors.white,
                                      ),
                                ),
                              ],
                            ),
                          ],
                        ),
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
