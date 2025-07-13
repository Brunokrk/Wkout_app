import 'package:wkout_core/injector/wkout_injector.dart';
import 'package:wkout_core/module/wkout_module.dart';

class AuthenticationModule extends WkoutModule<AuthenticationModule> {
  @override
  Future<void> registerInjection() async {
    //WkoutInjector.I.registerSingleton<AuthHomeViewModel>(AuthHomeViewModel());
  }

  @override
  Future<void> unregisterInjections() async {
    //WkoutInjector.I.unregister<AuthHomeViewModel>();
  }

  @override
  Future<void> unload() async {}
}