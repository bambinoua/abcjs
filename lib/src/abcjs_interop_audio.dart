import 'dart:js_interop';
import 'package:web/web.dart';

import 'abcjs_interop_visual.dart';
import 'data/abcjs_units.dart';

@JS()
extension type Synth(JSObject _) implements JSObject {
  /// Returns `true` if the browser supports [AudioContext].
  external bool supportsAudio();
}

@JS('ABCJS.synth.CreateSynth')
/// Creates the object that caches and buffers the audio to be played.
///
/// All implementations of audio playback will need a [CreateSynth].
extension type CreateSynth._(JSObject _) implements JSObject {
  external factory CreateSynth();

  /// Indicates whethe synth is running.
  external bool get isRunning;

  /// The first call that must be made on the CreateSynth object. This will load all
  /// of the needed notes and will return a promise when they are loaded. There might
  /// be a considerable delay for this to finish. Because the notes are cached, though,
  /// the second time CreateSynth is created with a piece of music with similar notes,
  /// it will take much less time. See below for the synthOptions.
  external JSPromise<CreateSynthInitResult> init([CreateSynthOptions? options]);

  /// This creates the actual buffer - it doesn't require a network connection since
  /// all the notes have now been preloaded. It returns a promise because there might
  /// be a little bit of time delay doing the calculations.
  external JSPromise<CreateSynthPrimeResult> prime();

  /// This starts the audio.
  external void start();

  /// This pauses the audio.
  external void pause();

  /// This resumes the audio.
  external void resume();

  /// Stops playing the sound and resets the progress to the beginning of the
  /// sound file.
  external void stop();

  /// This changes the playback position. It can be called whether the sound is
  /// currently playing or not.
  ///
  /// If the second parameter is not present, then units equals "percent".
  /// The possible values are:
  /// - "percent": The percent passed in is a number between 0 and 1. This can be
  ///    called either when the animation is currently running or when it is paused.
  /// - "seconds": The seconds from the beginning of the tune. If this is passed the
  ///    end of the tune it is changed to the end.
  /// - "beats": The beats from the beginning of the tune. If this is passed the end
  ///    of the tune it is changed to the end.
  external void seek(JSNumber position, [SeekUnit? units = SeekUnits.percent]);

  /// This returns the audio buffer created. (It is in WAV format.)
  external void download();

  /// This returns the AudioBuffer that was created in the the prime() call.
  external JSAny getAudioBuffer();
}

@JS()
extension type CreateSynthOptions._(JSObject _) implements JSObject {
  external factory CreateSynthOptions({
    /// This is the result of renderAbc(). Important: renderAbc() returns an
    /// array, since an ABC string can contain more than one tune.
    /// This variable is just one element in that array. Either this must be
    /// supplied, or sequence must be supplied.
    Tune? visualObj,

    /// This is a manually-created set of instructions for creating the audio.
    /// It is built using the SynthSequence object.
    SynthSequence? sequence,

    /// This allows control over the tempo. If this is present, then the tempo
    /// specified in the `ABC string` is ignored.
    int? millisecondsPerMeasure,

    /// This will be called with various extra info at different times in the process.
    JSFunction? debugCallback,

    /// Some options for the sound creation (see list below)
    CreateSynthOptionsOptions? options,
  });
}

@JS()
extension type CreateSynthOptionsOptions._(JSObject _) implements JSObject {
  external factory CreateSynthOptionsOptions({
    /// This is the public URL for the sound font. If it isn't present, then the
    /// sound fonts come from the github repo.
    ///
    /// This can be replaced if the new sound font follows the same format. If not
    /// defined, the soundfont comes from "https://github.com/paulrosen/midi-js-soundfonts"
    String? soundFontUrl,

    /// This is the amount to multiply all the volumes to compensate for different
    /// volume soundfonts. If you find that either the volume is too low or the output is
    /// clipped, you can experiment with this number.
    double? soundFontVolumeMultiplier = 1.0,

    /// { 'program_name': 100 }
    JSObject? programOffsets,

    /// The number of milliseconds to fade out each note after its has played for the correct
    /// length. The gain will go from 100% to 0% in this number of milliseconds.
    int? fadeLength = 200,

    /// An array of numbers between -1 and 1 for how far to pan each track. -1 is all the way
    /// to the left and 1 is all the way to the right. If there are not enough items in the array
    /// for all the tracks, then the remaining tracks will be in the middle.
    JSArray<JSNumber> pan, // = [0...],
  });
}

