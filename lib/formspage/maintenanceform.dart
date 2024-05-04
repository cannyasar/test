import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class MaintenanceForm extends StatefulWidget {
  @override
  _MaintenanceFormState createState() => _MaintenanceFormState();
}

class _MaintenanceFormState extends State<MaintenanceForm> {
  String customerName = '';
  DateTime? servicesDate;
  String location = '';
  String maintenanceUser = '';
  String maintenanceRecord = '';
  String clorValue = '';
  String phValue = '';
  String photo = '';
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
        print('No image selected.');
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
        servicesDate = pickedDate;
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
                    decoration: InputDecoration(labelText: 'Servis Tarihi'),
                    controller: TextEditingController(
                      text: servicesDate != null
                          ? '${servicesDate!.day}/${servicesDate!.month}/${servicesDate!.year}'
                          : '',
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16),
              TextField(
                decoration: InputDecoration(labelText: 'Konumu'),
                onChanged: (value) {
                  location = value;
                },
              ),
              SizedBox(height: 16),
              TextField(
                decoration: InputDecoration(labelText: 'Bakım Yapan Pekcan Temsilcisi'),
                onChanged: (value) {
                  location = value;
                },
              ),
              SizedBox(height: 16),
              TextField(
                decoration:
                InputDecoration(labelText: 'Bakımda Neler Yapıldı?'),
                onChanged: (value) {
                  maintenanceUser = value;
                },
              ),
              SizedBox(height: 16),

              TextField(
                decoration: InputDecoration(labelText: 'Havuzun KLOR Değeri'),
                onChanged: (value) {
                  clorValue = value;
                },
              ),
              SizedBox(height: 16),
              TextField(
                decoration: InputDecoration(labelText: 'Havuzun PH Değeri'),
                onChanged: (value) {
                  phValue = value;
                },
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: _getImage,
                child: Text('Bakım Yapılan Havuzun Resmi'),
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
                  // Actions to be taken when pressing the Save button
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
