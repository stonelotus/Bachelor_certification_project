import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:licenta_main/constants.dart';
import 'package:licenta_main/flutter_flow/flutter_flow_theme.dart';
import 'package:licenta_main/flutter_flow/flutter_flow_util.dart';
import 'package:licenta_main/main.dart';

class BottomNavMagic extends StatelessWidget {
  final int initialIndex;
  final user;
  const BottomNavMagic({
    Key? key,
    required this.initialIndex,
    required this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(user);
    return ConvexAppBar(
      gradient: LinearGradient(
        colors: [
          FlutterFlowTheme.of(context).primary,
          FlutterFlowTheme.of(context).secondary
        ],
        stops: [0.0, 0.9],
      ),
      items: user
          ? BottomNavBarNavigationItems.organizerNavigationItems
          : BottomNavBarNavigationItems.navigationItems,
      initialActiveIndex: this.initialIndex,
      backgroundColor: FlutterFlowTheme.of(context).primary,
      onTap: (int i) => {
        debugPrint("Switching to screen: $i"),
        context.pushNamed(
          user
              ? NavigationRouteIDs.organizerRouteIDs[i]
              : NavigationRouteIDs.routeIDs[i],
          extra: <String, dynamic>{
            kTransitionInfoKey: TransitionInfo(
              hasTransition: true,
              transitionType: PageTransitionType.fade,
              duration: Duration(milliseconds: 500),
            ),
          },
        )
      },
    );
  }
}
