import 'package:dineout/Utils/Custom_widegt.dart';
import 'package:dineout/api/confrigation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class Menu extends StatefulWidget {
  // Sample URL for the PDF
  final String? pdfUrl;

  Menu({this.pdfUrl, super.key});

  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  late String _filePath;
  double _progress = 0.0;
  late http.Client _httpClient;
  bool _isDownloading = false;

  @override
  void initState() {
    _pdfViewerController = PdfViewerController();
    super.initState();
    _httpClient = http.Client(); // Initialize HTTP client
    if (widget.pdfUrl != null) {
      _downloadPdf();
    }
  }

  @override
  void dispose() {
    if (_isDownloading) {
      _httpClient.close(); // Close the client if download is still in progress
    }
    super.dispose();
  }

  // Method to download the PDF
  Future<void> _downloadPdf() async {
    setState(() {
      _isDownloading = true;
    });

    final url = AppUrl.imageurl + widget.pdfUrl!;
    final response =
        await _httpClient.send(http.Request('GET', Uri.parse(url!)));

    final bytes = <int>[];
    final totalBytes = response.contentLength ?? 0;

    // Get the application documents directory
    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/downloaded_pdf.pdf');
    final sink = file.openWrite();

    // Listen for the chunks of the file
    response.stream.listen(
      (List<int> chunk) {
        bytes.addAll(chunk);
        final downloadedBytes = bytes.length;

        // Update progress only if the widget is still mounted
        if (mounted) {
          setState(() {
            _progress = downloadedBytes / totalBytes;
          });
        }

        // Write the chunk to the file
        sink.add(chunk);
      },
      onDone: () async {
        await sink.flush();
        await sink.close();

        // Once the file is downloaded, update the state with the file path
        if (mounted) {
          setState(() {
            _filePath = file.path;
            _isDownloading = false;
          });
          print("File downloaded to: $_filePath"); // Debugging: log file path
        }
      },
      onError: (error) {
        if (mounted) {
          setState(() {
            _filePath = '';
            _isDownloading = false;
          });
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          CustomAppbar(
              aapbarbgcolor: Colors.white,
              Hedingtext: "Menu",
              color: Colors.black,
              subtext: "${_pageCount} Pages",
              backarrow: "assets/arrowleft.png"),
          Expanded(
            child: widget.pdfUrl != null
                ? Center(
                    child: _isDownloading
                        ? Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CircularProgressIndicator(value: _progress),
                              SizedBox(height: 20),
                              Text(
                                  'Downloading menu... ${(_progress * 100).toStringAsFixed(0)}%'),
                            ],
                          )
                        : _filePath.isEmpty
                            ? Text('Download failed or no file available.')
                            : SfPdfViewer.file(
                                File(_filePath),
                                controller: _pdfViewerController,
                                onDocumentLoaded:
                                    (PdfDocumentLoadedDetails details) {
                                  _onDocumentLoaded();
                                },
                              ),
                  )
                : Center(
                    child: Text("No menu found!!!"),
                  ),
          ),
        ],
      ),
    );
  }

  late PdfViewerController _pdfViewerController;
  int _pageCount = 0;

  void _onDocumentLoaded() {
    print("o bj e c t" * 90);
    setState(() {
      _pageCount = _pdfViewerController.pageCount; // Update the page count
    });
    print(_pageCount);
  }
}
