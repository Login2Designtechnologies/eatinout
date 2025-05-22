// ignore_for_file: sized_box_for_whitespace, prefer_const_constructors, file_names, must_be_immutable, unnecessary_string_interpolations, use_key_in_widget_constructors

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dineout/Getx_Controller/Controller.dart';
import 'package:dineout/Utils/Custom_widegt.dart';
import 'package:dineout/api/confrigation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Utils/dark_light_mode.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class MenuOld extends StatefulWidget {
  String? menuPdfUrl;
  String? viewmenuid;
  MenuOld({this.viewmenuid, this.menuPdfUrl, super.key});

  @override
  State<MenuOld> createState() => _MenuState();
}

class _MenuState extends State<MenuOld> {
  List list = [];

  HomeController menulist = Get.put(HomeController());

  late ColorNotifier notifier;

  getDarkMode() async {
    final prefs = await SharedPreferences.getInstance();
    bool? previousState = prefs.getBool("setIsDark");
    if (previousState == null) {
      notifier.setIsDark = false;
    } else {
      notifier.setIsDark = previousState;
    }
  }

  @override
  Widget build(BuildContext context) {
    notifier = Provider.of<ColorNotifier>(context, listen: true);
    return Scaffold(
      backgroundColor: notifier.background,
      body: GetBuilder<HomeController>(builder: (context) {
        return Column(
          children: [
            CustomAppbar(
                aapbarbgcolor: notifier.background,
                Hedingtext: "Menu".tr,
                color: notifier.textColor,
                subtext: "${_pageCount} Pages",
                backarrow: "assets/arrowleft.png"),
            Expanded(
              // child: SingleChildScrollView(
              //   child: Padding(
              //     padding: EdgeInsets.symmetric(horizontal: 12),
              //     child: ListView.builder(
              //       scrollDirection: Axis.vertical,
              //       shrinkWrap: true,
              //       padding: EdgeInsets.only(bottom: 12),
              //       physics: NeverScrollableScrollPhysics(),
              //       itemCount: menulist.viewmenu.length,
              //       itemBuilder: (BuildContext context, int index) {
              //         return Column(
              //           crossAxisAlignment: CrossAxisAlignment.start,
              //           children: [
              //             SizedBox(height: Get.height * 0.025),
              //             Text(menulist.viewmenu[index]["title"],
              //                 style: TextStyle(
              //                     fontFamily: "Gilroy Bold",
              //                     color: notifier.textColor,
              //                     fontSize: 16)),
              //             SizedBox(height: Get.height * 0.025),
              //             InkWell(
              //               onTap: () {
              //                 Get.to(() => FullScreenImage(
              //                     imageUrl: AppUrl.imageurl +
              //                         menulist.viewmenu[index]["img"],
              //                     tag: "generate_a_unique_tag"));
              //               },
              //               child: Container(
              //                 height: Get.height * 0.5,
              //                 width: double.infinity,
              //                 child: FadeInImage.assetNetwork(
              //                   fadeInCurve: Curves.easeInCirc,
              //                   placeholder: "assets/ezgif.com-crop.gif",
              //                   height: Get.height * 0.4,
              //                   width: Get.width * 0.7,
              //                   placeholderCacheHeight: 320,
              //                   placeholderCacheWidth: 240,
              //                   placeholderFit: BoxFit.fill,
              //                   // placeholderScale: 1.0,
              //                   image: AppUrl.imageurl +
              //                       menulist.viewmenu[index]["img"],
              //                   fit: BoxFit.cover,
              //                 ),
              //               ),
              //             ),
              //           ],
              //         );
              //       },
              //     ),
              //   ),
              // ),
              child: widget.menuPdfUrl != null
                  ? _filePath.isEmpty
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircularProgressIndicator(value: _progress),
                            SizedBox(height: 20),
                            Text(
                                'Downloading menu... ${(_progress * 100).toStringAsFixed(0)}%'),
                          ],
                        )
                      // : SfPdfViewer.file(File(_filePath)
                      : SfPdfViewer.file(
                          pdfFile!,
                          controller: _pdfViewerController,
                          onDocumentLoaded: (PdfDocumentLoadedDetails details) {
                            print('foing to cunt page ');
                            _onDocumentLoaded(); // Update the page count when the document is loaded
                          },
                        )
                  // : Center(
                  //     child: Text("data"),
                  //   )
                  // : SfPdfViewer.network(
                  //     AppUrl.imageurl + widget.menuPdfUrl!,
                  //     controller: _pdfViewerController,
                  //     onDocumentLoaded: (PdfDocumentLoadedDetails details) {
                  //       _onDocumentLoaded(); // Update the page count when the document is loaded
                  //     },
                  //   )
                  : Center(
                      child: Text("No menu found!!!"),
                    ),
            ),
          ],
        );
      }),
    );
  }

  @override
  void initState() {
    getDarkMode();
    _httpClient = http.Client();
    _downloadPdf();
    _pdfViewerController = PdfViewerController();
    super.initState();
    menulist.viewmenulist(id: widget.viewmenuid);
    // ignore: avoid_print
    print("6666666666666viewmenu length---------------"
        "${menulist.viewmenu.length.toString()}");
  }

  @override
  void dispose() {
    _pdfViewerController.dispose();
    if (_isDownloading) {
      _httpClient.close(); // Close the client to cancel the request
    }

    super.dispose();
  }

  void _onDocumentLoaded() {
    print("o bj e c t" * 90);
    setState(() {
      _pageCount = _pdfViewerController.pageCount; // Update the page count
    });
    print(_pageCount);
  }

  late PdfViewerController _pdfViewerController;
  int _pageCount = 0;
  String _filePath = "";
  double _progress = 0.0;
  late http.Client _httpClient;
  bool _isDownloading = false;
  File? pdfFile;

  Future<void> _downloadPdf() async {
    setState(() {
      _isDownloading = true;
    });
    final url = AppUrl.imageurl + widget.menuPdfUrl!;
    final response =
        await _httpClient.send(http.Request('GET', Uri.parse(url)));

    final bytes = <int>[];
    final totalBytes = response.contentLength ?? 0;

    // Save the file to the local device
    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/downloaded_pdf.pdf');
    final sink = file.openWrite();

    response.stream.listen(
      (List<int> chunk) {
        bytes.addAll(chunk);
        final downloadedBytes = bytes.length;

        // Only call setState if the widget is still mounted
        if (mounted) {
          setState(() {
            _progress = downloadedBytes / totalBytes;
          });
        }

        sink.add(chunk);
      },
      onDone: () async {
        await sink.flush();
        await sink.close();

        // Only call setState if the widget is still mounted
        if (mounted) {
          print("*" * 90);
          print('file download');
          setState(() {
            _filePath = file.path;
            pdfFile = file;
            _isDownloading = false; // Mark download as complete
          });
          print(_filePath);
          print(file);
          // print(object)
        }
      },
      onError: (error) {
        // Handle error and ensure the state is updated safely
        if (mounted) {
          print('error while downloinadsfla');
          setState(() {
            _filePath = ''; // Indicate error state
            _isDownloading = false;
          });
        }
      },
    );
  }
}

class FullScreenImage extends StatelessWidget {
  String? imageUrl;
  String? tag;
  FullScreenImage({this.imageUrl, this.tag});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      body: GestureDetector(
        child: Center(
          child: Hero(
            tag: tag ?? "",
            child: CachedNetworkImage(
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.contain,
              imageUrl: imageUrl ?? "",
            ),
          ),
        ),
        onTap: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}
