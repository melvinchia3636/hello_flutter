import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sliver_header_delegate/sliver_header_delegate.dart';
import 'package:textbook_library/components/browse_screen/book_card.dart';
import 'package:textbook_library/components/browse_screen/placeholder.dart';
import 'package:textbook_library/providers/books_provider.dart';

class BrowseScreen extends ConsumerStatefulWidget {
  const BrowseScreen({super.key});

  @override
  ConsumerState<BrowseScreen> createState() => _BrowseWidgetState();
}

class DrawerItem {
  const DrawerItem(
      {required this.textEN, required this.textCH, required this.id});

  final String id;
  final String textEN;
  final String textCH;
}

class _BrowseWidgetState extends ConsumerState<BrowseScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  late final _scrollController;

  final drawerItems = [
    const DrawerItem(id: "jm1", textEN: "Junior 1", textCH: "初一"),
    const DrawerItem(id: "jm2", textEN: "Junior 2", textCH: "初二"),
    const DrawerItem(id: "jm3", textEN: "Junior 3", textCH: "初三"),
    const DrawerItem(id: "sm1", textEN: "Senior 1", textCH: "高一"),
    const DrawerItem(id: "sm2", textEN: "Senior 2", textCH: "高二"),
    const DrawerItem(id: "sm3", textEN: "Senior 3", textCH: "高三"),
  ];

  void _onSelectedGrade(String grade) {
    ref.read(selectedGradeProvider.notifier).state = grade;
    Navigator.of(context).pop();
  }

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final selectedGrade = ref.watch(selectedGradeProvider);
    final books = ref.watch(booksProvider);
    final textStyle = Theme.of(context).textTheme;

    ref.listen(selectedGradeProvider, (_, __) {
      _scrollController.animateTo(
        0.0,
        duration: const Duration(seconds: 1),
        curve: Curves.fastOutSlowIn,
      );
    });

    final drawerOptions = drawerItems.map((d) {
      return ListTile(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(6)),
        ),
        title: Text("${d.textEN}   ${d.textCH}",
            style: const TextStyle(fontSize: 16)),
        selected: selectedGrade == d.id,
        onTap: () => _onSelectedGrade(d.id),
        selectedColor: Colors.orange,
        selectedTileColor: Colors.orange[100],
      );
    }).toList();

    return Scaffold(
      key: _scaffoldKey,
      drawer: Drawer(
        child: Column(
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text(
                drawerItems
                    .firstWhere((element) => element.id == selectedGrade)
                    .textEN,
                style: const TextStyle(
                  fontSize: 26.0,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
              accountEmail: Text(
                drawerItems
                    .firstWhere((element) => element.id == selectedGrade)
                    .textCH,
                style: const TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
            Padding(
                padding: const EdgeInsets.all(12),
                child: Column(children: drawerOptions))
          ],
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () {
          ref.invalidate(booksProvider);
          return ref.read(booksProvider.future);
        },
        child: CustomScrollView(
          controller: _scrollController,
          slivers: <Widget>[
            SliverPersistentHeader(
              pinned: true,
              delegate: FlexibleHeaderDelegate(
                statusBarHeight: MediaQuery.of(context).padding.top,
                expandedHeight: 240,
                background: MutableBackground(
                  expandedWidget: Image.asset(
                    'assets/lib.jpg',
                    fit: BoxFit.cover,
                    colorBlendMode: BlendMode.darken,
                    color: Colors.black.withOpacity(0.3),
                  ),
                  collapsedColor: Colors.orange,
                ),
                leading: IconButton(
                  onPressed: () {
                    _scaffoldKey.currentState!.openDrawer();
                  },
                  icon: const Icon(Icons.menu),
                ),
                actions: [
                  IconButton(
                    icon: const Icon(Icons.search),
                    onPressed: () {
                      context.push('/search');
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.more_vert),
                    onPressed: () {},
                  ),
                ],
                children: [
                  FlexibleTextItem(
                    text:
                        '${drawerItems.firstWhere((element) => element.id == selectedGrade).textEN} ${drawerItems.firstWhere((element) => element.id == selectedGrade).textCH}',
                    collapsedStyle: textStyle.headline6?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                    expandedStyle: textStyle.headline4?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                    expandedAlignment: Alignment.bottomLeft,
                    collapsedAlignment: Alignment.center,
                    expandedPadding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 16),
                  ),
                ],
              ),
            ),
            books.when(
              data: (data) {
                final books = data?.items ?? [];

                return SliverPadding(
                  padding: const EdgeInsets.all(24),
                  sliver: SliverAnimatedList(
                    initialItemCount: books.length,
                    itemBuilder: (context, index, animation) {
                      return SizeTransition(
                        sizeFactor: animation,
                        child: BookCard(book: books[index]),
                      );
                    },
                  ),
                );
              },
              loading: () => SliverPadding(
                padding: const EdgeInsets.all(24),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) => MyLovelyPlaceholder(),
                    childCount: 5,
                  ),
                ),
              ),
              error: (e, s) => const SliverFillRemaining(
                child: Center(
                  child: Text('Error'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
