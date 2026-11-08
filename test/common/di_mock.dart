import 'package:injectable/injectable.dart';
import 'package:routrack/common/common.dart';

import 'di_mock.config.dart';

/// Initialize mock dependencies
///
/// Call this once before run test. Typically run in setUpAll
///
/// Example:
/// ```dart
/// void main() {
///   setUpAll(() {
///     // other setup
///     inititalizeMockDependencies();
///   });
///
///   // test
/// }
/// ```
@InjectableInit(
  generateForDir: ['test'],
  generateForEnvironments: {Environment(Environment.test)},
  preferRelativeImports: true,
)
void initializeMockDependencies() => di.init(environment: Environment.test);
