import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

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

  Future<void> scanBarcode() async {
    String barcodeScanResult = await FlutterBarcodeScanner.scanBarcode(
      '#FF0000',
      'Cancelar',
      true,
      ScanMode.BARCODE,
    );

    setState(() {
      barcodeList.add(barcodeScanResult);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Leitor de Códigos de Barras'),
      ),
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width - 32.0,
          height: 200.0,
          color: Colors.grey[200],
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: barcodeList.length,
            itemBuilder: (context, index) {
              return Container(
                
                width: 100.0,
                height: 100.0,
                margin: EdgeInsets.all(8.0),
                color: Colors.white,
                alignment: Alignment.center,
                child: Text(barcodeList[index],
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16,)
                ),
                
              );
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: scanBarcode,
        label: Text('Escanear Código'),
        icon: Icon(Icons.camera_alt),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}













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
