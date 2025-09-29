import 'package:action_log_app/core/di/core_di.dart';
import 'package:action_log_app/core/di/features/location_di.dart';
import 'package:action_log_app/core/di/features/hazard_di.dart';
import 'package:action_log_app/core/di/features/hazard_type_di.dart';
import 'package:action_log_app/core/di/features/user_di.dart';
// import 'package:action_log_app/core/di/user_di.dart';
// import 'package:action_log_app/core/di/action_log_di.dart';

// Main DI coordinator - sets up all features
class DependencyInjection {
  static void setup() {
    CoreDI.setup();
     
    UserDI.setup();
    LocationDI.setup();
    HazardTypeDI.setup();
    HazardDI.setup();

  }

  static Type get hazard => HazardDI;
  static Type get hazardType => HazardTypeDI;
  static Type get core => CoreDI;
  static Type get location => LocationDI;
  static Type get user => UserDI;

}