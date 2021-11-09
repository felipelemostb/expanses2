import 'package:flutter/material.dart';
import '../models/transaction.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  //DEFININDO QUE TRANSACTIONS SERA DO TIPO LIST
  final List<Transaction> transactions;

  TransactionList(this.transactions);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 500,
      //LISTVIEWBUILDER FAZ COM QUE OS DADOS DA LISTA NAO SEJAM CARREGADOS
      //TO-DO DE UMA UNICA VEZ
      child: transactions.isEmpty
          ? Column(
              children: <Widget>[
                Center(
                  child: Text('Nenhuma transacao cadastrada',
                      style: Theme.of(context).textTheme.headline6),
                ),
                SizedBox(
                  height: 200,
                ),
                Container(
                  height: 200,
                  child: Image.asset(
                    'assets/images/waiting.png',
                    fit: BoxFit.cover,
                  ),
                )
              ],
            )
          : ListView.builder(
              itemCount: transactions.length,
              //O LIST VIEW PEDE UM CONTEXTO E UM INDEX QUE SAO DEFINIDOS PELOS ITENS DA LISTA
              itemBuilder: (ctx, index) {
                final tr = transactions[index];
                return Card(
                  elevation: 5,
                  margin: EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 5,
                  ),
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 30,
                      child: Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: FittedBox(
                          child: Text('${tr.value}'),
                        ),
                      ),
                    ),
                    title: Text(
                      tr.title,
                      style: Theme.of(context).textTheme.title,
                    ),
                    subtitle: Text(
                      DateFormat('d MMM y').format(tr.date),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
