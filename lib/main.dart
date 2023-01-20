import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:textbook_library/models/book.dart';
import 'package:textbook_library/view/book_preview_view.dart';
import 'package:textbook_library/view/browse_view.dart';
import 'package:textbook_library/view/search_view.dart';

void main() {
  runApp(const MainWindow());
}

final GoRouter _router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const MainWidget(),
    ),
    GoRoute(
        path: '/preview/:grade/:id',
        builder: (context, state) {
          return BookPreviewScreen(book: state.extra as Book?);
        }),
    GoRoute(
        path: '/search',
        builder: (context, state) {
          return const SearchScreen();
        }),
  ],
);

class MainWindow extends StatelessWidget {
  const MainWindow({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.orange));

    return ProviderScope(
      child: MaterialApp.router(
        routerConfig: _router,
        title: 'Textbook Library',
        theme: ThemeData(
          primarySwatch: Colors.orange,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          appBarTheme: const AppBarTheme(
            foregroundColor: Colors.white,
          ),
          fontFamily: GoogleFonts.inter().fontFamily,
        ),
      ),
    );
  }
}

class MainWidget extends StatefulWidget {
  const MainWidget({super.key});

  @override
  State<MainWidget> createState() => _MainWidgetState();
}

class _MainWidgetState extends State<MainWidget> {
  int _pageIndex = 0;
  PageController _pageController = PageController();

  String url =
      "https://www.googleapis.com/books/v1/volumes?q=isbn:9780133594140";

  List<Widget> widgets = [
    const BrowseScreen(),
    const Text('Page 2'),
  ];

  void onItemTapped(int index) {
    setState(() {
      _pageIndex = index;
    });

    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  Future<String> getData() async {
    String url =
        "https://www.googleapis.com/books/v1/volumes?q=isbn:9780133594140";
    http.Response response = await http.get(Uri.parse(url));
    return response.body;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox.expand(
        child: PageView(
          physics: const NeverScrollableScrollPhysics(),
          controller: _pageController,
          onPageChanged: (index) {
            setState(() => _pageIndex = index);
          },
          children: widgets,
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Browse',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bookmarks),
            label: 'Downloads',
          ),
        ],
        currentIndex: _pageIndex,
        selectedItemColor: Colors.amber[800],
        onTap: onItemTapped,
      ),
    );
  }
}
