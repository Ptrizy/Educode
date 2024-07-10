import 'package:flutter/material.dart';
import 'package:pdfx/pdfx.dart';

class CapaianPembelajaranScreen extends StatefulWidget {
  const CapaianPembelajaranScreen({super.key});

  @override
  State<CapaianPembelajaranScreen> createState() =>
      _CapaianPembelajaranScreenState();
}

class _CapaianPembelajaranScreenState extends State<CapaianPembelajaranScreen> {
  late PdfControllerPinch pdfControllerPinch;

  int totalPageCount = 0, currentPage = 1;

  @override
  void initState() {
    super.initState();
    pdfControllerPinch = PdfControllerPinch(
        document:
            PdfDocument.openAsset('assets/file/capaian_pembelajaran.pdf'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Capaian Pembelajaran",
          style: TextStyle(fontSize: 20, color: Colors.black),
        ),
        backgroundColor: const Color(0XFFBDF565),
      ),
      body: _buildUI(),
    );
  }

  Widget _buildUI() {
    return Column(
      children: [
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("Total Pages: $totalPageCount"),
            IconButton(
              onPressed: () {
                pdfControllerPinch.previousPage(
                  duration: const Duration(
                    milliseconds: 500,
                  ),
                  curve: Curves.linear,
                );
              },
              icon: const Icon(
                Icons.arrow_back,
              ),
            ),
            Text("Current Page: $currentPage"),
            IconButton(
              onPressed: () {
                pdfControllerPinch.nextPage(
                  duration: const Duration(
                    milliseconds: 500,
                  ),
                  curve: Curves.linear,
                );
              },
              icon: const Icon(
                Icons.arrow_forward,
              ),
            ),
          ],
        ),
        _pdfView(),
      ],
    );
  }

  Widget _pdfView() {
    return Expanded(
      child: PdfViewPinch(
        scrollDirection: Axis.vertical,
        controller: pdfControllerPinch,
        onDocumentLoaded: (doc) {
          setState(() {
            totalPageCount = doc.pagesCount;
          });
        },
        onPageChanged: (page) {
          setState(() {
            currentPage = page;
          });
        },
      ),
    );
  }
}
