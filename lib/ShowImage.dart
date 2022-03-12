import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'main.dart';
import 'dart:ui' as ui;

class ShowImage extends StatefulWidget {
  final File? logoImg,bgImg;
  final String? name,email,phone,address;
  const ShowImage({Key? key,this.logoImg,this.bgImg,this.name,this.email,this.phone,this.address}) : super(key: key);

  @override
  _ShowImageState createState() => _ShowImageState();
}

class _ShowImageState extends State<ShowImage> {
  final GlobalKey _globalKey = GlobalKey();
  File? image;
  bool inside = false;

  requestPermission() async {
    try {
      Map<Permission, PermissionStatus> status = await [
        Permission.storage,
      ].request();



      final info = status[Permission.storage].toString();

      print("Permission:- $info");

    }
    catch (e){
      print(e);
    }
  }

  Future downloadAndSaveFile(Uint8List? userData) async {
    try {
      final Directory? _appDocDir = await getExternalStorageDirectory();
      var finalPath = _appDocDir!.path.split('/');
      Directory myImagePath = Directory("${finalPath[0]}/${finalPath[1]}/${finalPath[2]}/${finalPath[3]}/Download");
      image = File(myImagePath.path);
      await image!.writeAsBytes(userData!);
    } catch (error) {
      print("Exception:- $error");
    }
  }

  Future<Uint8List?> _capturePng() async {
    try {
      print('inside');
      inside = true;
      final RenderRepaintBoundary? boundary = _globalKey.currentContext!.findRenderObject() as RenderRepaintBoundary?;
      ui.Image image = await boundary!.toImage(pixelRatio: 1248);
      final ByteData? byteData =
      await image.toByteData(format: ui.ImageByteFormat.png);
      Uint8List pngBytes = byteData!.buffer.asUint8List();
      setState(() {
        inside = false;
      });
      downloadAndSaveFile(pngBytes);
    } catch (e){
      print(e);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    requestPermission();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ShowImage'),
        centerTitle: true,
        actions: [
          inside == false?IconButton(
            onPressed: (){
              setState(() {
                _capturePng();
              });
            },
            icon: const
            Icon(Icons.download),
          ):Center(child: const CircularProgressIndicator( valueColor: AlwaysStoppedAnimation<Color>(ConstVar.bgCode),))],
      ),
      body: RepaintBoundary(
        key: _globalKey,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Container(
            height:450,
            width: 400,
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
                color: Colors.transparent,
                image: DecorationImage(
                  image: FileImage(widget.bgImg!),
                  fit: BoxFit.cover,
                )
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.file(widget.logoImg!,height: 50,width: 65,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${widget.email}',
                            style: const TextStyle(
                                fontWeight: FontWeight.w900,
                                fontSize: 15,
                                fontFamily: ConstVar.fontFamily,
                                color: ConstVar.fontColour
                            ),
                          ),
                          Text(
                            '${widget.name}',
                            style: const TextStyle(
                                fontWeight: FontWeight.w900,
                                fontSize: 15,
                                fontFamily: ConstVar.fontFamily,
                                color: ConstVar.fontColour
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            '${widget.phone}',
                            style: const TextStyle(
                                fontWeight: FontWeight.w900,
                                fontSize: 15,
                                fontFamily: ConstVar.fontFamily,
                                color: ConstVar.fontColour
                            ),
                          ),
                          Text(
                            '${widget.address}',
                            style: const TextStyle(
                                fontWeight: FontWeight.w900,
                                fontSize: 15,
                                fontFamily: ConstVar.fontFamily,
                                color: ConstVar.fontColour
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
