import 'dart:js_interop';

@JS()
extension type RenderOptions._(JSObject _) implements JSObject {
  external factory RenderOptions({
    /// If true, then the accent mark (!>!) always goes above the note instead
    /// of being attached to the note head.
    bool? accentAbove = false,

    /// If true, then each element that is drawn on the SVG will have an identifying
    /// class with it that you can use to style, move, or hide the element. See the
    /// section on classes for more details.
    @JS('add_classes') bool? addClasses = false,

    /// Default: undefined Either "noMusic" or "withMusic"
    ///
    /// If this is present, then a chord grid appears above the music. This only works
    /// in 4/4 time and only if chords are defined in the music.
    ///
    /// If the value is "noMusic" then the staff lines are not printed. If the value
    /// is "withMusic" then the grid is printed above the regular staff lines.
    String? chordGrid,

    /// Callback function. The signature of the function is [RenderClickListener].
    /// This is called whenever the user clicks on a note or selects a series of notes.
    ///
    /// For more details, see the page on the click listener.
    JSExportedDartFunction? clickListener,
    bool? expandToWidest = false,
    String? foregroundColor,
    bool? initialClef = false,
    double lineThickness = 1,
    double? minPadding = 0,
    bool? oneSvgPerLine = false,
    @JS('paddingbottom') double? paddingBottom = 30,
    @JS('paddingleft') double? paddingLeft = 15,
    @JS('paddingright') double? paddingRight = 50,
    @JS('paddingtop') double? paddingTop = 15,
    String? responsive = 'resize',
    double? scale = 1,
    bool? scrollHorizontal = false,
    String? selectionColor = '#ff0000',

    /// ['grid', 'box']
    JSArray<JSString>? showDebug,
    @JS('stafftopmargin') double? staffTopMargin = 0,
    @JS('staffwidth') double? staffWidth = 740,
    @JS('textboxpadding') double? textboxPadding = 0.1,
    bool? viewportHorizontal = false,
    bool? viewportVertical = false,
    JSObject? wrap,
  });
}

@JS()
/// The object contains a lot of information about the tune that was rendered.
extension type Tune(JSObject _) implements JSObject {
  /// This contains a list of the fonts used for the various types of elements and
  /// other formatting commands that have been either passed in on the renderAbc
  /// call or appear in %% lines.
  external JSObject get formatting;

  /// This is an array of all the music. Each item in the array is a "staff system".
  /// That is, it could be one staff for single instrument music, it could be
  /// two staves for piano music, or it could be more for ensemble music.
  external JSArray<JSObject> get lines;

  /// Either "screen" or "print". When printing, the margins and the header and
  /// footer are used.
  external String get media;

  /// This is all of the items that aren't associated with the music. That
  /// includes the text that appears before the music starts and the text that
  /// appears after the music ends.
  external JSObject get metaText;

  /// The version of this format.
  external String get version;

  /// This does the calculation using beats per minute and beats per measure.
  external double millisecondsPerMeasure();

  /// This returns an object with the properties num and den. For instance, 3/4
  /// time returns `{num: 3, den: 4}`. Common and Cut time are resolved to
  /// `{num: 4, den: 4}` and `{num: 2, den: 2}` respectively.
  external JSObject getMeterFraction();

  /// Returns undefined until [setUpAudio] is called, then it returns the total
  /// number of seconds that the tune will take at the tempo that was specified
  /// in [setUpAudio].
  external double? getTotalTime();

  /// Returns undefined until setUpAudio is called, then it returns the total
  /// number of beats that the tune has.
  external int? getTotalBeats();

  /// This is the starting beats per minute. Tempo changes could appear later
  /// in the tune, but this is the value that was set with the `Q:` statement, or
  /// if that statement doesn't exist, it is the default tempo of 180.
  external JSAny getBpm([JSObject? tempoProperties]);

  /// Durations have units where a whole note is 1. This returns how long a measure is.
  /// For example, 4/4 time returns 1, 3/4 time returns 0.75, 6/8 time returns 0.75.
  external double getBarLength();

  /// Durations have units where a whole note is 1. This returns how long a beat is.
  /// For example, 4/4 time returns 0.25, 6/8 time returns 0.375 since a beat is three
  /// eighth notes.
  external double getBeatLength();

  /// This returns how many beats are in a measure.
  /// For example, 4/4 time returns 4, 6/8 time returns 2 since a beat is three eighth
  /// notes.
  external int getBeatsPerMeasure();

  /// This returns the internal representation of the key signature with all of its pieces
  /// broken apart.
  external JSAny getKeySignature();

  /// charIndex is a character position in the original ABC. This searches through
  /// the tune for the element that matches that character. If you pass in the index of
  /// a non-note element it returns null.
  external JSAny getElementFromChar(int charIndex);

  /// If you aren't using the built in synth, but you still want the information that the
  /// synth provides, call this. If you aren't overriding the BPM or anything else that can
  /// be set in the synth call, you can call this with no parameters.
  /// Otherwise specify the items you want to override.
  ///
  /// This returns an array of all the sequence data. Normally you won't need this information,
  /// but there may be cases where it is useful for post-processing.
  external JSAny setUpAudio([JSObject? options]);
}
