import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'dart:async';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Leitor de Códigos de Barras',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BarcodeScannerPage(),
    );
  }
}

class BarcodeScannerPage extends StatefulWidget {
  @override
  _BarcodeScannerPageState createState() => _BarcodeScannerPageState();
}

class _BarcodeScannerPageState extends State<BarcodeScannerPage> {
  List<String> barcodeList = [];
  final int maxContainers = 50;
  bool scanning = false;
  Timer? scanningTimer;

  @override
  void dispose() {
    scanningTimer?.cancel();
    super.dispose();
  }

  Future<void> scanBarcode() async {

      String barcodeScanResult = await FlutterBarcodeScanner.scanBarcode(
        '#FF0000',
        'Cancelar',
        true,
        ScanMode.BARCODE,
      );

      if (!barcodeList.contains(barcodeScanResult)) {
        setState(() {
          barcodeList.add(barcodeScanResult);
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Código já lido.'),
            duration: Duration(seconds: 2),
          ),
        );
      }


    if (scanning) {
      scanningTimer = Timer(Duration(seconds: 2), () => scanBarcode());
    }
  }

  void startScanning() {
    setState(() {
      scanning = true;
    });
    scanBarcode();
  }

  void stopScanning() {
    setState(() {
      scanning = false;
    });
    scanningTimer?.cancel();
  }

  void clearList() {
    setState(() {
      barcodeList.clear();
    });
  }

