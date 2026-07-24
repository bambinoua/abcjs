import 'dart:js_interop';

@staticInterop
/// If the qpm parameter is not supplied, abcjs makes its best guess about what
/// tempo should be used. If there is no tempo indicated at all in the ABC string,
/// then 180 BPM is arbitrarily used. If defaultQpm is supplied, then that default
/// will be used only if there is no explicit tempo.
///
/// If an exact tempo line is supplied with the Q: line, then that tempo is used.
/// If the Q: contains a standard tempo string, that string is used to make a guess
/// at an appropriate tempo. Here is a list of the known tempo strings and their
/// associated tempos. If you would like to make suggestions about other strings
/// to support or changes to these tempos, please get in touch:
abstract final class AbcjsTempos {
  static const larghissimo = 20;
  static const adagissimo = 24;
  static const sostenuto = 28;
  static const grave = 32;
  static const largo = 40;
  static const lento = 50;
  static const larghetto = 60;
  static const adagio = 68;
  static const adagietto = 74;
  static const andante = 80;
  static const andantino = 88;
  static const marciaModerato = 84;
  static const andanteModerato = 100;
  static const moderato = 112;
  static const allegretto = 116;
  static const allegroModerato = 120;
  static const allegro = 126;
  static const animato = 132;
  static const agitato = 140;
  static const veloce = 148;
  static const mossoVivo = 156;
  static const vivace = 164;
  static const vivacissimo = 172;
  static const allegrissimo = 176;
  static const presto = 184;
  static const prestissimo = 210;
}
