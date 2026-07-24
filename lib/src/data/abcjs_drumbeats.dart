enum AbcjsDrumbeats {
  db2_4('2/4', DrumInfo('dd 76 77 60 30', 2)),
  db3_4('3/4', DrumInfo('ddd 76 77 77 60 30 30', 1)),
  db4_4('4/4', DrumInfo('dddd 76 77 77 77 60 30 30 30', 1)),
  db5_4('5/4', DrumInfo('ddddd 76 77 77 76 77 60 30 30 60 30', 1)),
  db6_8('6/8', DrumInfo('dd 76 77 60 30', 2)),
  db9_8('9/8', DrumInfo('ddd 76 77 77 60 30 30', 1)),
  db12_8('12/8', DrumInfo('dddd 76 77 77 77 60 30 30 30', 1)),
  cutTime('Cut Time', DrumInfo('dd 76 77 60 30', 2));

  const AbcjsDrumbeats(this.label, this.info);

  final String label;
  final DrumInfo info;
}

// the array is [0]=drum [1]=drumIntro
final class DrumInfo {
  final String pattern;
  final int position;

  const DrumInfo(this.pattern, this.position);
}
