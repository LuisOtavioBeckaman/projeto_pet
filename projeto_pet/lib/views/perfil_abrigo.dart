import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:projeto_pet/models/abrigo.dart';

class AbrigoPerfil extends StatefulWidget {
  final String abrigoId;

  const AbrigoPerfil({super.key, required this.abrigoId});

  @override
  AbrigoPerfilState createState() => AbrigoPerfilState();
}

class AbrigoPerfilState extends State<AbrigoPerfil> {
  late Future<Abrigo> futuroAbrigo;

  @override
  void initState() {
    super.initState();
    futuroAbrigo = obterAbrigoPorId(widget.abrigoId);
  }

  Future<Abrigo> obterAbrigoPorId(String id) async {
    DocumentSnapshot doc =
        await FirebaseFirestore.instance.collection('abrigos').doc(id).get();
    if (doc.exists) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      return Abrigo.fromJson(doc.id, data);
    } else {
      throw Exception('Abrigo não encontrado');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Perfil do Abrigo'),
      ),
      body: FutureBuilder<Abrigo>(
        future: futuroAbrigo,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(
                child: Text('Erro ao carregar dados do abrigo'));
          } else if (!snapshot.hasData) {
            return const Center(child: Text('Abrigo não encontrado'));
          } else {
            Abrigo abrigo = snapshot.data!;
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    abrigo.nome,
                    style: const TextStyle(
                        fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8.0),
                  Text('Contato: ${abrigo.contato}'),
                  const SizedBox(height: 8.0),
                  Text('Localização: ${abrigo.localizacao}'),
                  const SizedBox(height: 16.0),
                  const Text(
                    'Descrição',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text(abrigo.descricao),
                  const SizedBox(height: 16.0),
                  const Text(
                    'Eventos de Adoção',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: abrigo.eventos.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          leading: const Icon(Icons.event),
                          title: Text(abrigo.eventos[index]),
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
