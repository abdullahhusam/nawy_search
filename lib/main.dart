import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:nawy_search/features/favorites/view_models/favorites_view_model.dart';

import 'core/constants/colors.dart';
import 'core/navigation/router.dart';
import 'core/services/connectivity_service.dart';
import 'features/entry/no_connection_screen.dart';
import 'features/explore/view_models/search_view_model.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(create: (_) => ConnectivityService()),
        ChangeNotifierProvider(create: (_) => FavoritesViewModel()),
        ChangeNotifierProxyProvider<FavoritesViewModel, SearchViewModel>(
          create: (context) {
            final fav = context.read<FavoritesViewModel>();
            final vm = SearchViewModel(fav);
            vm.loadInitialData();
            return vm;
          },
          update: (context, fav, prev) => prev!..loadInitialData(),
        ),
      ],
      child: Builder(
        builder: (context) {
          final connectivityService = context.read<ConnectivityService>();

          return StreamBuilder<bool>(
            stream: connectivityService.connectivityStream,
            initialData: true,
            builder: (context, snapshot) {
              final isConnected = snapshot.data ?? true;

              return MaterialApp.router(
                debugShowCheckedModeBanner: false,
                title: 'Property Search',
                theme: ThemeData(
                  colorScheme: ColorScheme.fromSeed(
                    seedColor: primaryColor,
                    brightness: Brightness.light,
                  ),
                  scaffoldBackgroundColor: screenBackgroundColor,
                ),
                routerConfig: isConnected
                    ? router
                    : // If offline, show no-connection screen
                      GoRouter(
                        routes: [
                          GoRoute(
                            path: '/',
                            builder: (context, state) =>
                                const NoConnectionScreen(),
                          ),
                        ],
                      ),
              );
            },
          );
        },
      ),
    );
  }
}
