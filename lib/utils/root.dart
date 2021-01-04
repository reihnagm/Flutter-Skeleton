import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './api_helper.dart';
import '../views/widgets/home_widget.dart';
import '../views/widgets/onboarding_widget.dart';

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
        return OnboardingWidget();
      }
    }
    final CHttp _chttp = Provider.of<CHttp>(context, listen: false);
    _chttp.auth.isLoggedIn().then((val) {
      if (val) {
        setState(() {
          _goingHome = val;
          _isHomeLoading = false;
        });
      } else {
        _chttp.auth.isOnboardVisited().then((val) => setState(() {
          _goingHome = val;
          _isHomeLoading = false;
        }));
      }
    });
    return Container();
  }
}
