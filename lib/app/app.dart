import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../core/design_systems/design_system_export.dart';
import '../core/navigaiton/routers.dart';
import '../core/utils/app_constans.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      // Sử dụng một kích thước cố định cho designSize - thường dựa theo thiết kế Figma/XD
      designSize: const Size(375, 812), // hoặc kích thước thiết kế của bạn
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: Appconstants.APP_TITLE,
          theme: BMaterialTheme.light(),
          themeMode: ThemeMode.light,
          onGenerateRoute: FonosRouter.router.generator,
          initialRoute: '/',
        );
      },
    );
  }
}