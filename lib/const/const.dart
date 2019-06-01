class Const {
  static const bool isDebug = !const bool.fromEnvironment("dart.vm.product");
}
