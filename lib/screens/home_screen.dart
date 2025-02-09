import 'package:flutter/material.dart';
import 'package:replicamoteis/widgets/filtro_widget.dart';
import '../models/motel.dart';
import '../service/motel_service.dart';
import '../widgets/app_bar_custom.dart';
import '../widgets/motel_highlight_card.dart';
import '../widgets/motel_card.dart';

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
      backgroundColor: Colors.white,
      appBar: CustomAppBar(),
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

          return Column(
            children: [
              MotelHighlightCard(motel: moteis.first),
              FiltersBar(),
              Expanded(
                child: ListView.builder(
                  itemCount: moteis.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        MotelCard(motel: moteis[index]),
                        SizedBox(height: 10),
                      ],
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }

}
