import 'package:material_ui/material_ui.dart';
import 'package:routrack/common/common.dart';

/// Controller for [WeekDaySelector]
final class WeekDaySelectorController extends ChangeNotifier {
  /// Creates new [WeekDaySelectorController]
  new({Set<WeekDay> initialSelected = const {}})
    : _selected = Set.from(initialSelected);

  final Set<WeekDay> _selected;

  /// Returns list of selected weekdays
  Set<WeekDay> get selected => _selected;

  /// Select [day] to selected list
  void select(WeekDay day) {
    _selected.add(day);
    notifyListeners();
  }

  /// Select all [WeekDay]
  void selectAll() {
    _selected.addAll(WeekDay.values);
    notifyListeners();
  }

  /// Remove [day] from selected list
  void deselect(WeekDay day) {
    _selected.remove(day);
    notifyListeners();
  }

  /// Clear selected [WeekDay]
  void clear() {
    _selected.clear();
    notifyListeners();
  }

  /// Whether [day] is selected or not
  bool isSelected(WeekDay day) {
    return _selected.contains(day);
  }

  /// Returns null when [WeekDay] partially selected, false when no [WeekDay] is
  /// selected, true when all [WeekDay]s are selected
  bool? get tristate {
    if (_selected.isEmpty) return false;
    if (_selected.length < WeekDay.values.length) return null;
    return true;
  }
}

/// Shows list of [WeekDay] in checkboxes
class WeekDaySelector extends StatelessWidget {
  /// Creates new [WeekDaySelector]
  const new({required this.controller, required this.label, super.key});

  /// Controls this [WeekDaySelector]
  final WeekDaySelectorController controller;

  /// Label placed before the checkboxes
  final String label;

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: controller,
      builder: (context, _) {
        return Column(
          spacing: 4,
          children: [
            CheckboxListTile(
              tristate: true,
              value: controller.tristate,
              controlAffinity: .leading,
              title: Text(label),
              onChanged: (value) {
                if (value == true) {
                  controller.selectAll();
                } else {
                  controller.clear();
                }
              },
            ),
            Padding(
              padding: const EdgeInsets.only(left: 12),
              child: Column(
                spacing: 4,
                children: WeekDay.values.map((day) {
                  return CheckboxListTile(
                    value: controller.isSelected(day),
                    controlAffinity: .leading,
                    title: Text(day.name),
                    onChanged: (value) {
                      if (value == true) {
                        controller.select(day);
                      } else {
                        controller.deselect(day);
                      }
                    },
                  );
                }).toList(),
              ),
            ),
          ],
        );
      },
    );
  }
}
