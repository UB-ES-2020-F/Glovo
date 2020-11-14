import 'package:flutter_driver/flutter_driver.dart';

Future<bool> isPresent(SerializableFinder finder, FlutterDriver driver,
    {Duration timeout = const Duration(seconds: 1)}) async {
  Stopwatch s = new Stopwatch();
  s.start();
  await driver.waitFor(finder, timeout: timeout);
  s.stop();

  if (s.elapsedMilliseconds >= timeout.inMilliseconds) {
    return false;
  } else {
    return true;
  }
}
