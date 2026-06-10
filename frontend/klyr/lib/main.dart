import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:klyr/injection.dart';
import 'package:klyr/presentation/auth/bloc/authbloc.dart';
import 'package:klyr/presentation/expenses/group/group creation/bloc/group_bloc.dart';
import 'package:klyr/presentation/expenses/group/group%20view/bloc/group_view_bloc.dart';
import 'package:klyr/presentation/expenses/group/group%20managment/bloc/group_managment_bloc.dart';
import 'package:klyr/presentation/expenses/personal/bloc/expense_bloc.dart';
import 'package:klyr/presentation/home/bloc/home_bloc.dart';
import 'package:klyr/presentation/profile/bloc/profilebloc.dart';
import 'package:klyr/router/app_router.dart';
import 'package:klyr/theme/app_theme.dart';

void main() async {
  final injection = Injection();
  await injection.init();

  //bloc
  final Authbloc authbloc = Authbloc();

  //router
  final router = createRouter(authbloc);
  runApp(MainApp(injection: injection, authbloc: authbloc, router: router));
}

class MainApp extends StatelessWidget {
  final Injection injection;
  final Authbloc authbloc;
  final GoRouter router;
  const MainApp({
    super.key,
    required this.injection,
    required this.authbloc,
    required this.router,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: authbloc),
        BlocProvider(create: (_) => Profilebloc()),
        BlocProvider(
          create:
              (_) => ExpenseBloc(
                personalExpenseUsecase: injection.personalExpenseUsecase,
              ),
        ),
        BlocProvider(
          create: (_) => HomeBloc(homeUsecase: injection.homeUsecase),
        ),
        BlocProvider(
          create: (_) => GroupBloc(groupUsecase: injection.groupUsecase),
        ),
        BlocProvider(
          create: (_) => GroupViewBloc(groupUsecase: injection.groupUsecase),
        ),
        BlocProvider(
          create: (_) => GroupManagmentBloc(groupUsecase: injection.groupUsecase),
        ),
      ],
      child: MaterialApp.router(
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: ThemeMode.system,
        routerConfig: router,
      ),
    );
  }
}
