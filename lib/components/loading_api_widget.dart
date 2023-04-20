import 'package:flutter/material.dart';

typedef SuccessApiBuilder<T> = Widget Function(BuildContext context, T data);

class LoadApiWidget<T> extends StatefulWidget {
  final SuccessApiBuilder<T> successBuilder;
  final Widget? errorBuilder;
  final Widget? loadingBuilder;
  final Future<T> fetchDataFunction;
  final String? errorMessage;

  const LoadApiWidget(
      {Key? key,
      required this.successBuilder,
      this.errorBuilder,
      this.loadingBuilder,
      required this.fetchDataFunction,
      this.errorMessage})
      : super(key: key);

  @override
  State<LoadApiWidget<T>> createState() => _LoadApiWidgetState<T>();
}

class _LoadApiWidgetState<T> extends State<LoadApiWidget<T>> {
  late Future<T> _fetch;

  @override
  void initState() {
    _fetch = widget.fetchDataFunction;
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<T>(
        future: _fetch,
        builder: (context, snapshot) {
          T? response = snapshot.data;
          if (response != null &&
              snapshot.connectionState == ConnectionState.done) {
            return widget.successBuilder(context, response);
          } else if (response == null &&
              snapshot.connectionState == ConnectionState.done) {
            return widget.errorBuilder ??
                const Center(
                  child: Text('Error'),
                );
          } else {
            return widget.loadingBuilder ??
                const Center(
                  child: CircularProgressIndicator(),
                );
          }
        });
  }
}
