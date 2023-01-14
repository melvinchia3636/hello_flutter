import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hello_flutter/models/g_book.dart';
import 'package:hello_flutter/models/g_books.dart';
import 'package:http/http.dart' as http;
import 'package:sliver_header_delegate/sliver_header_delegate.dart';

Future<GBooks>? fetch() async {
  const String url =
      'https://www.googleapis.com/books/v1/volumes?q=for+dummies';
  final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    return GBooks.fromJson(json.decode(response.body));
  } else {
    throw Exception('Failed to load post');
  }
}

class BrowseWidget extends StatefulWidget {
  const BrowseWidget({super.key});

  @override
  State<BrowseWidget> createState() => _BrowseWidgetState();
}

class _BrowseWidgetState extends State<BrowseWidget> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: Drawer(
        child: ListView(
          // Important: Remove any padding from the ListView.
          children: [
            ListTile(
              title: const Text('Item 1'),
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),
            ListTile(
              title: const Text('Item 2'),
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),
          ],
        ),
      ),
      body: CustomScrollView(
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
                collapsedColor: Colors.amber,
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
                  onPressed: () {},
                ),
                IconButton(
                  icon: const Icon(Icons.more_vert),
                  onPressed: () {},
                ),
              ],
              children: [
                FlexibleTextItem(
                  text: 'Browse Textbooks',
                  collapsedStyle: Theme.of(context)
                      .textTheme
                      .headline6
                      ?.copyWith(
                          color: Colors.white, fontWeight: FontWeight.w500),
                  expandedStyle: Theme.of(context)
                      .textTheme
                      .headline4
                      ?.copyWith(
                          color: Colors.white, fontWeight: FontWeight.w500),
                  expandedAlignment: Alignment.bottomLeft,
                  collapsedAlignment: Alignment.center,
                  expandedPadding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                ),
              ],
            ),
          ),
          FutureBuilder<GBooks>(
              future: fetch(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final List<GBook> books = snapshot.data!.items;
                  return SliverPadding(
                    padding: const EdgeInsets.all(24),
                    sliver: SliverGrid(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          final book = books.elementAt(index);
                          return Card(
                            elevation: 2,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                top: 24,
                                left: 12,
                                right: 12,
                                bottom: 12,
                              ),
                              child: Column(
                                children: [
                                  Expanded(
                                    child: Image.network(
                                      book.volumeInfo.imageLinks!
                                          .smallThumbnail,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 12),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Flexible(
                                          child: Text(book.volumeInfo.title,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .subtitle1),
                                        ),
                                        const SizedBox(
                                          width: 8,
                                        ),
                                        IconButton(
                                          padding: EdgeInsets.zero,
                                          constraints: const BoxConstraints(),
                                          icon: const Icon(
                                              Icons.bookmark_border_outlined),
                                          onPressed: () {/* ... */},
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                        childCount: books.length,
                      ),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 8,
                        crossAxisSpacing: 8,
                        childAspectRatio: 0.6,
                      ),
                    ),
                  );
                } else if (snapshot.hasError) {
                  return SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        return const ListTile(
                          title: Text('Error'),
                        );
                      },
                      childCount: 1,
                    ),
                  );
                }
                return SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      return const ListTile(
                        title: Text('Loading'),
                      );
                    },
                    childCount: 1,
                  ),
                );
              })
        ],
      ),
    );
  }
}
