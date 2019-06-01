import 'package:flutter/foundation.dart';
import 'package:stack_trace/stack_trace.dart';

class Logger {
  static void debug([String log = '(invoke)']) {
    var mem = Trace.current().frames[1].member;
    debugPrint('[ME] $mem -> $log');
  }
}
