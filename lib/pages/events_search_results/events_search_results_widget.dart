import 'package:lazy_loading_list/lazy_loading_list.dart';
import 'package:licenta_main/constants.dart';
import 'package:licenta_main/models/event_model.dart';
import 'package:licenta_main/services/firestore_service.dart';
import 'package:licenta_main/widgets/event_card.dart';

import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_choice_chips.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import 'package:badges/badges.dart' as badges;
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'events_search_results_model.dart';
export 'events_search_results_model.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';

class EventsSearchResultsWidget extends StatefulWidget {
  const EventsSearchResultsWidget({Key? key}) : super(key: key);

  @override
  _EventsSearchResultsWidgetState createState() =>
      _EventsSearchResultsWidgetState();
}

class _EventsSearchResultsWidgetState extends State<EventsSearchResultsWidget>
    with TickerProviderStateMixin {
  late EventsSearchResultsModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _unfocusNode = FocusNode();

  final animationsMap = {
    'containerOnPageLoadAnimation1': AnimationInfo(
      trigger: AnimationTrigger.onPageLoad,
      effects: [
        FadeEffect(
          curve: Curves.easeInOut,
          delay: 0.ms,
          duration: 800.ms,
          begin: 0.0,
          end: 1.0,
        ),
      ],
    ),
    'containerOnPageLoadAnimation2': AnimationInfo(
      trigger: AnimationTrigger.onPageLoad,
      effects: [
        FadeEffect(
          curve: Curves.easeInOut,
          delay: 280.ms,
          duration: 800.ms,
          begin: 0.0,
          end: 1.0,
        ),
      ],
    ),
    'rowOnPageLoadAnimation': AnimationInfo(
      trigger: AnimationTrigger.onPageLoad,
      effects: [
        MoveEffect(
          curve: Curves.easeInOut,
          delay: 0.ms,
          duration: 800.ms,
          begin: Offset(30.0, 0.0),
          end: Offset(0.0, 0.0),
        ),
      ],
    ),
    'textOnPageLoadAnimation': AnimationInfo(
      trigger: AnimationTrigger.onPageLoad,
      effects: [
        MoveEffect(
          curve: Curves.easeInOut,
          delay: 60.ms,
          duration: 800.ms,
          begin: Offset(-34.0, 0.0),
          end: Offset(0.0, 0.0),
        ),
      ],
    ),
    'columnOnPageLoadAnimation': AnimationInfo(
      trigger: AnimationTrigger.onPageLoad,
      effects: [
        MoveEffect(
          curve: Curves.easeIn,
          delay: 330.ms,
          duration: 800.ms,
          begin: Offset(0.0, 36.0),
          end: Offset(0.0, 0.0),
        ),
        FadeEffect(
          curve: Curves.easeInOut,
          delay: 290.ms,
          duration: 800.ms,
          begin: 0.0,
          end: 1.0,
        ),
      ],
    ),
  };

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => EventsSearchResultsModel());

    _model.textController ??= TextEditingController();
  }

  @override
  void dispose() {
    _model.dispose();

    _unfocusNode.dispose();
    super.dispose();
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
                Container(
                  width: double.infinity,
                  height: 22.0,
                  decoration: BoxDecoration(),
                ).animateOnPageLoad(
                    animationsMap['containerOnPageLoadAnimation1']!),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(),
                  child: Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 16.0),
                    child: TextFormField(
                      controller: _model.textController,
                      onChanged: (_) => EasyDebounce.debounce(
                        '_model.textController',
                        Duration(milliseconds: 2000),
                        () => setState(() {}),
                      ),
                      autofocus: true,
                      obscureText: false,
                      decoration: InputDecoration(
                        hintText: 'Search event',
                        hintStyle: GoogleFonts.getFont(
                          'Inter',
                          color: Color(0xFF4F4F71),
                          fontWeight: FontWeight.normal,
                          fontSize: 14.0,
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0x00000000),
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0x00000000),
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        errorBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0x00000000),
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        focusedErrorBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0x00000000),
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        filled: true,
                        fillColor: Color(0xFF161630),
                        contentPadding: EdgeInsetsDirectional.fromSTEB(
                            0.0, 20.0, 0.0, 20.0),
                        prefixIcon: Icon(
                          Icons.search,
                          color: Color(0xFF4F4F71),
                          size: 14.0,
                        ),
                        suffixIcon: _model.textController!.text.isNotEmpty
                            ? InkWell(
                                onTap: () async {
                                  _model.textController?.clear();
                                  setState(() {});
                                },
                                child: Icon(
                                  Icons.clear,
                                  color: Color(0xFF4F4F71),
                                  size: 18.0,
                                ),
                              )
                            : null,
                      ),
                      style: GoogleFonts.getFont(
                        'Inter',
                        color: Colors.white,
                        fontWeight: FontWeight.normal,
                        fontSize: 14.0,
                      ),
                      validator:
                          _model.textControllerValidator.asValidator(context),
                    ),
                  ),
                ).animateOnPageLoad(
                    animationsMap['containerOnPageLoadAnimation2']!),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(
                        padding:
                            EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 0.0, 0.0),
                        child: FlutterFlowChoiceChips(
                          options: [
                            ChipData('Electronic'),
                            ChipData('Rock'),
                            ChipData('Reggaeton'),
                            ChipData('Classical'),
                            ChipData('Folk'),
                            ChipData('Metal')
                          ],
                          onChanged: (val) =>
                              setState(() => _model.choiceChipsValues = val),
                          selectedChipStyle: ChipStyle(
                            backgroundColor: Color(0xFF6958FE),
                            textStyle: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                                  fontFamily: 'Poppins',
                                  color: Colors.white,
                                  fontWeight: FontWeight.normal,
                                ),
                            iconColor: Colors.white,
                            iconSize: 18.0,
                            elevation: 4.0,
                          ),
                          unselectedChipStyle: ChipStyle(
                            backgroundColor: Color(0xFF161630),
                            textStyle:
                                FlutterFlowTheme.of(context).bodySmall.override(
                                      fontFamily: 'Poppins',
                                      color: Color(0xFF4F4F71),
                                      fontWeight: FontWeight.normal,
                                    ),
                            iconColor: Color(0xFFE3E7ED),
                            iconSize: 18.0,
                            elevation: 0.0,
                          ),
                          chipSpacing: 12.0,
                          multiselect: true,
                          initialized: _model.choiceChipsValues != null,
                          alignment: WrapAlignment.start,
                          controller: _model.choiceChipsValueController ??=
                              FormFieldController<List<String>>(
                            [],
                          ),
                        ),
                      ),
                    ],
                  ),
                ).animateOnPageLoad(animationsMap['rowOnPageLoadAnimation']!),
                Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 16.0, 0.0, 16.0),
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(),
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              16.0, 0.0, 16.0, 0.0),
                          child: Text(
                            'Latest Events',
                            style: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                                  fontFamily: 'Poppins',
                                  color: Colors.white,
                                  fontSize: 20.0,
                                ),
                          ).animateOnPageLoad(
                              animationsMap['textOnPageLoadAnimation']!),
                        ),
                      ),
                    ),
                  ],
                ),
                Expanded(child: EventList()),
              ],
            ),
          ),
          bottomNavigationBar: ConvexAppBar(
            items: BottomNavBarNavigationItems.navigationItems,
            initialActiveIndex: 1,
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
          )),
    );
  }
}

class EventList extends StatefulWidget {
  @override
  _EventListState createState() => _EventListState();
}

class _EventListState extends State<EventList> {
  List<EventModel> events =
      []; // Initialize your event list. This can also be a state variable that you update as you fetch data.

  @override
  void initState() {
    super.initState();
    loadEvents();
  }

  void loadEvents() async {
    events = await FirestoreService().getAllEvents();
    print(events);
    setState(() {});
  }

  void _loadMore() async {
    // Add 5 more cards when end of the list is reached
    for (int i = 0; i < 5; i++) {
      events.add(EventModel.empty());
    }

    // Inform the widget that new data has been fetched
    setState(() {});
    print("Loading more...");
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: events.length,
        itemBuilder: (context, index) {
          return LazyLoadingList(
              initialSizeOfItems: 2,
              index: index,
              hasMore: true,
              loadMore: () => print('Loading More'),
              child: EventCard(event: events[index]));
        });
  }
}
