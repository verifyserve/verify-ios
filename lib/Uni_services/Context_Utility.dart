import 'package:flutter/cupertino.dart';

class ContextUtility {

  static final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();
  static GlobalKey<NavigatorState> get navigoterKey => _navigatorKey;

  static NavigatorState? get navigator => navigoterKey.currentState;

  static BuildContext? get context => navigator?.overlay?.context;

}