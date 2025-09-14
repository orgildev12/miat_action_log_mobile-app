import 'package:action_log_app/core/di/core_di.dart';
import 'package:action_log_app/core/di/features/location_group_di.dart';

class DependencyInjection {
  static void setup() {
    CoreDI.setup();
    
    LocationGroupDI.setup();
    LocationDI.setup();
    HazardTypeDI.setup();
    HazardDI.setup();
  }

  // Convenience getters - delegates to feature DI classes
  
  // Location Group feature access
  static get locationGroup => LocationGroupDI;
  static get location => LocationDI;
  static get hazardType => HazardTypeDI;
  static get hazard => HazardDI;
  
  // Core services access
  static get core => CoreDI;
  
  // TODO: Add other feature access as you create them
  // static get user => UserDI;
  // static get actionLog => ActionLogDI;
}