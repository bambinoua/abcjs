import 'dart:js_interop';

@JS('ABCJS.synth.activeAudioContext')
external JSObject get activeAudioContext;

@JS('ABCJS.synth.instrumentIndexToName')
/// This is an array that converts the standard MIDI instrument
/// indexes to a name.
external JSArray<JSString> get instrumentIndexToName;

@JS('ABCJS.synth.pitchToNoteName')
/// This is an array that converts the standard MIDI pitch
/// indexes to a name.
external JSArray<JSString> get pitchToNoteName;
