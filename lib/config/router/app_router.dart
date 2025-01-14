import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:teslo_shop/config/router/app_router_notifier.dart';
import 'package:teslo_shop/features/auth/auth.dart';
import 'package:teslo_shop/features/auth/presentation/providers/auth_provider.dart';
import 'package:teslo_shop/features/products/products.dart';

final goRouterProvider = Provider((ref) {
  final goRouterNotifier = ref.read(goRouterNotifierProvider);

  return GoRouter(
    initialLocation: '/login',
    refreshListenable: goRouterNotifier,
    routes: [
      //* Pantalla de carga
      GoRoute(
        path: '/check-status',
        builder: (context, state) => const CheckAuthStatusScreen(),
      ),

      //* Auth Routes
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginScreen(),
      ),

      GoRoute(
        path: '/register',
        builder: (context, state) => const RegisterScreen(),
      ),

      //* Product Routes
      GoRoute(
        path: '/',
        builder: (context, state) => const ProductsScreen(),
      ),

      GoRoute(
        path: '/product/:id',
        builder: (context, state) => ProductScreen(
          productId: state.params['id'] ?? 'no-id',
        ),
      ),
    ],
    redirect: (context, state) {
      final isGoingTo = state.subloc;
      final authStatus = goRouterNotifier.authStatus;

      print('TESLO APP');
      print('Mi estado es: $authStatus');
      print('Voy para la pantalla: $isGoingTo');
      print('');

      if (isGoingTo == '/check-status' && authStatus == AuthStatus.checking) {
        return null;
      }

      // return null es basicamente un 'deja pasar al usuario por esta ruta'

      if (authStatus == AuthStatus.unauthenticated) {
        if (isGoingTo == '/login' || isGoingTo == '/register') return null;

        return '/login';
      }

      if (authStatus == AuthStatus.authenticated) {
        if (isGoingTo == '/login' ||
            isGoingTo == '/register' ||
            isGoingTo == '/check-status') return '/';
      }

      //* Aqui puedo hacer rutas especiales para admins
      // if (user.isAdmin)

      return null;
    },
  );
});
