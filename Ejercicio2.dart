
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeView(),
    );
  }
}

// ====================================
// MODEL
// ====================================

class Perfil {
  final String nombre;
  final String bio;
  final Color color;

  Perfil({
    required this.nombre,
    required this.bio,
    required this.color,
  });
}

// ====================================
// VIEWMODEL
// ====================================

class PerfilViewModel extends ChangeNotifier {

  // Datos guardados del perfil
  Perfil perfil = Perfil(
    nombre: '',
    bio: '',
    color: Colors.indigo,
  );

  // Color seleccionado actualmente
  Color colorSeleccionado = Colors.indigo;

  // Cambiar el color de la interfaz
  void seleccionarColor(Color nuevoColor) {
    colorSeleccionado = nuevoColor;
    notifyListeners();
  }

  // Guardar el perfil
  void guardarPerfil(String nombre, String bio) {
    perfil = Perfil(
      nombre: nombre.trim(),
      bio: bio.trim(),
      color: colorSeleccionado,
    );

    notifyListeners();
  }

  // Obtener la inicial del nombre guardado
  String get inicial {
    if (perfil.nombre.isEmpty) {
      return '?';
    }

    return perfil.nombre[0].toUpperCase();
  }
}

// ====================================
// VIEW
// ====================================

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {

  final PerfilViewModel viewModel = PerfilViewModel();

  final TextEditingController nombreController =
  TextEditingController(text: '');

  final TextEditingController bioController =
  TextEditingController(
    text: 'algún texto descriptivo largo',
  );

  final List<Color> colores = [
    Colors.indigo,
    Colors.teal,
    Colors.deepOrange,
    Colors.purple,
    Colors.pink,
  ];

  @override
  void dispose() {
    nombreController.dispose();
    bioController.dispose();
    viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: viewModel,
      builder: (context, child) {

        return Scaffold(
          backgroundColor: const Color(0xFFFFF7FF),

          // APPBAR
          appBar: AppBar(
            title: const Text('Editar perfil'),
            centerTitle: true,
            backgroundColor: viewModel.colorSeleccionado,
            foregroundColor: Colors.white,
          ),

          body: SingleChildScrollView(
            padding: const EdgeInsets.all(20),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                // CÍRCULO DE PERFIL
                Center(
                  child: CircleAvatar(
                    radius: 50,
                    backgroundColor: viewModel.colorSeleccionado,
                    child: Text(
                      viewModel.inicial,
                      style: const TextStyle(
                        fontSize: 40,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 25),

                // CAMPO NOMBRE
                TextField(
                  controller: nombreController,
                  decoration: const InputDecoration(
                    labelText: 'Nombre',
                    prefixIcon: Icon(Icons.person),
                    border: OutlineInputBorder(),
                  ),
                ),

                const SizedBox(height: 20),

                // CAMPO BIO
                TextField(
                  controller: bioController,
                  maxLength: 80,
                  maxLines: 4,
                  decoration: const InputDecoration(
                    labelText: 'Bio',
                    hintText: 'Escribe una descripción',
                    border: OutlineInputBorder(),
                    alignLabelWithHint: true,
                  ),
                ),

                const SizedBox(height: 10),

                // SELECCIÓN DE COLOR
                const Text(
                  'Color',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 12),

                Row(
                  children: colores.map((color) {

                    bool seleccionado =
                        viewModel.colorSeleccionado == color;

                    return Padding(
                      padding: const EdgeInsets.only(right: 12),

                      child: GestureDetector(
                        onTap: () {
                          viewModel.seleccionarColor(color);
                        },

                        child: Container(
                          width: 42,
                          height: 42,

                          decoration: BoxDecoration(
                            color: color,
                            shape: BoxShape.circle,

                            border: seleccionado
                                ? Border.all(
                              color: Colors.black,
                              width: 3,
                            )
                                : null,
                          ),

                          child: seleccionado
                              ? const Icon(
                            Icons.check,
                            color: Colors.white,
                          )
                              : null,
                        ),
                      ),
                    );
                  }).toList(),
                ),

                const SizedBox(height: 25),

                // BOTÓN GUARDAR
                SizedBox(
                  width: double.infinity,
                  height: 50,

                  child: ElevatedButton.icon(
                    onPressed: () {
                      viewModel.guardarPerfil(
                        nombreController.text,
                        bioController.text,
                      );

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            'Perfil guardado correctamente',
                          ),
                        ),
                      );
                    },

                    icon: const Icon(Icons.save),
                    label: const Text('Guardar cambios'),

                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                      viewModel.colorSeleccionado,
                      foregroundColor: Colors.white,
                    ),
                  ),
                ),

                const SizedBox(height: 35),

                const Divider(),

                const SizedBox(height: 20),

                // RESUMEN GUARDADO
                Card(
                  color: const Color(0xFFF7F0FA),
                  elevation: 2,

                  child: Padding(
                    padding: const EdgeInsets.all(16),

                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        const Text(
                          'Resumen del perfil guardado',
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 20),

                        Row(
                          children: [
                            const SizedBox(
                              width: 100,
                              child: Text('Nombre:'),
                            ),

                            Expanded(
                              child: Text(
                                viewModel.perfil.nombre,
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 12),

                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              width: 100,
                              child: Text('Bio:'),
                            ),

                            Expanded(
                              child: Text(
                                viewModel.perfil.bio,
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 12),

                        Row(
                          children: [
                            const Text('Color: '),

                            const SizedBox(width: 8),

                            CircleAvatar(
                              radius: 11,
                              backgroundColor:
                              viewModel.perfil.color,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
