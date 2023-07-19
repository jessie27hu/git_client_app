import 'package:flutter/material.dart';
import 'package:git_client_app/common/loading/loading_indicator.dart';

class LoadingManager {
  static LoadingManager? _instance;
  BuildContext? _context;
  late OverlayEntry _overlayEntry;
  //私有构造函数
  LoadingManager._();

  static LoadingManager get instance {
    _instance ??= LoadingManager._();
    return _instance!;
  }

  static void initialize({required BuildContext context}) {
    instance._context = context;
  }

  static void reset() {
    _instance = null;
  }

  void show({LoadingIndicator? indicator}) {
    indicator ??= DefaultIndicator();
    if (_context == null) {
      return;
    }
    _overlayEntry =
        OverlayEntry(builder: (context) => indicator!.build(context));

    try {
      Overlay.of(_context!).insert(_overlayEntry);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void showCustom({required Widget indicator}) {}

  void hide() {
    _overlayEntry.remove();
  }
}
