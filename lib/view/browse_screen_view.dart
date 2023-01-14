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
                    sliver: SliverAnimatedList(
                      initialItemCount: books.length,
                      itemBuilder: (context, index, animation) {
                        return SizeTransition(
                          sizeFactor: animation,
                          child: Card(
                            margin: const EdgeInsets.only(bottom: 24),
                            child: Padding(
                              padding: const EdgeInsets.all(16),
                              child: Row(
                                children: <Widget>[
                                  SizedBox(
                                    width: 80,
                                    child: Image.network(
                                      books[index]
                                          .volumeInfo
                                          .imageLinks!
                                          .smallThumbnail,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  const SizedBox(width: 16),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Row(
                                          children: <Widget>[
                                            Expanded(
                                              child: Text(
                                                books[index].volumeInfo.title,
                                                maxLines: 3,
                                                overflow: TextOverflow.ellipsis,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .titleLarge,
                                              ),
                                            ),
                                            const SizedBox(width: 16),
                                            IconButton(
                                              icon: const Icon(Icons
                                                  .bookmark_border_outlined),
                                              onPressed: () {},
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 8),
                                        Text(
                                          books[index].volumeInfo.authors![0],
                                          style: Theme.of(context)
                                              .textTheme
                                              .subtitle2
                                              ?.apply(
                                                  color: Colors.grey.shade600),
                                        ),
                                        const SizedBox(height: 8),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
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
