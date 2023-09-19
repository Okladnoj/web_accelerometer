import 'package:flutter/foundation.dart';

import 'interface/accelerometer_platform_interface.dart';
import 'models/accelerometer_data.dart';

class Accelerometer {
  void motionEvents(ValueSetter<AccelerometerData> onMotion) {
    return AccelerometerPlatform.instance.motionEvents(onMotion);
  }
}
