import 'package:calculadoraimc/classes/imc.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const CalculadoraImc(title: 'Calculadora de IMC'),
    );
  }
}

class CalculadoraImc extends StatefulWidget {
  final String title;
  const CalculadoraImc({super.key, required this.title});

  @override
  State<CalculadoraImc> createState() => CalculadoraImcState();
}

class CalculadoraImcState extends State<CalculadoraImc> {
  Imc imc1 = Imc(1, 1);
  var alturaController = TextEditingController();
  var pesoController = TextEditingController();

  List<Imc> listaImcs = [];

  void adicionarNaListaImcs(Imc imcNovo) {
    listaImcs.add(imcNovo);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            showDialog(
                context: context,
                builder: (BuildContext bc) {
                  return AlertDialog(
                    title: const Text("Adicionar medidas"),
                    content: Wrap(
                      children: [
                        Container(
                            margin: const EdgeInsets.only(top: 8),
                            child: const Text("Peso (em kg)")),
                        TextField(
                            controller: pesoController,
                            maxLength: 3,
                            keyboardType: TextInputType.number),
                        Container(
                            margin: const EdgeInsets.only(top: 8),
                            child: const Text(
                              "Altura (em cm)",
                            )),
                        TextField(
                            controller: alturaController,
                            maxLength: 3,
                            keyboardType: TextInputType.number),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text("Cancelar")),
                            TextButton(
                              style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.green)),
                                onPressed: () {
                                  if (pesoController.text == "" ||
                                      alturaController.text == "") {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                            content: Text(
                                                "Preencha todos os campos!")));
                                    return;
                                  }
                                  listaImcs.add(Imc(
                                      double.parse(pesoController.text),
                                      double.parse(alturaController.text)));
                                  pesoController.text = "";
                                  alturaController.text = "";
                                  setState(() {});
                                  Navigator.pop(context);
                                },
                                child: const Text(
                                  "Enviar",
                                  style: TextStyle(color: Colors.white),
                                )),
                          ],
                        )
                      ],
                    ),
                  );
                });
          },
          child: const Icon(Icons.add)),
      body: Container(
        margin: const EdgeInsets.all(12),
        child: ListView(
          children: [
            Container(
                margin: const EdgeInsets.only(bottom: 12),
                child: const Text(
                    "IMC é a sigla para Índice de Massa Corpórea, parâmetro adotado pela Organização Mundial de Saúde para calcular o peso ideal de cada pessoa.")),
            DataTable(
              dataRowHeight: 35,
              headingRowHeight: 35,
              border: TableBorder.all(width: 2),
              columns: const [
                DataColumn(label: Text("Peso")),
                DataColumn(label: Text("Altura")),
                DataColumn(label: Text("IMC")),
              ],
              rows: listaImcs
                  .map((item) => DataRow(
                        cells: [
                          DataCell(Text(item.getPeso().toString())),
                          DataCell(Text(item.getAltura().toString())),
                          DataCell(Text(item.calcularImc().toString())),
                        ],
                      ))
                  .toList(),
            )
          ],
        ),
      ),
    );
  }
}
