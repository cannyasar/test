import 'package:deneme/formspage/serviceform.dart';
import 'package:deneme/formspage/shipment-deliveryform.dart';
import 'package:flutter/material.dart';

import 'contractForm.dart';
import 'maintenanceform.dart';

class FormsPage extends StatefulWidget {
  @override
  _FormsPageState createState() => _FormsPageState();
}

class _FormsPageState extends State<FormsPage> {
  TextEditingController _searchController = TextEditingController();
  String _searchText = '';

  // List<String> itemNames = ['Taahüt', 'Servis' ,'Bakım' , 'Sevkiyat - Teslim' , 'Pazarlama']; // List Title
  List<Map<String, dynamic>> items = [
    {'name': 'Taahüt' , 'subName' : 'Montaj' , 'icon': Icons.build_outlined , 'value': 0},
    {'name': 'Servis' , 'subName' : 'Pekcan Havuz' , 'icon': Icons.construction_outlined , 'value': 1},
    {'name': 'Bakım' , 'subName' : 'Pekcan Havuz' , 'icon': Icons.support , 'value': 2},
    {'name': 'Sevkiyat - Teslim' , 'subName' : 'Depo' , 'icon': Icons.local_shipping , 'value': 3},
    {'name': 'Pazarlama' , 'subName' : 'Pazarlama' , 'icon': Icons.public , 'value': 4}
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              onChanged: (value) {
                setState(() {
                  _searchText = value;
                });
              },
              decoration: InputDecoration(
                labelText: 'Filtreleme',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: items.length,
              itemBuilder: (BuildContext context, int index) {
                // Arama metni boşsa veya öğe isim veya alt isiminde arama metni içeriyorsa göster
                if (_searchText.isEmpty ||
                    items[index]['name'].toLowerCase().contains(_searchText.toLowerCase()) ||
                    items[index]['subName'].toString().toLowerCase().contains(_searchText.toLowerCase())) {
                  return ListTile(
                    leading: Icon(items[index]['icon']),
                    title: Text(items[index]['name']),
                    subtitle: Text(items[index]['subName']), // Alt isimlerin virgülle birleştirilmiş hali
                    trailing: Icon(Icons.arrow_forward_ios), // Ok işareti
                    onTap: () {
                      _handleTap(items[index]['value']);
                    },
                  );
                } else {
                  // Arama metni bulunmuyorsa boş bir Container döndür
                  return Container();
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  void _handleTap(int itemName) {
    switch (itemName) {
      case 0:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ContractForm()),
        );
        break;
      case 1:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ServisForm()),
        );
        break;
      case 2:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => MaintenanceForm()),
        );
        break;
      case 3:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ShipmentAndDeliveryForm()),
        );
        break;
      case 4:
        print('Pazarlama');
        break;

      default:
        print('Bilinmeyen öğeye tıklandı');
    }
  }

  @override
  void dispose() {
    // Sayfa kapatıldığında controller'ı temizle
    _searchController.dispose();
    super.dispose();
  }
}
