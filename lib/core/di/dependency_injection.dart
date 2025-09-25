import 'package:action_log_app/core/di/core_di.dart';
import 'package:action_log_app/core/di/features/location_di.dart';
import 'package:action_log_app/core/di/features/hazard_di.dart';
import 'package:action_log_app/core/di/features/hazard_type_di.dart';
// import 'package:action_log_app/core/di/user_di.dart';
// import 'package:action_log_app/core/di/action_log_di.dart';

// Main DI coordinator - sets up all features
class DependencyInjection {
  static void setup() {
    CoreDI.setup();
    
    // Setup feature-specific dependencies in order (avoiding circular dependencies)
    LocationDI.setup(); 
    
    // Initialize LocationDI's clear cache with LocationGroupDI's repository
    // LocationDI.initializeClearCache(LocationGroupDI.repository);
    
    HazardDI.setup();
    HazardTypeDI.setup();
    // UserDI.setup();
    // ActionLogDI.setup();
  }

  // Convenience getters - delegates to feature DI classes
  
  // Location Group feature access
  
  // Hazard feature access (includes response operations)
  static Type get hazard => HazardDI;
  
  // Hazard Type feature access
  static Type get hazardType => HazardTypeDI;
  
  // Core services access
  static Type get core => CoreDI;
  
  // TODO: Add other feature access as you create them
  // static get user => UserDI;
  // static get actionLog => ActionLogDI;
}