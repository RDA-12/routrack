import 'package:material_ui/material_ui.dart';
import 'package:routrack/common/common.dart';
import 'package:routrack/routine/domain/domain.dart';
import 'package:routrack/routine/presentation/widgets/weekday_selector.dart';

/// Signature of callback when new routine created
typedef OnRoutineSaved = void Function(CreateRoutineParams params);

/// Form to create new routine
class RoutineForm extends StatefulWidget {
  /// Creates new [RoutineForm]
  const new({required this.onRoutineSaved, super.key});

  /// Invoked when user pressed save button and all routine data are valid
  ///
  /// Will disable the save button when it is null
  final OnRoutineSaved? onRoutineSaved;

  @override
  State<RoutineForm> createState() => _RoutineFormState();
}

class _RoutineFormState extends State<RoutineForm> {
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final weekDayController = WeekDaySelectorController();
  final ValueNotifier<Set<WeekDay>> daysNotifier = ValueNotifier(<WeekDay>{});

  @override
  void dispose() {
    nameController.dispose();
    weekDayController.dispose();
    daysNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        spacing: 16,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                spacing: 8,
                children: [
                  TextFormField(
                    controller: nameController,
                    decoration: const InputDecoration(
                      labelText: 'Routine Name',
                      hintText: 'e.g. do 1 push up, drink at least 1.5 liters',
                      helperText: 'minimum 6 letters',
                    ),
                    textInputAction: .done,
                    maxLength: 32,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'routine name is required';
                      }
                      return null;
                    },
                  ),
                  WeekDaySelector(
                    controller: weekDayController,
                    label: 'Repeating days',
                  ),
                ],
              ),
            ),
          ),
          FilledButton(
            onPressed: widget.onRoutineSaved == null
                ? null
                : () {
                    if (!formKey.currentState!.validate()) return;

                    final name = nameController.text.trim();
                    widget.onRoutineSaved!(
                      CreateRoutineParams(
                        name: name,
                        days: weekDayController.selected,
                      ),
                    );
                  },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }
}
