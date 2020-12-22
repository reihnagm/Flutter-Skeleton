import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './api_helper.dart';
import '../views/widgets/home_widget.dart';
import '../views/onboarding.dart';

class RootWidget extends StatefulWidget {
  @override
  _RootWidgetState createState() => _RootWidgetState();
}

class _RootWidgetState extends State<RootWidget> {
  bool _isHomeLoading = true;
  bool _goingHome = true;

  @override
  Widget build(BuildContext context) {
    if (!_isHomeLoading) {
      if (_goingHome) {
        return HomeWidget();
      } else {
        return Onboarding();
      }
    }
    final CHttp _cn = Provider.of<CHttp>(context, listen: false);
    _cn.auth.isLoggedIn().then((val) {
      if (val) {
        setState(() {
          _isHomeLoading = false;
          _goingHome = val;
        });
      } else {
        _cn.auth.isOnboardVisited().then((val) => setState(() {
          _isHomeLoading = false;
          _goingHome = val;
        }));
      }
    });
    return Container();
  }
}
