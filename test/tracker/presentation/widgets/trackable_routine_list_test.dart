import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:routrack/common/common.dart';
import 'package:routrack/tracker/tracker.dart';

import '../../../helper.dart';
import '../../domain/entities/tracker_mock.dart';

void main() {
  Future<void> pumpWidget(
    WidgetTester tester, {
    List<TrackableRoutineUI>? routines,
    OnTracktableRoutineChanged? onChanged,
  }) {
    return tester.pumpWidgetForTest(
      (context) => TrackableRoutineList(
        trackables: routines ?? mockTrackableRoutinesUI,
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

          for (final trackable in mockTrackableRoutinesUI) {
            final routine = trackable.trackable.routine;
            final finder = find.ancestor(
              of: find.text(routine.name),
              matching: find.byType(TrackableRoutineListTile),
            );
            expect(finder, findsOneWidget);
            await tester.ensureVisible(finder);
            final widget = tester.widget<TrackableRoutineListTile>(finder);
            expect(widget.isTracked, trackable.isTracked);
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
          TrackableRoutineUI? pressedTrackable;
          var value = false;
          await pumpWidget(
            tester,
            onChanged: (context, trackable, {required isTracked}) {
              pressedTrackable = trackable;
              value = isTracked;
            },
          );

          final finder = find.ancestor(
            of: find.text(mockTrackableRoutinesUI.first.trackable.routine.name),
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

          expect(pressedTrackable, mockTrackableRoutinesUI.first);
          expect(value, isTrue);
        },
      );
    });
  });
}
