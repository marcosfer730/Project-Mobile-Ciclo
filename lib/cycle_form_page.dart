import 'package:flutter/material.dart';

class CycleFormPage extends StatefulWidget {
  @override
  // ignore: library_private_types_in_public_api
  _CycleFormPageState createState() => _CycleFormPageState();
}

class _CycleFormPageState extends State<CycleFormPage> {
  DateTime? startDate;
  DateTime? endDate;

  final TextEditingController symptomsController = TextEditingController();
  final TextEditingController moodController = TextEditingController();
  final TextEditingController secretionController = TextEditingController();

  Future<void> pickDate(bool isStart) async {
    final DateTime? date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );

    if (date != null) {
      setState(() {
        if (isStart) {
          startDate = date;
        } else {
          endDate = date;
        }
      });
    }
  }

  void saveCycle() {
    if (startDate == null || endDate == null) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Selecione as datas!")));
      return;
    }

    Navigator.pop(context, {
    "start": "${startDate!.day}/${startDate!.month}/${startDate!.year}",
    "end": "${endDate!.day}/${endDate!.month}/${endDate!.year}",
    "symptoms": symptomsController.text,
    "mood": moodController.text,
    "secretion": secretionController.text,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Registrar ciclo")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Data início
              ListTile(
                title: Text(
                  startDate == null
                      ? "Selecione a data de início"
                      : "Início: ${startDate!.day}/${startDate!.month}/${startDate!.year}",
                ),
                trailing: Icon(Icons.calendar_today),
                onTap: () => pickDate(true),
              ),

              // Data fim
              ListTile(
                title: Text(
                  endDate == null
                      ? "Selecione a data de fim"
                      : "Fim: ${endDate!.day}/${endDate!.month}/${endDate!.year}",
                ),
                trailing: Icon(Icons.calendar_today),
                onTap: () => pickDate(false),
              ),

              TextField(
                controller: symptomsController,
                decoration: InputDecoration(labelText: "Sintomas"),
              ),

              TextField(
                controller: moodController,
                decoration: InputDecoration(labelText: "Humor"),
              ),

              TextField(
                controller: secretionController,
                decoration: InputDecoration(labelText: "Secreção"),
              ),

              SizedBox(height: 20),

              ElevatedButton(
                onPressed: saveCycle,
                child: Text("Salvar ciclo"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
