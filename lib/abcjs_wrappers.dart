import 'dart:js_interop';

import 'src/abcjs_utils.dart';

/// Standard MIDI instrument helper.
abstract final class AbcjsInstruments {
  /// Returns name by its [index].
  static String getName(int index) {
    try {
      return instrumentIndexToName[index].toDart;
    } catch (e) {
      throw ArgumentError.value(index, 'index', 'Invalid instrument index');
    }
  }
}

/// Standard MIDI pitch helper.
abstract final class AbcjsPitches {
  /// Returns name by its [index].
  static String getName(int index) {
    try {
      return pitchToNoteName[index].toDart;
    } catch (e) {
      throw ArgumentError.value(index, 'index', 'Invalid pitch index');
    }
  }
}
