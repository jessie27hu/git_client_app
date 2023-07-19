import 'package:flutter/material.dart';

abstract class LoadingIndicator {
  Widget build(BuildContext context);
}

class DefaultIndicator implements LoadingIndicator {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 200,
      alignment: Alignment.center,
      child: const CircularProgressIndicator(
        strokeWidth: 5,
      ),
    );
  }
}
