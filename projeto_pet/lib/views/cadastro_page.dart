import 'package:flutter/material.dart';
import '../controllers/auth_controller.dart'; // Controlador de autenticação
import '../models/user.dart'; // Modelo de usuário

class CadastroPage extends StatefulWidget {
  const CadastroPage({super.key});

  @override
  _CadastroPageState createState() => _CadastroPageState();
}

class _CadastroPageState extends State<CadastroPage> {
  final _nomeController = TextEditingController();
  final _emailController = TextEditingController();
  final _cpfController = TextEditingController();
  final _contatoController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool _isValidEmail(String email) => email.contains('@');
  bool _isValidNome(String nome) =>
      !RegExp(r'[0-9!@#$%^&*(),.?":{}|<>]').hasMatch(nome);
  bool _isValidCPF(String cpf) => RegExp(r'^[0-9]+$').hasMatch(cpf);
  bool _isValidContato(String contato) => RegExp(r'^[0-9]+$').hasMatch(contato);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAF8EF),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const SizedBox(height: 40),
                Center(
                  child: Image.asset(
                    'assets/images/pet_amigo_logo.png',
                    height: 100,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'PET AMIGO',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.orange,
                  ),
                ),
                const SizedBox(height: 20),
                _buildTextField('NOME', _nomeController, _isValidNome,
                    'Nome inválido!'),
                const SizedBox(height: 15),
                _buildTextField('E-MAIL', _emailController, _isValidEmail,
                    'E-mail inválido!'),
                const SizedBox(height: 15),
                _buildTextField('CPF', _cpfController, _isValidCPF,
                    'CPF deve conter apenas números'),
                const SizedBox(height: 15),
                _buildTextField('CONTATO', _contatoController, _isValidContato,
                    'Contato inválido!'),
                const SizedBox(height: 30),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFB2F77C),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                 onPressed: () async {
  if (_formKey.currentState?.validate() ?? false) {
    final nome = _nomeController.text.trim();
    final email = _emailController.text.trim();
    final cpf = _cpfController.text.trim();
    final telefone = _contatoController.text.trim();
    final senha = '12345'; // Alterar para entrada do usuário se necessário

    // Chama o método de registro
    final error = await AuthController().registerUser(
      nome: nome,
      email: email,
      senha: senha,
      cpf: cpf,
      telefone: telefone,
    );

    if (error == null) {
      // Sucesso: Navega para a tela de login ou home
      Navigator.pushNamed(context, '/home');
    } else {
      // Exibe mensagem de erro
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(error)),
      );
    }
  }
}
,
                  child: const Text(
                    'ADOTAR!',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'ADOTANDO SEU AMIGO!',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String hint, TextEditingController controller,
      bool Function(String) validator, String errorMessage) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.white),
        filled: true,
        fillColor: Colors.orange,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide.none,
        ),
        contentPadding:
            const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return '$hint é obrigatório';
        }
        if (!validator(value)) {
          return errorMessage;
        }
        return null;
      },
    );
  }
}
