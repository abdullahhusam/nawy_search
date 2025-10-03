import 'package:go_router/go_router.dart';
import 'package:nawy_search/features/favorites/views/favorites_screen.dart';

import '../../features/entry/entry_screen.dart';
import '../../features/entry/placeholder_screen.dart';
import '../../features/explore/views/results_screen.dart';
import '../../features/explore/views/search_screen.dart';

final GoRouter router = GoRouter(
  initialLocation: '/explore',
  routes: [
    ShellRoute(
      builder: (context, state, child) {
        return EntryScreen(child: child); // has bottom nav
      },
      routes: [
        GoRoute(
          path: '/explore',
          pageBuilder: (context, state) =>
              const NoTransitionPage(child: SearchScreen()),
          routes: [
            GoRoute(
              path: 'results',
              builder: (context, state) => const ResultsScreen(),
            ),
          ],
        ),
        GoRoute(
          path: '/favorites',
          pageBuilder: (context, state) =>
              const NoTransitionPage(child: FavoritesScreen()),
        ),
        GoRoute(
          path: '/updates',
          pageBuilder: (context, state) => const NoTransitionPage(
            child: PlaceholderScreen(title: 'Updates'),
          ),
        ),
        GoRoute(
          path: '/more',
          pageBuilder: (context, state) =>
              const NoTransitionPage(child: PlaceholderScreen(title: 'More')),
        ),
      ],
    ),
  ],
);
