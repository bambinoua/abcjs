/// Represents an item of [AbcJsUnits]
typedef SeekUnit = String;

abstract final class AbcJsUnits {
  /// The percent passed in is a number between 0 and 1. This can be called either
  /// when the animation is currently running or when it is paused.
  static const percent = 'percent';

  /// The seconds from the beginning of the tune. If this is passed the end of the
  /// tune it is changed to the end.
  static const seconds = 'seconds';

  /// The beats from the beginning of the tune. If this is passed the end of the tune
  /// it is changed to the end.
  static const beats = 'beats';
}
