import 'package:flutter/material.dart';
import 'package:nawy_search/features/favorites/view_models/favorites_view_model.dart';
import 'package:provider/provider.dart';

import 'core/constants/colors.dart';
import 'core/navigation/router.dart';
import 'features/explore/view_models/search_view_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //
  // final searchViewModel = SearchViewModel();
  // await searchViewModel.loadInitialData();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => FavoritesViewModel()),
        ChangeNotifierProxyProvider<FavoritesViewModel, SearchViewModel>(
          create: (context) {
            final fav = context.read<FavoritesViewModel>();
            final vm = SearchViewModel(fav);
            vm.loadInitialData(); // Load here
            return vm;
          },
          update: (context, fav, prev) => prev!..loadInitialData(),
        ),
      ],
      child: MaterialApp.router(
        // home: SearchScreen(),
        debugShowCheckedModeBanner: false,
        title: 'Property Search',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: primaryColor, // This drives many colors
            brightness: Brightness.light,
          ),
          // fontFamily: 'Poppins',
          scaffoldBackgroundColor: screenBackgroundColor,
        ),
        routerConfig: router,
      ),
    );
  }
}
