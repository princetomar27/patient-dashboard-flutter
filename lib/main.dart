import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'core/injection.dart';
import 'features/auth/presentation/pages/login_page.dart';
import 'features/auth/presentation/cubit/auth_cubit.dart';

void main() {
  setupLocator();
  runApp(
    MultiBlocProvider(
      providers: [BlocProvider(create: (_) => sl<AuthCubit>())],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final GoRouter _router = GoRouter(
      initialLocation: '/login',
      routes: [
        GoRoute(path: '/login', builder: (context, state) => const LoginPage()),
        ShellRoute(
          builder: (context, state, child) {
            return Scaffold(
              body: child,
              bottomNavigationBar: BottomNavigationBar(
                currentIndex: _calculateSelectedIndex(state.uri.toString()),
                onTap: (index) {
                  switch (index) {
                    case 0:
                      context.go('/dashboard');
                      break;
                    case 1:
                      context.go('/history');
                      break;
                    case 2:
                      context.go('/settings');
                      break;
                  }
                },
                items: const [
                  BottomNavigationBarItem(
                    icon: Icon(Icons.dashboard),
                    label: 'Dashboard',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.history),
                    label: 'History',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.settings),
                    label: 'Settings',
                  ),
                ],
              ),
            );
          },
          routes: [
            GoRoute(
              path: '/dashboard',
              builder:
                  (context, state) =>
                      const Scaffold(body: Center(child: Text('Dashboard'))),
            ),
            GoRoute(
              path: '/history',
              builder:
                  (context, state) =>
                      const Scaffold(body: Center(child: Text('History'))),
            ),
            GoRoute(
              path: '/settings',
              builder:
                  (context, state) =>
                      const Scaffold(body: Center(child: Text('Settings'))),
            ),
          ],
        ),
      ],
      redirect: (context, state) {
        final authCubit = context.read<AuthCubit>();
        final isLoggedIn =
            authCubit.state is AuthLoaded &&
            (authCubit.state as AuthLoaded).user != null;
        final loggingIn = state.uri.toString() == '/login';
        if (!isLoggedIn && !loggingIn) return '/login';
        if (isLoggedIn && loggingIn) return '/dashboard';
        return null;
      },
    );
    return MaterialApp.router(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      routerConfig: _router,
    );
  }
}

int _calculateSelectedIndex(String location) {
  if (location.startsWith('/dashboard')) {
    return 0;
  }
  if (location.startsWith('/history')) {
    return 1;
  }
  if (location.startsWith('/settings')) {
    return 2;
  }
  return 0;
}
