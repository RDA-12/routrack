import 'package:material_ui/material_ui.dart';

/// Shows loading spinner spinning indefinetely
class LoadingIndicator extends StatelessWidget {
  /// Creates new [LoadingIndicator]
  const new({this.size = 32, super.key});

  /// Size of the spinner
  final double size;

  @override
  Widget build(BuildContext context) {
    return SizedBox.square(
      dimension: size,
      child: const CircularProgressIndicator(),
    );
  }
}
