import 'package:clone_fonus_app/core/navigation/routers.dart';

import '../core/design_systems/design_system_export.dart';
import 'app.dart';

void run() async {
  // Đảm bảo các binding của Flutter được khởi tạo
  WidgetsFlutterBinding.ensureInitialized();

  // Khởi tạo các dịch vụ toàn cục
  // await ApiService.init(); // Ví dụ: Khởi tạo API service
  // Logger.init(); // Khởi tạo logger

  // In thông báo khởi động
  // Logger.log('Application is starting...');

  //initial router
  // Khởi chạy ứng dụng
  FonosRouter.setupRouter();
  runApp( App());
}