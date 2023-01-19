import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';
import 'package:flutter/material.dart';
import 'package:textbook_library/models/book.dart';

class BookPreviewScreen extends StatefulWidget {
  const BookPreviewScreen({super.key, this.book});

  final Book? book;

  @override
  State<BookPreviewScreen> createState() => _BookPreviewState();
}

class _BookPreviewState extends State<BookPreviewScreen> {
  late PDFDocument doc;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    loadDocument();
  }

  loadDocument() async {
    doc = await PDFDocument.fromURL(widget.book?.downloadUrl ?? "");

    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Book Preview'),
      ),
      body: Center(
        child: _isLoading
            ? Center(child: CircularProgressIndicator())
            : PDFViewer(
                document: doc,
                zoomSteps: 1,
                pickerButtonColor: Colors.orange,
              ),
      ),
    );
  }
}
