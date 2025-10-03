import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nawy_search/core/constants/colors.dart';

class EntryScreen extends StatefulWidget {
  final Widget child;

  const EntryScreen({super.key, required this.child});

  @override
  State<EntryScreen> createState() => _EntryScreenState();
}

class _EntryScreenState extends State<EntryScreen> {
  int _currentIndex = 0;

  final List<String> _tabs = ['/explore', '/updates', '/favorites', '/more'];
  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
    context.go(_tabs[index]);
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: Navigator.of(context).canPop(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: widget.child,
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            boxShadow: <BoxShadow>[
              BoxShadow(color: Colors.black12, blurRadius: 10, spreadRadius: 5),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(6)),

            child: BottomNavigationBar(
              elevation: 10,
              backgroundColor: whiteColor,
              type: BottomNavigationBarType.fixed,
              onTap: _onTabTapped,
              currentIndex: _currentIndex, // Always highlight "Explore" for now
              unselectedItemColor: lightTextColor,
              fixedColor: const Color(0xFFFF5E00),
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(Icons.search),
                  label: 'Explore',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.dashboard),
                  label: 'Updates',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.favorite_border),
                  label: 'Favorites',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.more_vert),
                  label: 'More',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
