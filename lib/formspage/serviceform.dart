import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ServisForm extends StatefulWidget {
  @override
  _ServisFormState createState() => _ServisFormState();
}

class _ServisFormState extends State<ServisForm> {
  String customerName = '';
  DateTime? serviceDate;
  String defect = '';
  String location = '';
  String observationReport = '';
  String status = '';
  String cusotmerSign = '';
  String photo = '';
  String additionalPhoto = '';
  File? selectedImage;

  List<Map<String, dynamic>> items = [
    {'name': 'Seçenek 1', 'value': 0},
    {'name': 'Seçenek 2', 'value': 1},
    {'name': 'Seçenek 3', 'value': 2}
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
        serviceDate = pickedDate;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Servis Formu'),
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
                      text: serviceDate != null
                          ? '${serviceDate!.day}/${serviceDate!.month}/${serviceDate!.year}'
                          : '',
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16),
              TextField(
                decoration: InputDecoration(labelText: 'Arıza'),
                onChanged: (value) {
                  defect = value;
                },
              ),
              SizedBox(height: 16),
              TextField(
                decoration: InputDecoration(labelText: 'Konum'),
                onChanged: (value) {
                  location = value;
                },
              ),
              SizedBox(height: 16),
              TextField(
                decoration:
                InputDecoration(labelText: 'Temsilci Gözlem Raporu'),
                onChanged: (value) {
                  observationReport = value;
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
                decoration: InputDecoration(labelText: 'Durum'),
              ),
              SizedBox(height: 16),
              TextField(
                decoration: InputDecoration(labelText: 'Müşteri İmza'),
                onChanged: (value) {
                  cusotmerSign = value;
                },
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: _getImage,
                child: Text('İşlem Yapılan Yerin Fotoğrafı Seç'),
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
