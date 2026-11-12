import 'package:flutter/widgets.dart';
import 'package:routrack/common/common.dart';
import 'package:routrack/core/core.dart';

/// Box to shows [exception]
class AppExceptionBox extends StatelessWidget {
  /// Creates new [AppExceptionBox]
  const new({required this.exception, this.title, super.key});

  /// Title to be placed on top [exception]
  final String? title;

  /// [AppException] that will be showed
  final AppException exception;

  @override
  Widget build(BuildContext context) {
    // TODO(RDA12): maybe move it to its own extension?
    late final String message;
    switch (exception) {
      case UnexpectedException():
        message =
            'There is unexpected failure happened. '
            'We will take a look into that shortly. '
            'Please, try again later';
      case _:
        message = '';
    }
    return Column(
      spacing: 8,
      mainAxisAlignment: .center,
      children: [
        if (title != null)
          Text(
            title!,
            style: context.text.headlineSmall,
          ),
        Text(message),
      ],
    );
  }
}
