import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionForm extends StatefulWidget {
  //ON SUBMIT ESPERA RECEBER OS PARAMETROS DA LISTA DE TEXTO E VALOR
  final void Function(String, double, DateTime) onSubmit;

  TransactionForm(this.onSubmit);

  @override
  _TransactionFormState createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  //CONTROLADOR DE TEXTO
  final _titleController = TextEditingController();

  //CONTROLADOR DE VALORES
  final _valueController = TextEditingController();

  DateTime _selectedDate = DateTime.now();
  
  //O SUBMIT FORMA EH A FORMA QUE O FORMULARIO DEVE SER PREENCHIDO
  //ELE EXPERA RECEBER O TITLE E O VALUE, CASO SEJAM NULOS ELE RETORNA PARA O PREENCHIMENTO
  //APOS PREENCHER ELE ADICIONA A LISTA COM O METODO onSUBMIT
  _submitForm() {
    final title = _titleController.text;
    final value = double.tryParse(_valueController.text) ?? 0.0;

    if (title.isEmpty || value <= 0 || _selectedDate == null ) {
      return;
    }
    //acessa as funcoes que foram definidas por parametro na linha 5 e 7
    widget.onSubmit(title, value, _selectedDate);
  }

  _showDatePicker(){
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    ).then((pickedDate){
      if(pickedDate ==null){
        return;
      }
      setState(() {
         _selectedDate = pickedDate;
      });
     
    });
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
              controller: _titleController,
              decoration: InputDecoration(
                labelText: 'Título',
              ),
            ),
            TextField(
              controller: _valueController,
              //DEFININDO APENAS TECLADO NUMERICO PARA O CAMPO DE VALORES
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              //DEFININDO QUE AO PREENCHIDO ELE VAI SUBMETER
              onSubmitted: (value) => _submitForm(),
              decoration: InputDecoration(
                labelText: 'Valor (R\$)',
              ),
            ),
            Container(
              height: 70,
              child: Row(children: <Widget>[
                Expanded(
                  child: Text(
                    _selectedDate == null ?  'Nenhuma Data!': 'Data ${DateFormat('d/M/y').format(_selectedDate,)}'),
                ),
               
                TextButton(
                 child: Text("Selecionar data",
                 style: TextStyle(
                   color: Colors.purple,
                   fontWeight: FontWeight.bold,
                   fontSize: 16
                 ),
                 ),
                onPressed:_showDatePicker
                ,
                 ),
              ],),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                ElevatedButton(
                  child: Text(
                    'Nova Transação',
                    style: TextStyle(color: Colors.white),
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
