import 'package:equatable/equatable.dart';
import 'package:material_ui/material_ui.dart';
import 'package:routrack/common/common.dart';

/// States of [LoadingOverlay]
enum LoadingOverlayState {
  /// Loading overlay not showed
  idle,

  /// Loading overlay shows LoadingIndicator
  loading,

  /// Loading overlay shows result
  ///
  /// It can only go to this state when previous state is loading
  result,
}

/// Holds result data that will be used overlay builder
final class LoadingOverlayResult extends Equatable {
  /// Creates new [LoadingOverlayResult]
  const new({
    required this.title,
    required this.content,
  });

  /// Title of the result
  final String? title;

  /// Content of the result
  final String content;

  @override
  List<Object?> get props => [title, content];
}

/// Controller for [LoadingOverlay]
final class LoadingOverlayController extends ChangeNotifier {
  /// Creates new [LoadingOverlayController]
  new() : _state = .idle;

  LoadingOverlayState _state;

  /// Returns current overlay state
  LoadingOverlayState get state => _state;

  /// Show loading overlay
  void show() {
    if (_state == .loading) return;
    _state = .loading;
    notifyListeners();
  }

  LoadingOverlayResult? _result;

  /// Returns current result
  LoadingOverlayResult? get result => _result;

  /// Transition the overlay to result
  ///
  /// It does nothing when current overlay state is not .loading. Use [show]
  /// method to
  void transitionToResult(LoadingOverlayResult result) {
    if (_state != .loading) return;
    _state = .result;
    _result = result;
    notifyListeners();
  }

  /// Close the overlay
  ///
  /// Set the state to idle
  void close() {
    if (_state == .idle) return;
    _state = .idle;
    notifyListeners();
  }
}

/// Wrapper to shows loading overlay
class LoadingOverlay extends StatelessWidget {
  /// Creates new [LoadingOverlay]
  const new({
    required this.controller,
    required this.builder,
    super.key,
  });

  /// Controls the [LoadingOverlay]
  final LoadingOverlayController controller;

  /// Builder to build widget that will be placed at the bottom of
  /// the overlay
  final Widget Function(BuildContext context) builder;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: ListenableBuilder(
        listenable: controller,
        builder: (context, child) {
          return Stack(
            children: [
              builder(context),
              if (controller.state != .idle)
                _PositionedOverlayWrapper(
                  overlay: switch (controller.state) {
                    .loading => const LoadingIndicator(),
                    .result => LoadingOverlayResultWidget(
                      result: controller.result!,
                      onClosePressed: controller.close,
                    ),
                    .idle => const SizedBox.shrink(),
                  },
                ),
            ],
          );
        },
      ),
    );
  }
}

class _PositionedOverlayWrapper extends StatelessWidget {
  const new({required this.overlay});

  final Widget overlay;

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Stack(
        alignment: .center,
        children: [
          Container(
            constraints: const BoxConstraints.expand(),
            color: context.color.scrim.withValues(alpha: .5),
          ),
          AnimatedSize(
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeOut,
            child: Container(
              constraints: const BoxConstraints(minWidth: 280, maxWidth: 560),
              padding: const EdgeInsets.all(24),
              margin: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: context.color.surfaceContainer,
                borderRadius: BorderRadius.circular(16),
              ),
              child: overlay,
            ),
          ),
        ],
      ),
    );
  }
}

/// Default [Widget] to shows [LoadingOverlayResult]
class LoadingOverlayResultWidget extends StatelessWidget {
  /// Creates new [LoadingOverlayResultWidget]
  const new({
    required this.result,
    required this.onClosePressed,
    super.key,
  });

  /// [LoadingOverlayResult] that will be showed
  final LoadingOverlayResult result;

  /// Invoked when user press close button
  final VoidCallback onClosePressed;

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 24,
      crossAxisAlignment: .end,
      mainAxisSize: .min,
      children: [
        Column(
          spacing: 16,
          crossAxisAlignment: .start,
          mainAxisSize: .min,
          children: [
            if (result.title != null)
              Text(
                result.title!,
                style: context.text.headlineSmall,
              ),
            Text(result.content),
          ],
        ),
        TextButton(
          onPressed: onClosePressed,
          child: const Text('Close'),
        ),
      ],
    );
  }
}
