import 'dart:js_interop';

import 'package:web/web.dart';

import 'abcjs_interop_audio.dart';
import 'abcjs_interop_visual.dart';

@JS('ABCJS')
/// The main entry point to draw standard music notation is ABCJS.renderAbc
external ABCJS get abcjs;

@JS()
/// The easiest way to get the music drawn is by creating a <div> on the page
/// and passing that element or its ID and an ABC string representing a
/// single tune to that routine.
extension type ABCJS(JSObject _) implements JSObject {
  /// Renders a [abcText] inside [target] &lt;div&gt; with [options].
  ///
  /// Returns an array of [Tune]s.
  external JSArray<Tune> renderAbc(
    /// The HTML element as a placeholder for render sheetmusic.
    HTMLElement target,

    /// The ABC notation text
    String abcText, [

    /// Optional render options
    RenderOptions? options,
  ]);

  /// The reference object to work with (MIDI/Audio).
  external Synth get synth;
}
