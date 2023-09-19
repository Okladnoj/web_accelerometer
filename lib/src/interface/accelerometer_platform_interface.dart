import 'package:flutter/foundation.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import '../mobile/accelerometer_method_channel.dart';
import '../models/accelerometer_data.dart';

abstract class AccelerometerPlatform extends PlatformInterface {
  /// Constructs a WebAccelerometerPlatform.
  AccelerometerPlatform() : super(token: _token);

  static final Object _token = Object();

  static AccelerometerPlatform _instance = MethodChannelWebAccelerometer();

  /// The default instance of [AccelerometerPlatform] to use.
  ///
  /// Defaults to [MethodChannelWebAccelerometer].
  static AccelerometerPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [AccelerometerPlatform] when
  /// they register themselves.
  static set instance(AccelerometerPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  void motionEvents(ValueSetter<AccelerometerData> onMotion);
}
