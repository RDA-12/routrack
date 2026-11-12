import 'package:flutter/widgets.dart';
import 'package:routrack/common/common.dart';

/// Shows a box to inform user that the data they requested is empty
/// or not found
class AppEmptyBox extends StatelessWidget {
  /// Creates new [AppEmptyBox]
  const new({
    this.title,
    this.content = 'Data is empty',
    super.key,
  });

  /// Title of the box. Place on top of [content]
  final String? title;

  /// Content of the box
  ///
  /// Default to 'Data is empty'
  final String content;

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 8,
      mainAxisAlignment: .center,
      children: [
        if (title != null)
          Text(
            title!,
            style: context.text.headlineSmall,
          ),
        Text(content),
      ],
    );
  }
}
