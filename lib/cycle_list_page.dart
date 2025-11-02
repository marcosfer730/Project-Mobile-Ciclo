import 'package:flutter/material.dart';

class CycleListPage extends StatefulWidget {
  @override
  _CycleListPageState createState() => _CycleListPageState();
}

class _CycleListPageState extends State<CycleListPage> {
  // Lista local de ciclos (depois conectamos ao Firebase)
  List<Map<String, dynamic>> cycles = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Meus ciclos"),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () async {
          final result = await Navigator.pushNamed(context, "/addCycle");

          if (result != null) {
            setState(() {
              cycles.add(result as Map<String, dynamic>);
            });
          }
        },
      ),
      body: cycles.isEmpty
          ? Center(
              child: Text(
                "Nenhum ciclo registrado ainda",
                style: TextStyle(fontSize: 16),
              ),
            )
          : ListView.builder(
              itemCount: cycles.length,
              itemBuilder: (context, index) {
                final cycle = cycles[index];

                return Card(
                  child: ListTile(
                    title: Text(
                      "${cycle['start']} ➜ ${cycle['end']}",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      "Humor: ${cycle['mood']}\n"
                      "Sintomas: ${cycle['symptoms']}\n"
                      "Secreção: ${cycle['secretion']}",
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        setState(() {
                          cycles.removeAt(index);
                        });
                      },
                    ),
                  ),
                );
              },
            ),
    );
  }
}
