// import 'package:provider/provider.dart';
//
// import '../../../core/design_systems/design_system_export.dart';
//
// // class WelcomeProvider extends StatelessWidget {
// //   const WelcomeProvider({super.key});
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return ChangeNotifierProvider<WelcomeBloc>(
// //       create: (context) => WelcomeBloc(),
// //       child: WelcomePage(),
// //     );
// //   }
// // }
//
// class WelcomePage extends StatefulWidget {
//   const WelcomePage({super.key});
//
//   @override
//   State<StatefulWidget> createState() => _WelcomePageState();
// }
//
// class _WelcomePageState extends State<WelcomePage> {
//   @override
//   void initState() {
//     super.initState();
//
//     // Đặt hẹn giờ để chuyển trang sau 5 giây
//     Timer(Duration(seconds: 5), () {
//       // Đảm bảo widget vẫn được mounted trước khi chuyển trang
//       if (mounted) {
//         Navigator.pushReplacementNamed(context, '/onboarding');
//       }
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final welcomeBloc = Provider.of<WelcomeBloc>(context);
//     double screenWidth = MediaQuery.of(context).size.width;
//
//     return Scaffold(
//       backgroundColor: AppColors.purplePurple600, // Màu tím như trong hình
//       body: SafeArea(
//         child: Stack(
//           children: [
//             Align(
//               alignment: Alignment(-0.5, 0),
//               child: Image(
//                 image: AssetImage('assets/images/bazar_logo1.png'),
//                 width: screenWidth * 0.5,
//               ),
//             ),
//             Align(
//               alignment: Alignment(-1.5, 1),
//               child: Image(image: AssetImage('assets/images/vector.png')),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
