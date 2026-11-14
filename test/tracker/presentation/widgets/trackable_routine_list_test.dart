import 'package:collection/collection.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:routrack/common/common.dart';
import 'package:routrack/tracker/tracker.dart';

import '../../../helper.dart';
import '../../../routine/domain/entities/routine_mocks.dart';
import '../../domain/entities/tracker_mock.dart';

void main() {
  final mockTrackableRoutines = mockRoutines
      .mapIndexed(
        (index, it) => TrackableRoutine(
          routine: it,
          lastTracked: index.isOdd ? mockTracker : null,
        ),
      )
      .toList();
  Future<void> pumpWidget(
    WidgetTester tester, {
    List<TrackableRoutine>? routines,
    OnTracktableRoutineChanged? onChanged,
  }) {
    return tester.pumpWidgetForTest(
      (context) => TrackableRoutineList(
        routines: routines ?? mockTrackableRoutines,
        isTracked: (trackable) => trackable.lastTracked != null,
        onChanged: onChanged,
      ),
    );
  }

  group('TrackableRoutineList', () {
    group('Render', () {
      testWidgets(
        'shows each trackable routine when routines is not empty',
        (tester) async {
          await pumpWidget(tester);

          for (final (index, trackable) in mockTrackableRoutines.indexed) {
            final routine = trackable.routine;
            final finder = find.ancestor(
              of: find.text(routine.name),
              matching: find.byType(TrackableRoutineListTile),
            );
            expect(finder, findsOneWidget);
            await tester.ensureVisible(finder);
            final widget = tester.widget<TrackableRoutineListTile>(finder);
            expect(widget.isTracked, index.isOdd);
          }
        },
      );

      testWidgets(
        'shows AppEmptyBox when routines is empty',
        (tester) async {
          await pumpWidget(tester, routines: []);

          final finder = find.byType(AppEmptyBox);
          final widget = tester.widget<AppEmptyBox>(finder);

          expect(finder, findsOne);
          expect(widget.title, 'Routines empty');
          expect(
            widget.content,
            'There is no routines that can be tracked this time',
          );
        },
      );
    });

    group('Interactions', () {
      testWidgets(
        'calls onPressed when on of routines is pressed',
        (tester) async {
          TrackableRoutine? pressedTrackable;
          var value = false;
          await pumpWidget(
            tester,
            onChanged: (context, trackable, {required isTracked}) {
              pressedTrackable = trackable;
              value = isTracked;
            },
          );

          final finder = find.ancestor(
            of: find.text(mockRoutines.first.name),
            matching: find.byType(TrackableRoutineListTile),
          );
          final widget = tester.widget<TrackableRoutineListTile>(finder);
          expect(widget.isTracked, isFalse);

          await tester.tap(finder);
          await tester.pumpAndSettle();
          final confirmButtonFinder = find.ancestor(
            of: find.text('Log it'),
            matching: find.byType(TextButton),
          );
          await tester.tap(confirmButtonFinder);

          expect(pressedTrackable, mockTrackableRoutines.first);
          expect(value, isTrue);
        },
      );
    });
  });
}
