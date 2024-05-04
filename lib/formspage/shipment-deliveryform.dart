import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ShipmentAndDeliveryForm extends StatefulWidget {
  @override
  _ShipmentAndDeliveryFormState createState() => _ShipmentAndDeliveryFormState();
}

class _ShipmentAndDeliveryFormState extends State<ShipmentAndDeliveryForm> {
  String customerName = '';
  DateTime? shipmentDate;
  String location = '';
  String representative = '';
  String waybillNumber = '';
  String status = '';
  String photo = '';
  String additionalPhoto = '';
  File? selectedImage;

  List<Map<String, dynamic>> items = [
    {'name': 'Evet', 'value': 0},
    {'name': 'Hayır', 'value': 1},
    // {'name': 'Seçenek 3', 'value': 2}
  ];

  Future<void> _getImage() async {
    final pickedFile =
    await ImagePicker().getImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        selectedImage = File(pickedFile.path);
        photo = pickedFile.path;
      } else {
        print('Seçili Fotoğraf Yok.');
      }
    });
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null) {
      setState(() {
        shipmentDate = pickedDate;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sevkiyat-Teslim Formu'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                decoration: InputDecoration(labelText: 'Müşteri Adı'),
                onChanged: (value) {
                  customerName = value;
                },
              ),
              SizedBox(height: 16),
              GestureDetector(
                onTap: () => _selectDate(context),
                child: AbsorbPointer(
                  child: TextField(
                    decoration: InputDecoration(labelText: 'Sevk Edildiği Tarih'),
                    controller: TextEditingController(
                      text: shipmentDate != null
                          ? '${shipmentDate!.day}/${shipmentDate!.month}/${shipmentDate!.year}'
                          : '',
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16),
              TextField(
                decoration: InputDecoration(labelText: 'Sevk Konumu'),
                onChanged: (value) {
                  location = value;
                },
              ),
              SizedBox(height: 16),
              TextField(
                decoration: InputDecoration(labelText: 'Sevk Eden Pekcan Temsilcisi'),
                onChanged: (value) {
                  representative = value;
                },
              ),
              SizedBox(height: 16),
              TextField(
                decoration:
                InputDecoration(labelText: 'Fatura İrsaliye No'),
                onChanged: (value) {
                  waybillNumber = value;
                },
              ),
              SizedBox(height: 16),
              DropdownButtonFormField(
                value: status,
                items: items.map((dynamic data) {
                  return DropdownMenuItem<String>(
                    value: data['value'].toString(),
                    child: Text(data['name']),
                  );
                }).toList()
                  ..insert(
                      0, DropdownMenuItem<String>(value: '', child: Text(''))),
                onChanged: (value) {
                  setState(() {
                    status = value.toString();
                  });
                },
                decoration: InputDecoration(labelText: 'Ürün Telim Edildi Mi?'),
              ),
              SizedBox(height: 16),

              ElevatedButton(
                onPressed: _getImage,
                child: Text('Ek Fotoğraf'),
              ),
              if (selectedImage != null)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Image.file(
                    selectedImage!,
                    height: 200,
                  ),
                ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  // Kaydet butonuna basıldığında yapılacak işlemler
                  // Burada verileri bir şekilde kaydetmeli veya göndermeli
                  // Örneğin bir API'ye gönderme gibi
                },
                child: Text('Kaydet'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
