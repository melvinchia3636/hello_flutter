import 'package:filesize/filesize.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:textbook_library/models/book.dart';

class BookCard extends StatelessWidget {
  const BookCard({
    Key? key,
    required this.book,
    required this.grade,
  }) : super(key: key);

  final Book book;
  final String grade;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.push('/preview/$grade/${book.id}', extra: book);
      },
      child: Card(
        margin: const EdgeInsets.only(bottom: 8),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: <Widget>[
              SizedBox(
                width: 80,
                child: Image.network(
                  book.thumbnailUrl!,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Expanded(
                          child: Text(
                            book.title,
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "${book.pageCount} pages",
                      style: Theme.of(context)
                          .textTheme
                          .subtitle2
                          ?.apply(color: Colors.grey.shade600),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      filesize(book.size),
                      style: Theme.of(context)
                          .textTheme
                          .subtitle2
                          ?.apply(color: Colors.grey.shade600),
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
  }
}
