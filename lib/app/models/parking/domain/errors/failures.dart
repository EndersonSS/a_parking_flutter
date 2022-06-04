
import 'package:a_parking_flutter/app/core/core.dart';

abstract class ParkingFailure extends Failure {
  ParkingFailure({
    required String message,
    StackTrace? stackTrace,
    String? label,
  }) : super(
          message: message,
          stackTrace: stackTrace,
          label: label,
        );
}

class ParkingDatasourceFailure extends ParkingFailure {
  ParkingDatasourceFailure({
    required String message,
    StackTrace? stackTrace,
    String? label,
  }) : super(
          message: message,
          stackTrace: stackTrace,
          label: label,
        );
}

class ParkingParseFailure extends ParkingFailure {
  ParkingParseFailure({
    required String message,
    StackTrace? stackTrace,
    String? label,
  }) : super(
          message: message,
          stackTrace: stackTrace,
          label: label,
        );
}
 

class ParkingUnknownFailure extends ParkingFailure {
  ParkingUnknownFailure({
    required String message,
    StackTrace? stackTrace,
    String? label,
  }) : super(
          message: message,
          stackTrace: stackTrace,
          label: label,
        );
}

class FailureParamEmpty extends ParkingFailure {
  FailureParamEmpty({
    required String message,
    StackTrace? stackTrace,
    String? label,
  }) : super(
          message: message,
          stackTrace: stackTrace,
          label: label,
        );
}
