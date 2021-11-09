import 'package:flutter/material.dart';

class TransactionForm extends StatefulWidget {
  //ON SUBMIT ESPERA RECEBER OS PARAMETROS DA LISTA DE TEXTO E VALOR
  final void Function(String, double) onSubmit;

  TransactionForm(this.onSubmit);

  @override
  _TransactionFormState createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  //CONTROLADOR DE TEXTO
  final titleController = TextEditingController();

  //CONTROLADOR DE VALORES
  final valueController = TextEditingController();

  //O SUBMIT FORMA EH A FORMA QUE O FORMULARIO DEVE SER PREENCHIDO
  //ELE EXPERA RECEBER O TITLE E O VALUE, CASO SEJAM NULOS ELE RETORNA PARA O PREENCHIMENTO
  //APOS PREENCHER ELE ADICIONA A LISTA COM O METODO onSUBMIT
  _submitForm() {
    final title = titleController.text;
    final value = double.tryParse(valueController.text) ?? 0.0;

    if (title.isEmpty || value <= 0) {
      return;
    }
    //acessa as funcoes que foram definidas por parametro na linha 5 e 7
    widget.onSubmit(title, value);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            TextField(
              onSubmitted: (_) => _submitForm(),
              controller: titleController,
              decoration: InputDecoration(
                labelText: 'Título',
              ),
            ),
            TextField(
              controller: valueController,
              //DEFININDO APENAS TECLADO NUMERICO PARA O CAMPO DE VALORES
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              //DEFININDO QUE AO PREENCHIDO ELE VAI SUBMETER
              onSubmitted: (value) => _submitForm(),
              decoration: InputDecoration(
                labelText: 'Valor (R\$)',
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                TextButton(
                  child: Text(
                    'Nova Transação',
                    style: TextStyle(color: Colors.purple),
                  ),
                  //DEFININDO QUE AO PREENCHIDO ELE VAI SUBMETER
                  onPressed: _submitForm,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
