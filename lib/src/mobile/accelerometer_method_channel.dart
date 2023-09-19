import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import '../interface/accelerometer_platform_interface.dart';
import '../models/accelerometer_data.dart';

/// An implementation of [AccelerometerPlatform] that uses method channels.
class MethodChannelWebAccelerometer extends AccelerometerPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('web_accelerometer');

  @override
  void motionEvents(ValueSetter<AccelerometerData> onMotion) {
    throw UnimplementedError('motionEvents has not been implemented.');
  }
}
