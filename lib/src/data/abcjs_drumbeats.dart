/// See the ABC documentation for the correct way to format the string that is
/// passed as the [drum] parameter. Here is a table that provides a fairly
/// reasonable default for [drum], [drumIntro], and [drumBars] when used as
/// a metronome.
enum AbcJsDrumbeats {
  db2_4('2/4', DrumBeat('dd 76 77 60 30', 2)),
  db3_4('3/4', DrumBeat('ddd 76 77 77 60 30 30', 1)),
  db4_4('4/4', DrumBeat('dddd 76 77 77 77 60 30 30 30', 1)),
  db5_4('5/4', DrumBeat('ddddd 76 77 77 76 77 60 30 30 60 30', 1)),
  db6_8('6/8', DrumBeat('dd 76 77 60 30', 2)),
  db9_8('9/8', DrumBeat('ddd 76 77 77 60 30 30', 1)),
  db12_8('12/8', DrumBeat('dddd 76 77 77 77 60 30 30 30', 1)),
  cutTime('Cut Time', DrumBeat('dd 76 77 60 30', 2));

  const AbcJsDrumbeats(this.title, this.beat);

  final String title;
  final DrumBeat beat;
}

final class DrumBeat {
  /// drum pattern
  final String drum;

  /// drumIntro
  final int intro;

  const DrumBeat(this.drum, this.intro);
}
