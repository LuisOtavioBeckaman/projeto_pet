import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:projeto_pet/models/visita.dart';

class VisitasView extends StatelessWidget {
  final TextEditingController _nameController = TextEditingController();
  final String petId;
  final String abrigoId;

  VisitasView({super.key, required this.petId, required this.abrigoId});

  Future<void> _scheduleVisit(BuildContext context) async {
    String nomeVisitante = _nameController.text;
    DateTime dataVisita = DateTime.now().add(
        const Duration(days: 1)); // Simulação para agendar para o próximo dia
    Visita visita = Visita(
      id: '', // O ID será gerado pelo Firestore
      petId: petId,
      abrigoId: abrigoId,
      dataVisita: dataVisita,
      nomeVisitante: nomeVisitante,
    );

    try {
      // Chama o método para agendar a visita no Firestore
      await FirebaseFirestore.instance.collection('visitas').add({
        'petId': visita.petId,
        'abrigoId': visita.abrigoId,
        'dataVisita': visita.dataVisita,
        'nomeVisitante': visita.nomeVisitante,
      });

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Visita agendada com sucesso')),
        );
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Erro ao agendar visita')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Agendar Visita'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Nome do Visitante', style: TextStyle(fontSize: 18)),
            TextField(controller: _nameController),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () => _scheduleVisit(context),
              child: const Text('Agendar Visita'),
            ),
          ],
        ),
      ),
    );
  }
}
