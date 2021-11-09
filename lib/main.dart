import 'package:expanses/components/chart.dart';
import 'package:expanses/components/transaction_form.dart';
import 'package:expanses/models/transaction.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'package:expanses/models/transaction.dart';
import '/components/transaction_form.dart';
import '/components/transaction_list.dart';

main() => runApp(ExpensesApp());

class ExpensesApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
      theme: ThemeData(
          primarySwatch: Colors.purple,
          fontFamily: 'Quicksand',
          appBarTheme: AppBarTheme(
              textTheme: ThemeData.light().textTheme.copyWith(
                  // ignore: deprecated_member_use
                  title: TextStyle(
                      fontFamily: 'OpenSants',
                      fontSize: 20,
                      fontWeight: FontWeight.w400)))),
    );
  }
}

//pagina em statefull com estado
class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

//Modelo com as transacoes fixas
class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _transactions = [
    Transaction(
        id: 't0',
        title: 'Supermercado',
        value: 400.00,
        date: DateTime.now().subtract(Duration(days: 1))),
    Transaction(
        id: 't1',
        title: 'Aluguel',
        value: 910.76,
        date: DateTime.now().subtract(Duration(days: 3))),
    Transaction(
        id: 't2',
        title: 'Internet',
        value: 80.30,
        date: DateTime.now().subtract(Duration(days: 4))),
    Transaction(
        id: 't3',
        title: 'Extras',
        value: 40.10,
        date: DateTime.now().subtract(Duration(days: 1))),
    Transaction(
      id: 't4',
      title: 'Sushi',
      value: 100.00,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't5',
      title: 'Estudos',
      value: 200.00,
      date: DateTime.now(),
    ),
  ];

  List<Transaction> get _recentTransactions {
    return _transactions.where((tr) {
      return tr.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

//controle de adiocao de transacoes
//necessida de um texto title e um valor double
  _addTransaction(String title, double value) {
    final newTransaction = Transaction(
      id: Random().nextDouble().toString(),
      title: title,
      value: value,
      date: DateTime.now(),
    );

//sempre que adicionado uma transacao o setstate
//altera o estado colocando um .add e invocando a nova transacao nos
//modelos pre definidos como transactions
    setState(
      () {
        _transactions.add(newTransaction);
      },
    );
    Navigator.of(context).pop();
  }

//modal utilizado para abrir o formulario apenas quando for
//adicionar uma nova transacao
//transactionform possui as regras de formulario
  _openTransactionFormModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        //O TRANSACTION FORMA EH INVOCADO CONFORME PARAMETROS DEFINIDOS
        //COM A FUNCAO DE ADICIONAR UMA TRANSACAO
        return TransactionForm(_addTransaction);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.purple,
          title: Center(
            child: Text(
              'Suas despesas - Ultimos 7 dias',
              style: TextStyle(
                fontFamily: 'OpenSans',
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          //BOTAO DE ACTION COM ABERTURA DE MODAL NO ONPRESSED
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.menu),
              onPressed: () => _openTransactionFormModal(context),
            ),
          ],
        ),

        //SCROLLVIEW PARA NAO DAR ERRO DE OVERFLOW E POSSIBILITAR
        //QUE SEJA FEITO O SCROLL
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                width: double.infinity,
                child: Chart(
                  _recentTransactions,
                ),
              ),

              //AQUI A LISTA DE TRANSACOES COM TODOS PARAMETROS
              //E MODELOS PRE DEFINIDOS, APENAS IMPORTADO E INVOCADO
              TransactionList(_transactions),
            ],
          ),
        ),

        //BOTAO COM A MESMA FUNCAO DO ANTERIOR, ABRIR O MODAL
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.purple.shade500,
          child: Icon(Icons.add),
          onPressed: () => _openTransactionFormModal(context),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat);
  }
}
