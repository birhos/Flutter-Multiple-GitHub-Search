import 'package:flutter/material.dart';

class SearchLoadingWidget extends StatelessWidget {
  SearchLoadingWidget();

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: FractionalOffset.center,
      child: CircularProgressIndicator(),
    );
  }
}
