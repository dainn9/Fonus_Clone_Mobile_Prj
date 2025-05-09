import 'package:clone_fonus_app/features/category/view/home_screen.dart';
import 'package:fluro/fluro.dart';
import '../design_systems/design_system_export.dart';

class FonosRouter {
  static final FluroRouter router = FluroRouter();

  // đây là home của trang category
static final Handler _homeCategory = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
      return HomeScreen(); // Đảm bảo sử dụng SignUpProvider
    });


static void setupRouter() {
  router.define(
    '/',
    handler: _homeCategory,
    transitionType: TransitionType.inFromRight,
  );

}
}