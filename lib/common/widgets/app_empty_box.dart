import 'package:flutter/widgets.dart';
import 'package:routrack/common/common.dart';

/// Shows a box to inform user that the data they requested is empty
/// or not found
class AppEmptyBox extends StatelessWidget {
  /// Creates new [AppEmptyBox]
  const new({
    this.title,
    this.content = 'Data is empty',
    this.action,
    super.key,
  });

  /// Title of the box. Place on top of [content]
  final String? title;

  /// Content of the box
  ///
  /// Default to 'Data is empty'
  final String content;

  /// Action that can be taken by user, typically a Button or list of Button'
  ///
  /// It will be placed at the bottom of [content]
  final Widget? action;

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 16,
      mainAxisAlignment: .center,
      children: [
        Column(
          spacing: 8,
          mainAxisAlignment: .center,
          children: [
            if (title != null)
              Text(
                title!,
                textAlign: .center,
                style: context.text.headlineSmall,
              ),
            Text(
              content,
              textAlign: .center,
            ),
          ],
        ),
        ?action,
      ],
    );
  }
}
