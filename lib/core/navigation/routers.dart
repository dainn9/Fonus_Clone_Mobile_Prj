import 'package:clone_fonus_app/features/onboarding/view/onboarding_srceen_one.dart';
import 'package:clone_fonus_app/features/onboarding/view/welcome_screen.dart';
import 'package:clone_fonus_app/features/signin_signup/view/sign_in_screen.dart';
import 'package:fluro/fluro.dart';
import 'package:clone_fonus_app/features/home/view/home_author.dart';
import 'package:clone_fonus_app/features/home/view/home_detail.dart';
import 'package:clone_fonus_app/features/home/view/home_listening.dart';
import 'package:clone_fonus_app/features/home/view/home_search.dart';
import 'package:clone_fonus_app/features/home/view/home_view.dart';
import '../../features/category/view/home_screen.dart';
import '../../features/onboarding/view/onboarding_screen.dart';
import '../design_systems/design_system_export.dart';

class FonosRouter {
  static final FluroRouter router = FluroRouter();

  static final Handler _welcomeHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
      return WelcomeScreen();
    },
  );

  static final Handler _onboardingHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
      return OnboardingScreen();
    },
  );

  static final Handler _onboardingoneHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
      return OnboardingScreenOne();
    },
  );

  static final Handler _signinHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
      return SignInScreen();
    },
  );

  static final Handler _homeCategory = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
      return HomeCategory();
    },
  );

  static final Handler _homeScreen = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
      return HomeScreen();
    },
  );

  static final Handler _homedetail = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
      return HomeDetail();
    },
  );

  static final Handler _homeauthor = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
      return HomeAuthor();
    },
  );

  static final Handler _homelistening = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
      return HomeListening();
    },
  );

  static final Handler _homesearch = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
      return HomeSearch();
    },
  );

  static void setupRouter() {
    router.define('/', handler: _welcomeHandler, transitionType: TransitionType.inFromRight);
    router.define('/onboarding', handler: _onboardingHandler, transitionType: TransitionType.inFromRight);
    router.define('/onboarding_step_one', handler: _onboardingoneHandler, transitionType: TransitionType.inFromRight);
    router.define('/sign_in', handler: _signinHandler, transitionType: TransitionType.inFromBottom);
    router.define('/home', handler: _homeCategory, transitionType: TransitionType.inFromRight);
    router.define('/homescreen', handler: _homeScreen, transitionType: TransitionType.inFromRight);
    router.define('/homedetail', handler: _homedetail, transitionType: TransitionType.inFromRight);
    router.define('/homeauthor', handler: _homeauthor, transitionType: TransitionType.inFromRight);
    router.define('/homelistening', handler: _homelistening, transitionType: TransitionType.inFromRight);
    router.define('/homesearch', handler: _homesearch, transitionType: TransitionType.inFromRight);
  }
}