  Widget buildContainer(String barcode) {
    bool isDuplicate = barcodeList.where((code) => code == barcode).length > 1;
    bool isSuccess = !isDuplicate && barcode.isNotEmpty;

    return Container(
      width:
          (MediaQuery.of(context).size.width - 48.0) / 4, // Divide em 4 colunas
      height: 80.0,

      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: isDuplicate ? Colors.red : Colors.blue,
          width: 2.0,
        ),
      ),
      alignment: Alignment.center,
      child: Text(barcode),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Leitor de Códigos de Barras'),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(16.0),
              child: Wrap(
                spacing: 8.0,
                runSpacing: 8.0,
                children: barcodeList
                    .take(maxContainers)
                    .map((barcode) => buildContainer(barcode))
                    .toList(),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  if (!scanning) {
                    startScanning();
                  }
                },
                child: Text('Iniciar Leitura'),
              ),
              SizedBox(width: 16.0),
              ElevatedButton(
                onPressed: () {
                  if (scanning) {
                    stopScanning();
                  }
                },
                child: Text('Parar Leitura'),
              ),
              SizedBox(width: 16.0),
              ElevatedButton(
                onPressed: () {
                  if (scanning) {
                    stopScanning();
                  }
                  clearList();
                },
                child: Text('Limpar Tela'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}


























// import 'package:flutter/material.dart';
// import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
// import 'dart:async';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Leitor de Códigos de Barras',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: BarcodeScannerPage(),
//     );
//   }
// }

// class BarcodeScannerPage extends StatefulWidget {
//   @override
//   _BarcodeScannerPageState createState() => _BarcodeScannerPageState();
// }

// class _BarcodeScannerPageState extends State<BarcodeScannerPage> {
//   List<String> barcodeList = [];
//   final int maxContainers = 50;
//   bool scanning = false;
//   Timer? scanningTimer;

//   @override
//   void dispose() {
//     scanningTimer?.cancel();
//     super.dispose();
//   }

//   Future<void> scanBarcode() async {
//     String barcodeScanResult = await FlutterBarcodeScanner.scanBarcode(
//       '#FF0000',
//       'Cancelar',
//       true,
//       ScanMode.BARCODE,
//     );

//     if (!barcodeList.contains(barcodeScanResult)) {
//       setState(() {
//         barcodeList.add(barcodeScanResult);
//       });
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text('Código já lido.'),
//           duration: Duration(seconds: 2),
//         ),
//       );
//     }

//     if (scanning) {
//       scanningTimer = Timer(Duration(seconds: 2), () => scanBarcode());
//     }
//   }

//   void startScanning() {
//     setState(() {
//       scanning = true;
//     });
//     scanBarcode();
//   }

//   void stopScanning() {
//     setState(() {
//       scanning = false;
//     });
//     scanningTimer?.cancel();
//   }

//   void clearList() {
//     setState(() {
//       barcodeList.clear();
//     });
//   }

//   Widget buildContainer(String barcode) {
//     bool isDuplicate = barcodeList.where((code) => code == barcode).length > 1;
//     bool isSuccess = !isDuplicate && barcode.isNotEmpty;

//     return Container(
//       width: (MediaQuery.of(context).size.width - 48.0) / 4, // Divide em 4 colunas
//       height: 80.0,
      
//       decoration: BoxDecoration(
//         color: Colors.white,
//         border: Border.all(
//           color: isDuplicate ? Colors.red : Colors.blue,
//           width: 2.0,
//         ),
//       ),
//       alignment: Alignment.center,
//       child: Text(barcode),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Leitor de Códigos de Barras'),
//       ),
//       body: Column(
//         children: [
//           Expanded(
//             child: SingleChildScrollView(
//               padding: EdgeInsets.all(16.0),
//               child: Wrap(
//                 spacing: 8.0,
//                 runSpacing: 8.0,
//                 children: barcodeList
//                     .take(maxContainers)
//                     .map((barcode) => buildContainer(barcode))
//                     .toList(),
//               ),
//             ),
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               ElevatedButton(
//                 onPressed: () {
//                   if (!scanning) {
//                     startScanning();
//                   }
//                 },
//                 child: Text('Iniciar Leitura'),
//               ),
//               SizedBox(width: 16.0),
//               ElevatedButton(
//                 onPressed: () {
//                   if (scanning) {
//                     stopScanning();
//                   }
//                 },
//                 child: Text('Parar Leitura'),
//               ),
//               SizedBox(width: 16.0),
//               ElevatedButton(
//                 onPressed: () {
//                   if (scanning) {
//                     stopScanning();
//                   }
//                   clearList();
//                 },
//                 child: Text('Limpar Tela'),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }











// **** OPÇÃO 1 ****

// import 'package:flutter/material.dart';
// import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Leitor de Códigos de Barras',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: BarcodeScannerPage(),
//     );
//   }
// }

// class BarcodeScannerPage extends StatefulWidget {
//   @override
//   _BarcodeScannerPageState createState() => _BarcodeScannerPageState();
// }

// class _BarcodeScannerPageState extends State<BarcodeScannerPage> {
//   List<String> barcodeList = [];
//   final int maxContainers = 50;

//   Future<void> scanBarcode() async {
//     String barcodeScanResult = await FlutterBarcodeScanner.scanBarcode(
//       '#FF0000',
//       'Cancelar',
//       true,
//       ScanMode.BARCODE,
//     );

//     if (!barcodeList.contains(barcodeScanResult)) {
//       setState(() {
//         barcodeList.add(barcodeScanResult);
//       });
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text('Código já lido.'),
//           duration: Duration(seconds: 2),
//         ),
//       );
//     }
//   }

//   void clearList() {
//     setState(() {
//       barcodeList.clear();
//     });
//   }

//   Widget buildContainer(String barcode) {
//     bool isDuplicate = barcodeList.where((code) => code == barcode).length > 1;
//     bool isSuccess = !isDuplicate && barcode.isNotEmpty;

//     return Container(
//       width: (MediaQuery.of(context).size.width - 48.0) / 4, // Divide em 4 colunas
//       height: 40.0,
//       decoration: BoxDecoration(
//         color: Colors.white,
//         border: Border.all(
//           color: isDuplicate ? Colors.red : Colors.blue,
//           width: 2.0,
//         ),
//       ),
//       alignment: Alignment.center,
//       child: Text(barcode),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Leitor de Códigos de Barras'),
//       ),
//       body: Column(
//         children: [
//           Expanded(
//             child: SingleChildScrollView(
//               padding: EdgeInsets.all(16.0),
//               child: Wrap(
//                 spacing: 8.0,
//                 runSpacing: 8.0,
//                 children: barcodeList
//                     .take(maxContainers)
//                     .map((barcode) => buildContainer(barcode))
//                     .toList(),
//               ),
//             ),
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               ElevatedButton(
//                 onPressed: scanBarcode,
//                 child: Text('Escanear Código'),
//               ),
//               SizedBox(width: 16.0),
//               ElevatedButton(
//                 onPressed: clearList,
//                 child: Text('Limpar Tela'),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }





// import 'package:flutter/material.dart';
// import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Leitor de Códigos de Barras',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: BarcodeScannerPage(),
//     );
//   }
// }

// class BarcodeScannerPage extends StatefulWidget {
//   @override
//   _BarcodeScannerPageState createState() => _BarcodeScannerPageState();
// }

// class _BarcodeScannerPageState extends State<BarcodeScannerPage> {
//   List<String> barcodeList = [];
//   int maxContainers = 50;

//   Future<void> scanBarcode() async {
//     String barcodeScanResult = await FlutterBarcodeScanner.scanBarcode(
//       '#FF0000',
//       'Cancelar',
//       true,
//       ScanMode.BARCODE,
//     );

//     if (barcodeList.length >= maxContainers) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text('Limite de containers atingido.'),
//           duration: Duration(seconds: 2),
//         ),
//       );
//       return;
//     }

//     setState(() {
//       if (!barcodeList.contains(barcodeScanResult)) {
//         barcodeList.add(barcodeScanResult);
//       }
//     });
//   }

//   Widget buildContainer(String barcode) {
//     bool isDuplicate = barcodeList.indexOf(barcode) != barcodeList.lastIndexOf(barcode);
//     bool isSuccess = !isDuplicate && barcodeList.contains(barcode);

//     return Container(
//       width: (MediaQuery.of(context).size.width - 48.0) / 4,
//       height: 40.0,
//       decoration: BoxDecoration(
//         color: isSuccess ? Colors.blue : isDuplicate ? Colors.red : Colors.white,
//         border: Border.all(color: Colors.black),
//       ),
//       alignment: Alignment.center,
//       child: Text(barcode),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Leitor de Códigos de Barras'),
//       ),
//       body: Center(
//         child: Container(
//           width: MediaQuery.of(context).size.width - 32.0,
//           color: Colors.grey[200],
//           padding: EdgeInsets.all(8.0),
//           child: Wrap(
//             spacing: 8.0,
//             runSpacing: 8.0,
//             children: List.generate(maxContainers, (index) {
//               if (index < barcodeList.length) {
//                 return buildContainer(barcodeList[index]);
//               } else {
//                 return buildContainer('');
//               }
//             }),
//           ),
//         ),
//       ),
//       floatingActionButton: FloatingActionButton.extended(
//         onPressed: scanBarcode,
//         label: Text('Escanear Código'),
//         icon: Icon(Icons.camera_alt),
//       ),
//       floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
//     );
//   }
// }






//CÓDIGO A SER USADO: *** 

// import 'package:flutter/material.dart';
// import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Leitor de Códigos de Barras',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: BarcodeScannerPage(),
//     );
//   }
// }

// class BarcodeScannerPage extends StatefulWidget {
//   @override
//   _BarcodeScannerPageState createState() => _BarcodeScannerPageState();
// }

// class _BarcodeScannerPageState extends State<BarcodeScannerPage> {
//   List<String> barcodeList = [];

//   Future<void> scanBarcode() async {
//     String barcodeScanResult = await FlutterBarcodeScanner.scanBarcode(
//       '#FF0000',
//       'Cancelar',
//       true,
//       ScanMode.BARCODE,
//     );

//     if (!barcodeList.contains(barcodeScanResult)) {
//       setState(() {
//         barcodeList.add(barcodeScanResult);
//       });
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text('Código já lido.'),
//           duration: Duration(seconds: 2),
//         ),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Leitor de Códigos de Barras'),
//       ),
//       body: Center(
//         child: Container(
//           width: MediaQuery.of(context).size.width - 32.0,
//           color: Colors.grey[200],
//           padding: EdgeInsets.all(8.0),
//           child: Wrap(
//             spacing: 8.0,
//             runSpacing: 8.0,
//             children: barcodeList.map((barcode) {
//               return Container(
//                 width: (MediaQuery.of(context).size.width - 48.0) / 4, // Divide em 4 colunas
//                 height: 40.0,
//                 color: Colors.white,
//                 alignment: Alignment.center,
//                 child: Text(barcode),
//               );
//             }).toList(),
//           ),
//         ),
//       ),
//       floatingActionButton: FloatingActionButton.extended(
//         onPressed: scanBarcode,
//         label: Text('Escanear Código'),
//         icon: Icon(Icons.camera_alt),
//       ),
//       floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
//     );
//   }
// }

























// *** MODELO CAMERA LIGADA ***

// ignore_for_file: public_member_api_docs, sort_constructors_first
// import 'package:camera/camera.dart';
// import 'package:flutter/material.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();

//   // Obtenha a lista de câmeras disponíveis
//   final cameras = await availableCameras();

//   runApp(MyApp(cameras: cameras));
// }

// class MyApp extends StatelessWidget {
//   final List<CameraDescription> cameras;

//   const MyApp({
//     Key? key,
//     required this.cameras,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Leitor de Códigos de Barras',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: BarcodeScannerPage(
//         cameras: cameras,
//       ),
//     );
//   }
// }

// class BarcodeScannerPage extends StatefulWidget {
//   final List<CameraDescription> cameras;

//   const BarcodeScannerPage({
//     required this.cameras,
//   });

//   @override
//   _BarcodeScannerPageState createState() => _BarcodeScannerPageState();
// }

// class _BarcodeScannerPageState extends State<BarcodeScannerPage> {
//   late CameraController _cameraController;
//   late Future<void> _cameraInitializer;

//   List<String> barcodeList = [];
//   int maxCodesPerLine = 4;

//   @override
//   void initState() {
//     super.initState();

//     // Inicialize a câmera usando a primeira câmera disponível
//     _cameraController =
//         CameraController(widget.cameras[0], ResolutionPreset.high);

//     // Inicialize a câmera assincronamente
//     _cameraInitializer = _cameraController.initialize();
//   }

//   @override
//   void dispose() {
//     // Certifique-se de liberar os recursos da câmera ao finalizar a página
//     _cameraController.dispose();

//     super.dispose();
//   }

//   Future<void> scanBarcode() async {
//     if (!_cameraController.value.isInitialized) {
//       return;
//     }

//     try {
//       // Capture a imagem da câmera
//       final image = await _cameraController.takePicture();

//       // Faça o processamento da imagem e leia o código de barras
//       // ... Coloque aqui a lógica de processamento do código de barras ...

//       String barcodeScanResult = "Código de barras lido";

//       if (!barcodeList.contains(barcodeScanResult)) {
//         setState(() {
//           barcodeList.add(barcodeScanResult);
//         });
//       } else {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text('Código já lido.'),
//             duration: Duration(seconds: 2),
//           ),
//         );
//       }
//     } catch (e) {
//       print('Erro ao ler o código de barras: $e');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Leitor de Códigos de Barras'),
//       ),
//       body: Column(
//         children: [
//           Expanded(
//             child: Stack(
//               children: [
//                 // Exibe a visualização da câmera no topo da tela
//                 Positioned(
//                   top: 0,
//                   left: 0,
//                   right: 0,
//                   bottom: MediaQuery.of(context).size.height * 0.4,
//                   child: CameraPreview(_cameraController),
//                 ),
//                 // Exibe os resultados dos códigos de barras na tela
//                 Positioned(
//                   top: MediaQuery.of(context).size.height * 0.4,
//                   left: 0,
//                   right: 0,
//                   child: Container(
//                     color: Colors.grey[200],
//                     padding: EdgeInsets.all(8.0),
//                     child: Wrap(
//                       runSpacing: 8.0,
//                       children:
//                           List<Widget>.generate(barcodeList.length, (index) {
//                         final row = index ~/ maxCodesPerLine;
//                         final column = index % maxCodesPerLine;

//                         return Container(
//                           width: MediaQuery.of(context).size.width * 0.25,
//                           height: 40.0,
//                           color: Colors.white,
//                           alignment: Alignment.center,
//                           margin: EdgeInsets.only(
//                             right: column != maxCodesPerLine - 1 ? 8.0 : 0.0,
//                             bottom:
//                                 row != barcodeList.length ~/ maxCodesPerLine - 1
//                                     ? 8.0
//                                     : 0.0,
//                           ),
//                           child: Text(barcodeList[index]),
//                         );
//                       }),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//       floatingActionButton: FloatingActionButton.extended(
//         onPressed: scanBarcode,
//         label: Text('Escanear Código'),
//         icon: Icon(Icons.camera_alt),
//       ),
//       floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
//     );
//   }
// }











































// // ignore_for_file: public_member_api_docs, sort_constructors_first
// import 'package:camera/camera.dart';
// import 'package:flutter/material.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();

//   // Obtenha a lista de câmeras disponíveis
//   final cameras = await availableCameras();

//   runApp(MyApp(cameras: cameras));
// }

// class MyApp extends StatelessWidget {
//   final List<CameraDescription> cameras;

//   const MyApp({this.cameras});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Leitor de Códigos de Barras',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: BarcodeScannerPage(cameras: cameras),
//     );
//   }
// }

// class BarcodeScannerPage extends StatefulWidget {
//   final List<CameraDescription> cameras;

//   const BarcodeScannerPage({
//     Key key,
//      this.cameras,
//   }) : super(key: key);

//   @override
//   _BarcodeScannerPageState createState() => _BarcodeScannerPageState();
// }

// class _BarcodeScannerPageState extends State<BarcodeScannerPage> {
//    CameraController _cameraController;
//    Future<void> _cameraInitializer;

//   List<String> barcodeList = [];

//   @override
//   void initState() {
//     super.initState();

//     // Inicialize a câmera usando a primeira câmera disponível
//     _cameraController = CameraController(widget.cameras[0], ResolutionPreset.high);

//     // Inicialize a câmera assincronamente
//     _cameraInitializer = _cameraController.initialize();
//   }

//   @override
//   void dispose() {
//     // Certifique-se de liberar os recursos da câmera ao finalizar a página
//     _cameraController.dispose();

//     super.dispose();
//   }

//   Future<void> scanBarcode() async {
//     if (!_cameraController.value.isInitialized) {
//       return;
//     }

//     try {
//       // Capture a imagem da câmera
//       final image = await _cameraController.takePicture();

//       // Faça o processamento da imagem e leia o código de barras
//       // ... Coloque aqui a lógica de processamento do código de barras ...

//       String barcodeScanResult = "Código de barras lido";

//       if (!barcodeList.contains(barcodeScanResult)) {
//         setState(() {
//           barcodeList.add(barcodeScanResult);
//         });
//       } else {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text('Código já lido.'),
//             duration: Duration(seconds: 2),
//           ),
//         );
//       }
//     } catch (e) {
//       print('Erro ao ler o código de barras: $e');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Leitor de Códigos de Barras'),
//       ),
//       body: FutureBuilder<void>(
//         future: _cameraInitializer,
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.done) {
//             return Stack(
//               children: [
//                 // Exibe os resultados dos códigos de barras na tela
//                 Positioned(
//                   top: MediaQuery.of(context).size.height * 0.3,
//                   left: 0,
//                   right: 0,
//                   child: Container(
//                     height: MediaQuery.of(context).size.height * 0.7,
//                     color: Colors.grey[200],
//                     padding: EdgeInsets.all(8.0),
//                     child: ListView.builder(
//                       itemCount: barcodeList.length,
//                       itemBuilder: (context, index) {
//                         return Container(
//                           height: 40.0,
//                           color: Colors.white,
//                           alignment: Alignment.center,
//                           child: Text(barcodeList[index]),
//                         );
//                       },
//                     ),
//                   ),
//                 ),
//               ],
//             );
//           } else {
//             return Center(child: CircularProgressIndicator());
//           }
//         },
//       ),
//       floatingActionButton: FloatingActionButton.extended(
//         onPressed: scanBarcode,
//         label: Text('Escanear Código'),
//         icon: Icon(Icons.camera_alt),
//       ),
//       floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
//     );
//   }
// }



//VERSÃO ATUALIZADA: 0.0.1

// ignore_for_file: public_member_api_docs, sort_constructors_first
// import 'package:camera/camera.dart';
// import 'package:flutter/material.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();

//   // Obtenha a lista de câmeras disponíveis
//   final cameras = await availableCameras();

//   runApp(MyApp(cameras: cameras));
// }

// class MyApp extends StatelessWidget {
//   final List<CameraDescription> cameras;

//   const MyApp({this.cameras});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Leitor de Códigos de Barras',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: BarcodeScannerPage(cameras: cameras),
//     );
//   }
// }

// class BarcodeScannerPage extends StatefulWidget {
//   final List<CameraDescription> cameras;

//   const BarcodeScannerPage({
//     Key key,
//     this.cameras,
//   }) : super(key: key);

//   @override
//   _BarcodeScannerPageState createState() => _BarcodeScannerPageState();
// }

// class _BarcodeScannerPageState extends State<BarcodeScannerPage> {
//   CameraController _cameraController;
//   Future<void> _cameraInitializer;

//   List<String> barcodeList = [];

//   @override
//   void initState() {
//     super.initState();

//     // Inicialize a câmera usando a primeira câmera disponível
//     _cameraController = CameraController(widget.cameras[0], ResolutionPreset.high);

//     // Inicialize a câmera assincronamente
//     _cameraInitializer = _cameraController.initialize();
//   }

//   @override
//   void dispose() {
//     // Certifique-se de liberar os recursos da câmera ao finalizar a página
//     _cameraController.dispose();

//     super.dispose();
//   }

//   Future<void> scanBarcode() async {
//     if (!_cameraController.value.isInitialized) {
//       return;
//     }

//     try {
//       // Capture a imagem da câmera
//       final image = await _cameraController.takePicture();

//       // Faça o processamento da imagem e leia o código de barras
//       // ... Coloque aqui a lógica de processamento do código de barras ...

//       String barcodeScanResult = "Código de barras lido";

//       if (!barcodeList.contains(barcodeScanResult)) {
//         setState(() {
//           barcodeList.add(barcodeScanResult);
//         });
//       } else {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text('Código já lido.'),
//             duration: Duration(seconds: 2),
//           ),
//         );
//       }
//     } catch (e) {
//       print('Erro ao ler o código de barras: $e');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Leitor de Códigos de Barras'),
//       ),
//       body: Column(
//         children: [
//           Expanded(
//             child: Stack(
//               children: [
//                 // Exibe a visualização da câmera no topo da tela
//                 Positioned(
//                   top: 0,
//                   left: 0,
//                   right: 0,
//                   bottom: MediaQuery.of(context).size.height * 0.4,
//                   child: CameraPreview(_cameraController),
//                 ),
//                 // Exibe os resultados dos códigos de barras na tela
//                 Positioned(
//                   top: MediaQuery.of(context).size.height * 0.4,
//                   left: 0,
//                   right: 0,
//                   child: Container(
//                     color: Colors.grey[200],
//                     padding: EdgeInsets.all(8.0),
//                     child: Wrap(
//                       runSpacing: 8.0,
//                       children: barcodeList.map((barcode) {
//                         return Container(
//                           width: MediaQuery.of(context).size.width * 0.25,
//                           height: 40.0,
//                           color: Colors.white,
//                           alignment: Alignment.center,
//                           child: Text(barcode),
//                         );
//                       }).toList(),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//       floatingActionButton: FloatingActionButton.extended(
//         onPressed: scanBarcode,
//         label: Text('Escanear Código'),
//         icon: Icon(Icons.camera_alt),
//       ),
//       floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
//     );
//   }
// }

































//possivel uso de trecho de código

// import 'package:flutter/material.dart';
// import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Leitor de Códigos de Barras',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: BarcodeScannerPage(),
//     );
//   }
// }

// class BarcodeScannerPage extends StatefulWidget {
//   @override
//   _BarcodeScannerPageState createState() => _BarcodeScannerPageState();
// }

// class _BarcodeScannerPageState extends State<BarcodeScannerPage> {
//   List<String> barcodeList = [];

//   Future<void> scanBarcode() async {
//     String barcodeScanResult = await FlutterBarcodeScanner.scanBarcode(
//       '#FF0000',
//       'Cancelar',
//       true,
//       ScanMode.BARCODE,
//     );

//     if (!barcodeList.contains(barcodeScanResult)) {
//       setState(() {
//         barcodeList.add(barcodeScanResult);
//       });
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text('Código já lido.'),
//           duration: Duration(seconds: 2),
//         ),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Leitor de Códigos de Barras'),
//       ),
//       body: Column(
//         children: [
//           Container(
//             width: MediaQuery.of(context).size.width,
//             height: MediaQuery.of(context).size.height - kToolbarHeight - 80.0,
//             color: Colors.grey[200],
//             padding: EdgeInsets.all(8.0),
//             child: Wrap(
//               spacing: 8.0,
//               runSpacing: 8.0,
//               children: barcodeList.map((barcode) {
//                 return Container(
//                   width: (MediaQuery.of(context).size.width - 48.0) / 4, // Divide em 4 colunas
//                   height: 40.0,
//                   color: Colors.white,
//                   alignment: Alignment.center,
//                   child: Text(barcode),
//                 );
//               }).toList(),
//             ),
//           ),
//           SizedBox(height: 8.0),
//           Expanded(
//             child: Container(
//               width: MediaQuery.of(context).size.width,
//               height: 80.0,
//               color: Colors.grey[200],
//               child: Center(
//                 child: FloatingActionButton.extended(
//                   onPressed: scanBarcode,
//                   label: Text('Escanear Código'),
//                   icon: Icon(Icons.camera_alt),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }


























//possivel aproveitamento de código

// import 'package:flutter/material.dart';
// import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Leitor de Códigos de Barras',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: BarcodeScannerPage(),
//     );
//   }
// }

// class BarcodeScannerPage extends StatefulWidget {
//   @override
//   _BarcodeScannerPageState createState() => _BarcodeScannerPageState();
// }

// class _BarcodeScannerPageState extends State<BarcodeScannerPage> {
//   List<String> barcodeList = [];

//   Future<void> scanBarcode() async {
//     String barcodeScanResult = await FlutterBarcodeScanner.scanBarcode(
//       '#FF0000',
//       'Cancelar',
//       true,
//       ScanMode.BARCODE,
//     );

//     if (!barcodeList.contains(barcodeScanResult)) {
//       setState(() {
//         barcodeList.add(barcodeScanResult);
//       });
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text('Código já lido.'),
//           duration: Duration(seconds: 2),
//         ),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Leitor de Códigos de Barras'),
//       ),
//       body: Column(
//         children: [
//           Expanded(
//             child: Container(
//               color: Colors.grey[200],
//               padding: EdgeInsets.all(8.0),
//               child: Wrap(
//                 spacing: 8.0,
//                 runSpacing: 8.0,
//                 children: barcodeList.map((barcode) {
//                   return Container(
//                     width: (MediaQuery.of(context).size.width - 48.0) / 4, // Divide em 4 colunas
//                     height: 40.0,
//                     color: Colors.white,
//                     alignment: Alignment.center,
//                     child: Text(barcode),
//                   );
//                 }).toList(),
//               ),
//             ),
//           ),
//           SizedBox(height: 8.0),
//           Container(
//             height: 100.0,
//             color: Colors.grey[300],
//             child: Center(
//               child: FloatingActionButton.extended(
//                 onPressed: scanBarcode,
//                 label: Text('Escanear Código'),
//                 icon: Icon(Icons.camera_alt),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

















// import 'package:flutter/material.dart';
// import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Leitor de Códigos de Barras',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: BarcodeScannerPage(),
//     );
//   }
// }

// class BarcodeScannerPage extends StatefulWidget {
//   @override
//   _BarcodeScannerPageState createState() => _BarcodeScannerPageState();
// }

// class _BarcodeScannerPageState extends State<BarcodeScannerPage> {
//   List<String> barcodeList = [];

//   Future<void> scanBarcode() async {
//     String barcodeScanResult = await FlutterBarcodeScanner.scanBarcode(
//       '#FF0000',
//       'Cancelar',
//       true,
//       ScanMode.BARCODE,
//     );

//     if (!barcodeList.contains(barcodeScanResult)) {
//       setState(() {
//         barcodeList.add(barcodeScanResult);
//       });
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text('Código já lido.'),
//           duration: Duration(seconds: 2),
//           backgroundColor: Colors.red,
//         ),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Leitor de Códigos de Barras'),
//       ),
//       body: Center(
//         child: Container(
//           width: MediaQuery.of(context).size.width - 32.0,
//           color: Colors.grey[200],
//           padding: EdgeInsets.all(8.0),
//           child: Center(
//             child: Wrap(
//               spacing: 8.0,
//               runSpacing: 8.0,
//               children: barcodeList.map((barcode) {
//                 return Container(
//                   width: (MediaQuery.of(context).size.width - 48.0) / 4, // Divide em 4 colunas
//                   height: 100.0,
//                   color: Colors.white,
//                   alignment: Alignment.center,
//                   child: Text(barcode, style: TextStyle(fontWeight: FontWeight.bold,color: Colors.blue),),
//                 );
//               }).toList(),
//             ),
//           ),
//         ),
//       ),
//       floatingActionButton: FloatingActionButton.extended(
//         onPressed: scanBarcode,
//         label: Text('Escanear Código'),
//         icon: Icon(Icons.camera_alt),
//       ),
//       floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
//     );
//   }
// }


















// import 'package:flutter/material.dart';
// import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Leitor de Códigos de Barras',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: BarcodeScannerPage(),
//     );
//   }
// }

// class BarcodeScannerPage extends StatefulWidget {
//   @override
//   _BarcodeScannerPageState createState() => _BarcodeScannerPageState();
// }

// class _BarcodeScannerPageState extends State<BarcodeScannerPage> {
//   List<String> barcodeList = [];

//   Future<void> scanBarcode() async {
//     String barcodeScanResult = await FlutterBarcodeScanner.scanBarcode(
//       '#FF0000',
//       'Cancelar',
//       true,
//       ScanMode.BARCODE,
//     );

//     if (!barcodeList.contains(barcodeScanResult)) {
//       setState(() {
//         barcodeList.add(barcodeScanResult);
//       });
//     } else {
//       showDialog(
//         context: context,
//         builder: (context) => AlertDialog(
//           title: Text('Aviso'),
//           content: Text('Código já lido.'),
//           actions: [
//             TextButton(
//               onPressed: () => Navigator.pop(context),
//               child: Text('OK'),
//             ),
//           ],
//         ),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Leitor de Códigos de Barras'),
//       ),
//       body: Center(
//         child: Container(
//           width: MediaQuery.of(context).size.width - 32.0,
//           color: Colors.grey[200],
//           padding: EdgeInsets.all(8.0),
//           child: Center(
//             child: Wrap(
//               spacing: 8.0,
//               runSpacing: 8.0,
//               children: barcodeList.map((barcode) {
//                 return Container(
//                   width: (MediaQuery.of(context).size.width - 48.0) / 4, // Divide em 4 colunas
//                   height: 40.0,
//                   color: Colors.white,
//                   alignment: Alignment.center,
//                   child: Text(barcode, style: TextStyle(fontWeight: FontWeight.bold,color: Colors.blue),
//                   ),
//                 );
//               }).toList(),
//             ),
//           ),
//         ),
//       ),
//       floatingActionButton: FloatingActionButton.extended(
//         onPressed: scanBarcode,
//         label: Text('Escanear Código'),
//         icon: Icon(Icons.camera_alt),
//       ),
//       floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
//     );
//   }
// }
// Código com alerta dialog
































// import 'package:flutter/material.dart';
// import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Leitor de Códigos de Barras',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: BarcodeScannerPage(),
//     );
//   }
// }

// class BarcodeScannerPage extends StatefulWidget {
//   @override
//   _BarcodeScannerPageState createState() => _BarcodeScannerPageState();
// }

// class _BarcodeScannerPageState extends State<BarcodeScannerPage> {
//   List<String> barcodeList = [];

//   Future<void> scanBarcode() async {
//     String barcodeScanResult = await FlutterBarcodeScanner.scanBarcode(
//       '#FF0000',
//       'Cancelar',
//       true,
//       ScanMode.BARCODE,
//     );

//     setState(() {
//       barcodeList.add(barcodeScanResult);
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Leitor de Códigos de Barras'),
//       ),
//       body: Center(
//         child: Container(
//           width: MediaQuery.of(context).size.width - 32.0,
//           color: Colors.grey[200],
//           padding: EdgeInsets.all(8.0),
//           child: Center(
//             child: Wrap(
//               spacing: 8.0,
//               runSpacing: 8.0,
//               children: barcodeList.map((barcode) {
//                 return Container(
//                   width: (MediaQuery.of(context).size.width - 48.0) / 4, // Divide em 4 colunas
//                   height: 40.0,
//                   color: Colors.white,
//                   alignment: Alignment.center,
//                   child: Text(barcode, style:
//                   TextStyle(fontWeight: FontWeight.bold),),
                  
//                 );
//               }).toList(),
//             ),
//           ),
//         ),
//       ),
//       floatingActionButton: FloatingActionButton.extended(
//         onPressed: scanBarcode,
//         label: Text('Escanear Código'),
//         icon: Icon(Icons.camera_alt),
//       ),
//       floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
//     );
//   }
// }

















// import 'package:flutter/material.dart';
// import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Leitor de Códigos de Barras',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: BarcodeScannerPage(),
//     );
//   }
// }

// class BarcodeScannerPage extends StatefulWidget {
//   @override
//   _BarcodeScannerPageState createState() => _BarcodeScannerPageState();
// }

// class _BarcodeScannerPageState extends State<BarcodeScannerPage> {
//   List<String> barcodeList = [];

//   Future<void> scanBarcode() async {
//     String barcodeScanResult = await FlutterBarcodeScanner.scanBarcode(
//       '#FF0000',
//       'Cancelar',
//       true,
//       ScanMode.BARCODE,
//     );

//     setState(() {
//       barcodeList.add(barcodeScanResult);
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Leitor de Códigos de Barras'),
//       ),
//       body: Center(
//         child: Container(
//           width: MediaQuery.of(context).size.width - 32.0,
//           height: 200.0,
//           color: Colors.grey[200],
//           child: ListView.builder(
//             scrollDirection: Axis.horizontal,
//             itemCount: barcodeList.length,
//             itemBuilder: (context, index) {
//               return Container(
                
//                 width: 100.0,
//                 height: 100.0,
//                 margin: EdgeInsets.all(8.0),
//                 color: Colors.white,
//                 alignment: Alignment.center,
//                 child: Text(barcodeList[index],
//                 style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16,)
//                 ),
                
//               );
//             },
//           ),
//         ),
//       ),
//       floatingActionButton: FloatingActionButton.extended(
//         onPressed: scanBarcode,
//         label: Text('Escanear Código'),
//         icon: Icon(Icons.camera_alt),
//       ),
//       floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
//     );
//   }
// }













// import 'package:flutter/material.dart';
// import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Leitor de Códigos de Barras',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: BarcodeScannerPage(),
//     );
//   }
// }

// class BarcodeScannerPage extends StatefulWidget {
//   @override
//   _BarcodeScannerPageState createState() => _BarcodeScannerPageState();
// }

// class _BarcodeScannerPageState extends State<BarcodeScannerPage> {
//   List<String> barcodeList = [];

//   Future<void> scanBarcode() async {
//     String barcodeScanResult = await FlutterBarcodeScanner.scanBarcode(
//       '#FF0000',
//       'Cancelar',
//       true,
//       ScanMode.BARCODE,
//     );

//     setState(() {
//       barcodeList.add(barcodeScanResult);
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Leitor de Códigos de Barras'),
//       ),
//       body: Row(
//         children: [
//           SizedBox(width: 16.0),
//           for (int i = 0; i < barcodeList.length; i++)
//             Padding(
//               padding: EdgeInsets.symmetric(horizontal: 8.0),
//               child: Text(barcodeList[i]),
//             ),
//         ],
//       ),
//       floatingActionButton: FloatingActionButton.extended(
//         onPressed: scanBarcode,
//         label: Text('Escanear Código'),
//         icon: Icon(Icons.camera_alt),
//       ),
//       floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
//     );
//   }
// }


















// import 'package:flutter/material.dart';
// import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Leitor de Códigos de Barras',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: BarcodeScannerPage(),
//     );
//   }
// }

// class BarcodeScannerPage extends StatefulWidget {
//   @override
//   _BarcodeScannerPageState createState() => _BarcodeScannerPageState();
// }

// class _BarcodeScannerPageState extends State<BarcodeScannerPage> {
//   List<String> barcodeList = [];

//   Future<void> scanBarcode() async {
//     String barcodeScanResult = await FlutterBarcodeScanner.scanBarcode(
//       '#FF0000',
//       'Cancelar',
//       true,
//       ScanMode.BARCODE,
//     );

//     setState(() {
//       barcodeList.add(barcodeScanResult);
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Leitor de Códigos de Barras'),
//       ),
      
//       body: Column(
        
//         children: [
          
//           Expanded(
//             child: ListView.builder(
//               itemCount: barcodeList.length,
//               itemBuilder: (context, index) {
//                 return ListTile(
//                   title: Text(barcodeList[index]),
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//       floatingActionButton: FloatingActionButton.extended(
//         onPressed: scanBarcode,
//         label: Text('Escanear Código'),
//         icon: Icon(Icons.camera_alt),
//       ),
//       floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
//     );
//   }
// }
