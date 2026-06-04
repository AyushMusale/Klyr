import 'package:go_router/go_router.dart';
import 'package:klyr/data/localdb/authdb.dart';
import 'package:klyr/presentation/auth/authpage.dart';
import 'package:klyr/presentation/auth/bloc/authbloc.dart';
import 'package:klyr/presentation/auth/otppage.dart';
import 'package:klyr/presentation/expenses/group/group creation/groupcreationpage.dart';
import 'package:klyr/presentation/expenses/navigation/expense_navigation_page.dart';
import 'package:klyr/presentation/expenses/personal/pages/createpersexppage.dart';
import 'package:klyr/presentation/expenses/personal/pages/listpersonalexppage.dart';
import 'package:klyr/presentation/expenses/personal/pages/showpersonalexppage.dart';
import 'package:klyr/presentation/home/pages/homepage.dart';
import 'package:klyr/presentation/navigation/navigation_page.dart';
import 'package:klyr/presentation/profile/profilepage.dart';
import 'package:flutter/material.dart';
import 'package:klyr/router/streamsubscription.dart';

class TabConfig {
  final String path;
  final IconData icon;
  final String label;

  const TabConfig({
    required this.path,
    required this.icon,
    required this.label,
  });
}

const tabs = [
  TabConfig(path: '/home', icon: Icons.home_rounded, label: 'Home'),
  TabConfig(path: '/expenses', icon: Icons.wallet_rounded, label: 'Expense'),
  TabConfig(
    path: '/summary',
    icon: Icons.pie_chart_outline_rounded,
    label: 'Summary',
  ),
];

GoRouter createRouter(Authbloc authbloc) => GoRouter(
  refreshListenable: GoRouterRefreshStream(authbloc.stream),
  initialLocation: "/auth",
  redirect: (context, state) async {
    final accessToken = await TokenStorage.getAccessToken();
    final refreshToken = await TokenStorage.getRefreshToken();
    final isLoggedIn = accessToken != null || refreshToken != null;
    final onAuthRoute = state.matchedLocation.startsWith('/auth');

    if (!isLoggedIn) {
      return onAuthRoute ? null : '/auth';
    }

    if (onAuthRoute) {
      return '/home';
    }

    return null;
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

    ShellRoute(
      builder: (context, state, child) {
        final location = state.matchedLocation;
        final index = tabs.indexWhere((t) => location.startsWith(t.path));
        return NavigationPage(
          selectedIndex: index < 0 ? 0 : index,
          child: child,
        );
      },
      routes: [
        GoRoute(
          path: '/home',
          name: 'homepage',
          builder: (context, state) => const Homepage(),
        ),

        // GoRoute(path: '/groups', builder: (_, __) => const GroupsPage()),
        // GoRoute(path: '/summary', builder: (_, __) => const SummaryPage()),
        GoRoute(
          path: '/expenses',
          name: "expensenavigationpage",
          builder: (context, state) => const ExpenseNavigationPage(),
        ),
      ],
    ),
    GoRoute(
      path: '/profile',
      name: 'profilepage',
      builder: (context, state) => const Profilepage(),
    ),
    GoRoute(
      path: '/createpersonalexpense',
      name: 'createpersonalexpensepage',
      builder: (context, state) => const CreatepersonalExpensepage(),
    ),
    GoRoute(
      path: '/showpersonalexpense/:id',
      name: "showpersonalexpense",
      builder:
          (context, state) =>
              ShowPersonalExpPage(id: int.parse(state.pathParameters['id']!)),
    ),
    GoRoute(
      path: '/personalexpenses',
      name: "personalexepensepage",
      builder: (context, state) => ShowAllPersonalexppage(),
    ),
    GoRoute(
      path: '/creategroup',
      name: 'creategrouppage',
      builder: (context, state) => const GroupCreationPage(),
    ),
  ],
);
