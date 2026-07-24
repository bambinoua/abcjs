import 'dart:js_interop';

import 'abcjs_interop_visual.dart';

@JS('ABCJS.TimingCallbacks')
extension type TimingCallbacks._(JSObject _) implements JSObject {
  external factory TimingCallbacks(Tune visualObj, TimingParams? params);

  /// This starts the timer that triggers the callbacks. This is called to both start and resume after calling pause.
  /// See the setProgress method below for explanation of the parameters with one special case:
  external void start();
  //external void start([JSNumber? position, String? units]);

  /// Pauses the animation. Calling start() afterwards will resume from where it left off.
  external void pause();

  /// Stop the animation. After calling this, the next call to start() will start at the beginning.
  external void stop();

  /// Move the timer back to the beginning, so the animation starts over. This can be called either when the animation is currently running or when it is paused.
  external void reset();

  /// Change the position of the animation. This allows random access to any place in the tune.
  /// If the second parameter is not present, then units equals "percent". The possible values are:
  external void setProgress(int position, [String? units]);
}

@JS()
extension type TimingParams._(JSObject _) implements JSObject {
  external TimingParams({
    /// Number of beats per minute.
    int? qpm,

    /// Don't start the callbacks right away, but insert this number of measures first.
    int? extraMeasuresAtBeginning = 0,

    /// How many callbacks should happen for each beat. This allows finer control in
    /// the client, for instance, to handle a progress bar.
    int? beatSubdivisions = 1,

    /// Called for each beat passing the beat number (starting at 0).
    ///
    /// Use [BeatCallback] prototype.
    JSExportedDartFunction? beatCallback,

    /// Called for each event (either a note, a rest, or a chord, and notes in separate
    /// voices are grouped together.)
    ///
    /// Use [EventCallback] prototype.
    JSExportedDartFunction? eventCallback,

    /// Called at the end of each line. (This is useful if you want to be sure the music
    /// is scrolled into view at the right time.) See lineEndAnticipation for more details.
    ///
    /// Use [LineEndCallback] prototype.
    JSExportedDartFunction? lineEndCallback,
  });
}
