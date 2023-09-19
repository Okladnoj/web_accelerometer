// In order to *not* need this ignore, consider extracting the "web" version
// of your plugin as a separate package, instead of inlining it in the same
// package as the core of your plugin.
// ignore: avoid_web_libraries_in_flutter
import 'dart:developer';
import 'dart:html' as html show window, Accelerometer, DeviceMotionEvent;
import 'dart:js_util';

import 'package:flutter/foundation.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';

import '../interface/accelerometer_platform_interface.dart';
import '../models/accelerometer_data.dart';

/// A web implementation of the WebAccelerometerPlatform of the WebAccelerometer plugin.
class WebAccelerometerWeb extends AccelerometerPlatform {
  /// Constructs a WebAccelerometerWeb
  WebAccelerometerWeb();

  static void registerWith(Registrar registrar) {
    AccelerometerPlatform.instance = WebAccelerometerWeb();
  }

  @override
  void motionEvents(ValueSetter<AccelerometerData> onMotion) {
    try {
      _genericSensorAPI(onMotion);
      _motionEvents(onMotion);
    } catch (e) {
      log('Accelerometer not supported: $e');
    }
  }

  void _genericSensorAPI(ValueSetter<AccelerometerData> onMotion) {
    final accelerometer = html.Accelerometer({'frequency': 60});

    accelerometer.addEventListener('reading', (event) {
      final data = AccelerometerData(
        x: (accelerometer.x ?? 0).toDouble(),
        y: (accelerometer.y ?? 0).toDouble(),
        z: (accelerometer.z ?? 0).toDouble(),
      );
      onMotion(data);
    });

    setProperty(
      accelerometer,
      'onreading',
      allowInterop(
        (_) {
          final data = AccelerometerData(
            x: (accelerometer.x ?? 0).toDouble(),
            y: (accelerometer.y ?? 0).toDouble(),
            z: (accelerometer.z ?? 0).toDouble(),
          );
          onMotion(data);
        },
      ),
    );

    accelerometer.start();
  }

  void _motionEvents(ValueSetter<AccelerometerData> onMotion) {
    html.window.addEventListener('devicemotion', (event) {
      final motionEvent = event as html.DeviceMotionEvent;

      final data = AccelerometerData(
        x: (motionEvent.acceleration?.x ?? 0).toDouble(),
        y: (motionEvent.acceleration?.y ?? 0).toDouble(),
        z: (motionEvent.acceleration?.z ?? 0).toDouble(),
      );

      onMotion(data);
    }, true);
  }
}