@JS()
extension type CreateSynthInitResult._(JSObject _) implements JSObject {
  external JSArray<JSString> cached;
  external JSArray<JSString> error;
  external JSArray<JSString> loaded;
}

@JS()
extension type CreateSynthPrimeResult._(JSObject _) implements JSObject {
  /// AudioContext status
  external String status;

  /// Length in seconds of audio
  external double duration;
}

@JS('ABCJS.synth.SynthController')
/// Creates a visual widget that allows the user to control playback, including
/// play and stop buttons, a progress bar, etc. This is the quickest way to
/// set up a playback widget. See the section below for options.
extension type SynthController._(JSObject _) implements JSObject {
  external factory SynthController();

  /// After the DOM is loaded, this should be called to initialize the visual widget
  /// that contains the "play", etc. buttons.
  ///
  ///While this can be called multiple times, it is generally just called once during
  ///initialization.
  external void load(
    /// This is a CSS-style selector of the element that should be turned into the
    /// audio control.
    HTMLElement selector, [

    /// This is an optional object that can be passed in that will receive callbacks
    /// when events happen that should move the cursor.
    ///
    /// See the section on "CursorControl" for more info.
    CursorControl? cursorControl,

    /// This is a hash with the following possible properties
    VisualOptions? visualOptions,
  ]);

  /// This is called whenever there is a new tune ready to be loaded into the player.
  external JSPromise<JSObject> setTune(
    /// This is one of the tunes that is returned from the renderAbc() call. That is,
    /// renderAbc will return an array of tunes. Often it is an array of length 1 if
    /// there is only one tune in the abc string, but it could be multiple tunes.
    Tune visualObj,

    /// True if this is being called inside an event handler from a user gesture.
    /// The audio buffer can't be created until then. If this is true, then the audio
    /// buffer is created immediately. If this is false then the audio buffer is not
    /// created until the user clicks the play button.
    bool userAction,

    /// Here are the possible properties.
    AudioParams audioParams,
  );

  external bool isStarted;
  external int currentTempo;

  /// This is called internally when waiting for the audio to finish loading. It can
  /// also be called directly by the client. The most common use for that is to disable
  /// the visual control when you are about to load in a new tune.
  external void disable(bool isDisabled);
  external void go();
  external void destroy();

  /// Start playback programmatically.
  external void play();

  /// Pausee playbacl programmatically.
  external void pause();

  /// Re-starts playback programmatically.
  external void restart();
  external void toggleLoop();
  external void sleep(int milliseconds);
  external void seek(JSNumber percent, [SeekUnit? units = SeekUnits.percent]);

  /// This changes the tempo to the percent passed in. That should be a positive integer.
  /// It will change the tempo immediately if the music is already playing.
  external void setWarp(double newWarp);
  external void setProgress(JSNumber percent, JSNumber? totalTime);
  external void beatCallback(
    int beatNumber,
    int totalBeats,
    JSNumber totalTime,
    JSObject position,
  );
  external void eventCallback(JSObject event);

  /// This will download the current audio buffer as a WAV file to the fileName passed in.
  external void download(String fileName);
}

@JS()
extension type VisualOptions._(JSObject _) implements JSObject {
  external factory VisualOptions({
    /// Whether to display a button that the user can press to make the tune start
    /// playing. (Note: this turns into the "pause" button when the tune is playing.)
    bool displayPlay = true,

    /// Whether to display the progress slider. The user can click anywhere on this
    /// to get the music to jump to that location.
    bool displayProgress = true,

    /// Whether to display a button that the user can press to make the tune loop
    /// instead of stopping when it gets to the end.
    bool displayLoop = false,

    /// Whether to display a button that the user can press to make the tune go back
    /// to the beginning.
    bool displayRestart = false,

    /// Whether to display the tempo and allow the user to change it on the fly.
    bool displayWarp = false,
  });
}

