import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ContractForm extends StatefulWidget {
  @override
  _ContractFormState createState() => _ContractFormState();
}

class _ContractFormState extends State<ContractForm> {
  String customerName = '';
  DateTime? servicesDate;
  String description = '';
  String customerRepresentative = '';
  String customerRepresentativePhone = '';
  String customerRepresentativeSign = '';
  String maintenanceUser = '';
  String location = '';


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
        title: Text('Taahhüt'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [

              GestureDetector(
                onTap: () => _selectDate(context),
                child: AbsorbPointer(
                  child: TextField(
                    decoration: InputDecoration(labelText: 'Tarih'),
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
                decoration: InputDecoration(labelText: 'Müşteri Adı'),
                onChanged: (value) {
                  customerName = value;
                },
              ),
              SizedBox(height: 16),
              TextField(
                decoration: InputDecoration(labelText: 'Yapılan İş Ve Özel Hususlar'),
                onChanged: (value) {
                  description = value;
                },
              ),
              SizedBox(height: 16),
              TextField(
                decoration: InputDecoration(labelText: 'Müşteri & Müşteri Vekili Ad Soyad'),
                onChanged: (value) {
                  customerRepresentative = value;
                },
              ),
              SizedBox(height: 16),
              TextField(
                decoration:
                InputDecoration(labelText: 'Müşteri & Müşteri Vekili Telefon Numarası'),
                onChanged: (value) {
                  customerRepresentativePhone = value;
                },
              ),
              SizedBox(height: 16),
              TextField(
                decoration:
                InputDecoration(labelText: 'Müşteri & Müşteri Vekili İmzası'),
                onChanged: (value) {
                  customerRepresentativeSign = value;
                },
              ),
              SizedBox(height: 16),

              TextField(
                decoration: InputDecoration(labelText: 'Montaj Yapan Pekcan Temsilcisi'),
                onChanged: (value) {
                  maintenanceUser = value;
                },
              ),
              SizedBox(height: 16),
              TextField(
                decoration: InputDecoration(labelText: 'İşlem Yapılan Yerin Konumu'),
                onChanged: (value) {
                  location = value;
                },
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
