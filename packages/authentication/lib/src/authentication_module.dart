import 'package:wkout_core/module/wkout_module.dart';

class AuthenticationModule extends WkoutModule<AuthenticationModule> {
  @override
  Future<void> registerInjection() async {
    WkoutInjector.registerSingleton<AuthHomeViewModel>(AuthHomeViewModel());
  }
}