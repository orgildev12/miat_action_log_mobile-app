import 'package:action_log_app/core/di/core_di.dart';
import 'package:action_log_app/core/di/features/location_group_di.dart';
// import 'package:action_log_app/core/di/user_di.dart';
// import 'package:action_log_app/core/di/action_log_di.dart';

// Main DI coordinator - sets up all features
class DependencyInjection {
  static void setup() {
    CoreDI.setup();
    
    // Setup feature-specific dependencies
    LocationGroupDI.setup();
    // UserDI.setup();
    // ActionLogDI.setup();
  }

  // Convenience getters - delegates to feature DI classes
  
  // Location Group feature access
  static get locationGroup => LocationGroupDI;
  
  // Core services access
  static get core => CoreDI;
  
  // TODO: Add other feature access as you create them
  // static get user => UserDI;
  // static get actionLog => ActionLogDI;
}