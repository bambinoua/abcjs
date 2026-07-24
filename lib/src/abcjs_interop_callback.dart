import 'dart:js_interop';

import 'package:web/web.dart';

typedef RenderClickListener =
    Function(
      /// The internal object that is associated with the element clicked.
      /// Use a debugger to see what is available.
      JSAny abcelem,

      /// If there are more than one tune in the original abcString,
      /// this reports which tune was clicked on.
      int tuneNumber,

      /// The css classes of the element that was clicked.
      /// (This requires the parameter { add_classes: true }).
      JSArray<JSString> classes,

      /// An object containing the following info about the item clicked.
      ClickItemInfo analysis,

      /// See the Dragging page for more details.
      JSAny drag,

      /// The original event that triggered this callback.
      JSAny mouseEvent,
    );

typedef EventCallback = Function(TimingEvent event);

typedef LineEndCallback =
    Function(LineEndInfo info, Event event, LineEndDetails details);

typedef BeatCallback =
    Function(
      int beatNumber,
      int totalBeats,
      double totalTime,
      BeatPosition position,
      BeatDebugInfo debugInfo,
    );

@JS()
extension type ClickItemInfo._(JSObject _) implements JSObject {}

@JS()
extension type LineEndInfo._(JSObject _) implements JSObject {
  external int measureNumber;
  external int milliseconds;
  external double top;
  external double bottom;
}

@JS()
extension type LineEndDetails._(JSObject _) implements JSObject {
  external int line;
  external JSArray<LineEndInfo> endTimings;
  external double currentTime;
}

@JS()
extension type BeatPosition._(JSObject _) implements JSObject {
  external double top;
  external double height;
  external double left;
}

@JS()
extension type BeatDebugInfo._(JSObject _) implements JSObject {
  external double timestamp;
  external double startTime;
  @JS('ev')
  external TimingEvent event;
  external int endMs;
  external int offMs;
  external int offPx;
  external int gapMs;
  external double gapPx;
}

@JS()
extension type TimingEvent._(JSObject _) implements JSObject {
  external String type;
  external int milliseconds;
  external int line;
  external int measureNumber;
  external double top;
  external double height;
  external double left;
  external double width;
  external int startChar;
  external JSArray<JSArray<JSString>> elements;
  external int endChar;
  external JSArray<JSNumber> startCharArray;
  external JSArray<JSNumber> endCharArray;
  external JSArray<MidiPitch> midiPitches;
  external double endX;
  external double millisecondsPerMeasure;
}

@JS()
extension type MidiPitch._(JSObject _) implements JSObject {
  external String cmd;
  external int pitch;
  external int volume;
  external double start;
  external double duration;
  external int instrument;
  external int startChar;
  external int endChar;
  external int gap;
}
