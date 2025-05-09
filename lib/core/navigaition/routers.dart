import 'package:clone_fonus_app/features/onboarding/view/welcome_screen.dart';
import 'package:fluro/fluro.dart';
import '../../features/onboarding/view/onboarding_screen.dart';
import '../design_systems/design_system_export.dart';

class FonosRouter {
  static final FluroRouter router = FluroRouter();

  static final Handler _welcomeHandler = Handler(
      handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
        return WelcomeScreen();
      });

  static final Handler _onboardingHandler = Handler(
      handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
        return OnboardingScreen();
      });

  static void setupRouter() {
    router.define(
      '/',
      handler: _welcomeHandler,
      transitionType: TransitionType.inFromRight,
    );

    router.define(
      '/onboarding',
      handler: _onboardingHandler,
      transitionType: TransitionType.inFromRight,
    );
  }
}