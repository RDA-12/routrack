import 'package:flutter/widgets.dart';
import 'package:routrack/common/common.dart';
import 'package:routrack/core/core.dart';

/// Adds default message content for user
extension MessageX on AppException {
  /// Returns user message for this [AppException]
  String getUserMessage() {
    switch (this) {
      case UnexpectedException():
        return 'There is unexpected failure happened. '
            'We will take a look into that shortly. '
            'Please, try again later';
      case NotFoundException(:final entity):
        return 'Data for $entity is not found';
    }
  }
}

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
    final message = exception.getUserMessage();
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
