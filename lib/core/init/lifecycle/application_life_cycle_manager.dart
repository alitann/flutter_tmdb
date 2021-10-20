import 'package:flutter/material.dart';

class ApplicationLifeCycleManager extends StatefulWidget {
  const ApplicationLifeCycleManager({Key? key, required this.child})
      : super(key: key);

  final Widget child;

  @override
  _ApplicationLifeCycleManagerState createState() =>
      _ApplicationLifeCycleManagerState();
}

class _ApplicationLifeCycleManagerState
    extends State<ApplicationLifeCycleManager> with WidgetsBindingObserver {
  @override
  Widget build(BuildContext context) {
    return widget.child;
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    // ignore: avoid_print
    print('AppLifecycleState : $state');
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addObserver(this);
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance!.removeObserver(this);
  }
}
