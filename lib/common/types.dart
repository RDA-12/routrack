/// Weekday
enum WeekDay(final String rrule, final String name) {
  /// Monday
  mon('MO', 'Monday'),

  /// Tuesday
  tue('TU', 'Tuesday'),

  /// Wednesday
  wed('WE', 'Wednesday'),

  /// Thursday
  thu('TH', 'Thursday'),

  /// Friday
  fri('FR', 'Friday'),

  /// Saturday
  sat('SA', 'Saturday'),

  /// Sunday
  sun('SU', 'Sunday');

  factory fromInt(int value) {
    switch (value) {
      case 1:
        return WeekDay.mon;
      case 2:
        return WeekDay.tue;
      case 3:
        return WeekDay.wed;
      case 4:
        return WeekDay.thu;
      case 5:
        return WeekDay.fri;
      case 6:
        return WeekDay.sat;
      case 7:
        return WeekDay.sun;
      case _:
      throw ArgumentError('value must be between 1-7');
    }
  }
}

/// Schedule status
enum ScheduleStatus {
  /// Schedule is active
  active,

  /// Schedule is inactive
  inactive,
}
