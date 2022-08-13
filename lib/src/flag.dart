import 'enums/flag_type.dart';

class Flag {
  final FlagType type;
  final DateTime firstFlagged;
  final DateTime mostRecentlyFlagged;

  /// A null ignoredUntil value, or a non-null value before the present, means
  /// this flag is set and should be treated accordingly.
  /// A non-null ignoredUntil value which is after the present indicates this
  /// flag is set, but should be ignored — i.e. treated as if not flagged.
  /// The max time further indicates that the flag should be ignored forever.
  final DateTime? ignoredUntil;

  Flag({
    required this.type,
    required this.firstFlagged,
    required this.mostRecentlyFlagged,
    this.ignoredUntil,
  });

  static Flag? fromJson(dynamic json) {
    if (json == null) {
      return null;
    }
    return Flag(
      type: FlagType.values[json['type'] as int],
      firstFlagged:
          DateTime.fromMillisecondsSinceEpoch(json['firstFlagged'] as int),
      mostRecentlyFlagged: DateTime.fromMillisecondsSinceEpoch(
          json['mostRecentlyFlagged'] as int),
      ignoredUntil: json['ignoredUntil'] == null
          ? null
          : DateTime.fromMillisecondsSinceEpoch(
              1000 * json['ignoredUntil'] as int,
            ),
    );
  }

  @override
  String toString() {
    return 'Flag{type: $type, firstFlagged: $firstFlagged, mostRecentlyFlagged: $mostRecentlyFlagged, ignoredUntil: $ignoredUntil}';
  }
}
