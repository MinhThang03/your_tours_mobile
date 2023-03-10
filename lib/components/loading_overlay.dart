import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoadingOverlay {
  BuildContext _context;

  LoadingOverlay._create(this._context);

  factory LoadingOverlay.of(context) {
    return LoadingOverlay._create(context);
  }

  void show({Widget? loadingIndicator}) {
    showDialog(
        context: _context,
        barrierDismissible: false,
        builder: (context) => WillPopScope(
            onWillPop: () async => false,
            child: loadingIndicator ?? _DefaultLoadingIndicator()));
  }

  void hide() {
    Navigator.pop(_context);
  }

  Future<T> during<T>({required Future<T> future, Widget? loadingIndicator}) {
    show(loadingIndicator: loadingIndicator);
    return future.whenComplete(hide);
  }
}

class _DefaultLoadingIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Platform.isIOS
            ? const CupertinoActivityIndicator()
            : const CircularProgressIndicator());
  }
}
