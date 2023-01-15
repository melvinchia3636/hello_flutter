import 'package:filesize/filesize.dart';
import 'package:flutter/material.dart';
import 'package:hello_flutter/api/fetch_books.dart';
import 'package:hello_flutter/models/book.dart';
import 'package:hello_flutter/models/book_list.dart';
import 'package:sliver_header_delegate/sliver_header_delegate.dart';

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
                  onPressed: () {},
                ),
                IconButton(
                  icon: const Icon(Icons.more_vert),
                  onPressed: () {},
                ),
              ],
              children: [
                FlexibleTextItem(
                  text: 'Senior 2 高二',
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
          FutureBuilder<BookList>(
              future: fetchBooks("sm2"),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final List<Book> books = snapshot.data!.books;
                  return SliverPadding(
                    padding: const EdgeInsets.all(24),
                    sliver: SliverAnimatedList(
                      initialItemCount: books.length,
                      itemBuilder: (context, index, animation) {
                        return SizeTransition(
                          sizeFactor: animation,
                          child: Card(
                            margin: const EdgeInsets.only(bottom: 8),
                            child: Padding(
                              padding: const EdgeInsets.all(16),
                              child: Row(
                                children: <Widget>[
                                  SizedBox(
                                    width: 80,
                                    child: Image.network(
                                      books[index].thumbnailUrl,
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
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: <Widget>[
                                            Expanded(
                                              child: Text(
                                                books[index].title,
                                                maxLines: 3,
                                                overflow: TextOverflow.ellipsis,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .titleMedium,
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 8),
                                        Text(
                                          "${books[index].pageCount} pages",
                                          style: Theme.of(context)
                                              .textTheme
                                              .subtitle2
                                              ?.apply(
                                                  color: Colors.grey.shade600),
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          filesize(books[index].size),
                                          style: Theme.of(context)
                                              .textTheme
                                              .subtitle2
                                              ?.apply(
                                                  color: Colors.grey.shade600),
                                        ),
                                      ],
                                    ),
                                  ),
                                  IconButton(
                                    icon: const Icon(
                                      Icons.bookmark_border_outlined,
                                      color: Colors.grey,
                                    ),
                                    onPressed: () {},
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
