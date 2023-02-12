import 'dart:developer' as devtools show log;

extension LogX on Object {
  void log([String? message]) {
    devtools.log(message ?? toString());
  }
}
