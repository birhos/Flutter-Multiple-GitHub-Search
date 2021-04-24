import 'package:flutter/material.dart';

class SearchLoadingWidget extends StatelessWidget {
  const SearchLoadingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: FractionalOffset.center,
      child: CircularProgressIndicator(),
    );
  }
}