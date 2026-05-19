import 'package:go_router/go_router.dart';
import 'package:klyr/data/localdb/authdb.dart';
import 'package:klyr/presentation/auth/authpage.dart';
import 'package:klyr/presentation/auth/otppage.dart';
import 'package:klyr/presentation/home/homepage.dart';
import 'package:klyr/presentation/profile/profilepage.dart';

final router = GoRouter(
  initialLocation: "/auth",
  redirect: (context, state) async {
    final accessToken = await TokenStorage.getAccessToken();
    final refreshToken = await TokenStorage.getRefreshToken();
    if (accessToken == "null" && refreshToken == "null") {
      return '/auth';
    } else {
      return '/profile';
    }
  },
  routes: [
    GoRoute(
      path: '/auth',
      name: "authpage",
      builder: (context, state) => const Authpage(),
      routes: [
        GoRoute(
          path: 'otp',
          name: "otppage",
          builder: (context, state) {
            final email = state.extra as String? ?? "";
            return OtpPage(email: email);
          },
        ),
      ],
    ),
    GoRoute(
      path: '/profile',
      name: 'profilepage',
      builder: (context, state) => const Profilepage(),
    ),
    GoRoute(
      path: '/home',
      name: 'homepage',
      builder: (context, state) => const Homepage(),
    ),
  ],
);
