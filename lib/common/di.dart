import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:routrack/common/di.config.dart';

/// Global dependency injector instance to get a service
final GetIt di = GetIt.instance;

/// Initialize dependencies
///
/// Call this once before runApp method
///
/// Example:
/// ```dart
/// void main() {
///   initializeDependencies();
///   runApp(RoutrackApp());
/// }
/// ```
@InjectableInit(
  generateForEnvironments: {Environment(Environment.prod)},
)
void initializeDependencies() => di.init(environment: Environment.prod);
