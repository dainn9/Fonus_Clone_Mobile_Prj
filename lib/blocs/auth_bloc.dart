// abstract class AuthEvent {}
//
// class CheckLoginStatusEvent extends AuthEvent {}
//
// class AuthState {
//   final bool isLoggedIn;
//
//   AuthState({required this.isLoggedIn});
// }
//
// class AuthBloc extends Bloc<AuthEvent, AuthState> {
//   AuthBloc() : super(AuthState(isLoggedIn: false));
//
//   @override
//   Stream<AuthState> mapEventToState(AuthEvent event) async* {
//     if (event is CheckLoginStatusEvent) {
//       // Kiểm tra đăng nhập (ví dụ từ SharedPreferences hoặc API)
//       final bool loggedIn = await _checkLoginStatus();
//       yield AuthState(isLoggedIn: loggedIn);
//     }
//   }
//
//   // Giả sử phương thức này kiểm tra người dùng đã đăng nhập hay chưa
//   Future<bool> _checkLoginStatus() async {
//     // Lấy thông tin đăng nhập từ SharedPreferences hoặc API
//     return true; // Trả về trạng thái đã đăng nhập (dùng giả lập)
//   }
// }