@JS()
extension type AudioParams._(JSObject _) implements JSObject {
  external factory AudioParams({
    /// The publicly available URL of the soundfont to use.
    String? soundFontUrl,

    /// This is the amount to multiply all the volumes to compensate for different
    /// volume soundfonts. If you find that either the volume is too low or the
    /// output is clipped, you can experiment with this number.
    double? soundFontVolumeMultiplier = 1.0,

    /// An override of the tempo in the tune.
    double? millisecondsPerMeasure,

    /// The object returned from renderAbc
    Tune? visualObj,

    /// Options to pass to the low-level buffer creation routines.
    AudioParamsOptions? options,

    /// A callback function when the AudioBuffer finishes playing.
    JSExportedDartFunction? onEnded,
  });
}

@JS()
/// The options element above can have the following properties:
extension type AudioParamsOptions._(JSObject _) implements JSObject {
  external factory AudioParamsOptions({
    /// If true, then don't turn the guitar chord symbols into sound. (But do play
    /// the metronome if there is one.)
    bool? chordsOff = false,

    /// If true, play the metronome and accompaniment; do the animation callbacks,
    /// but don't play any melody lines. This can also be an array of voices to turn off.
    /// The voices are numbered starting at zero.
    bool? voicesOff = false,

    /// The midi program (aka "instrument") to use, if not specified in ABC string.
    int? program = 0,

    /// Whether to add a drum (or metronome) track. A string formatted like the `%%MIDI` drum
    /// specification. Using this parameter also implies `%%MIDI drumon`. See the section
    ///  for "Drum Parameter" for an explanation.
    String? drum,

    /// How many bars to spread the drum pattern over. See the section for "Drum Parameter"
    ///  for an explanation.
    int? drumBars = 1,

    /// The number of measures of count in beats before the music starts.
    int? drumIntro = 0,

    /// If you want a metronome only for the intro measures but not when the tune starts,
    /// use this along with the drumIntro and drum params. This has no effect if either
    /// one of those is missing.
    bool? drumOff = false,

    /// The tempo to use. This overrides a tempo that is in the tune.
    int? qpm,

    /// The tempo to use, only if there is no tempo in the tune.
    int? defaultQpm,

    /// The number of half-steps to transpose everything, if not specified in ABC string.
    int? midiTranspose = 0,

    /// The "midi channel" to use. This isn't particularly useful except that specifying
    /// channel 10 means to use the percussion sounds.
    int? channel = 0,
  });
}

@JS()
/// Control the cursor when creating [SynthController].
extension type CursorControl._(JSObject _) implements JSObject {
  external factory CursorControl();
}

@JS('ABCJS.synth.CreateSynthControl')
/// Lower level object than SynthController if you want the functionality without
/// the visible control.
///
/// [element] is either a string representing a selector of an existing element
/// on the page or a DOM element. The contents of that element are replaced with
/// an audio control.
extension type CreateSynthControl._(JSObject _) implements JSObject {
  external factory CreateSynthControl(
    HTMLElement element, [
    CreateSynthControlOptions? options,
  ]);

  external void disable(bool idDisabled);
  external void setWarp(int tempo, double warp);
  external void setTempo(int tempo);
  external void resetAll();
  external void pushPlay([String? push]);
  external void pushLoop([String? push]);
  external void setProgress(double percent, double totalTime);
}

@JS()
/// Options for [CreateSynthControl].
extension type CreateSynthControlOptions._(JSObject _) implements JSObject {
  external factory CreateSynthControlOptions({
    /// Callback function when the loop button is clicked. If this is not present, then the loop button is not displayed.
    JSFunction? loopHandler,

    /// Callback function when the restart button is clicked. if this is not present, then the restart button is not displayed.
    JSFunction? restartHandler,

    /// Callback function when the play button is clicked. if this is not present, then the play button is not displayed. If the handler version is present, then it must return a promise.
    JSFunction? playHandler,

    /// Callback function when the progress bar is clicked. if this is not present, then the progress bar is not displayed.
    JSFunction? progressHandler,

    /// Callback function when the warp percent is changed. if this is not present, then the warp percent is not displayed.
    JSFunction? warpHandler,

    /// Callback function after the AudioContext is set up correctly.
    JSFunction? afterResume,

    /// Whether to display a clock on the control
    bool? hasClock = false,

    /// To override the text "BPM" for beats per minute
    int? bpm,
  });
}

@JS('ABCJS.synth.SynthSequence')
/// Creates an object that builds data for [CreateSynth]. This is normally done
/// internally if [CreateSynth] is passed a visual object, but this is a way to
/// custom build any sequence.
extension type SynthSequence._(JSObject _) implements JSObject {
  external factory SynthSequence();
}
