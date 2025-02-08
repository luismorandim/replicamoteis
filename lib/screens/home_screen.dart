import 'package:flutter/material.dart';
import '../models/motel.dart';
import '../service/motel_service.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<Motel>> _futureMoteis;

  @override
  void initState() {
    super.initState();
    _futureMoteis = MotelService().fetchMoteis();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Motéis Disponíveis")),
      body: FutureBuilder<List<Motel>>(
        future: _futureMoteis,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text("Erro ao carregar os motéis"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("Nenhum motel disponível"));
          }

          List<Motel> moteis = snapshot.data!;

          return ListView.builder(
            itemCount: moteis.length,
            itemBuilder: (context, index) {
              final motel = moteis[index];

              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: ExpansionTile(
                  leading: Image.network(motel.logo, width: 50, height: 50, fit: BoxFit.cover),
                  title: Text(motel.fantasia, style: const TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(motel.bairro),
                      Text("Distância: ${motel.distancia} km"),
                      Text("Avaliação: ${motel.media} ⭐"),
                    ],
                  ),
                  children: motel.suites.map((suite) {
                    return ListTile(
                      title: Text(suite.nome, style: const TextStyle(fontWeight: FontWeight.bold)),
                      subtitle: Text("Disponíveis: ${suite.qtd}"),
                      trailing: Icon(Icons.hotel),
                      onTap: () {
                      },
                    );
                  }).toList(),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
