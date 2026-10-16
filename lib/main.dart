import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const HomeView(),
    );
  }
}

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {

  // Lista donde guardaremos las comidas seleccionadas
  List<String> comidas = [];

  // Función para agregar una comida
  void agregarComida(String comida) {
    setState(() {
      comidas.add(comida);
    });
  }

  void eliminarComida(int index){
    setState(() {
      comidas.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Combos de comida'),
        backgroundColor: Colors.deepOrange,
        centerTitle: true,
        foregroundColor: Colors.white,
      ),

      body: ListView.builder(
        itemCount: comidas.length,
        //index es para saber la posicion luego, util luego para añadir eliminar x ejemplo
        itemBuilder: (context, index) {
          return ListTile(
            leading: const Icon(
              Icons.fastfood,
              color: Colors.deepOrange,
            ),
            title: Text(comidas[index]),
            trailing: IconButton(
              icon: const Icon(
                Icons.delete,
                color: Colors.red,
              ),
              onPressed: (){
                showDeleteModal(context, index, eliminarComida);
              },
            ),
          );
        },
      ),

      // El bottomNavigationBar se coloca fuera del body
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ElevatedButton(
          onPressed: () {
            showBottomSheet(context, agregarComida);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.deepOrange,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 16),
          ),
          child: const Text('Agregar Comida'),
        ),
      ),
    );
  }
}

// Mostrar las opciones disponibles
void showBottomSheet(
    BuildContext context,
    Function(String) agregarComida,
    ) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (context) {
      return SafeArea(
        child: ListView(
          shrinkWrap: true,
          children: [
            ListTile(
              leading: const Icon(Icons.fastfood, color: Colors.deepOrange),
              title: const Text('Hamburguesa + Papa + Gaseosa'),
              onTap: () {
                agregarComida('Hamburguesa + Papa + Gaseosa');
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.fastfood, color: Colors.deepOrange),
              title: const Text('Pollo + papa + gaseosa'),
              onTap: () {
                agregarComida('Pollo + papa + gaseosa');
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.fastfood, color: Colors.deepOrange),
              title: const Text('Pizza + gaseosa'),
              onTap: () {
                agregarComida('Pizza + gaseosa');
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.fastfood, color: Colors.deepOrange),
              title: const Text('Hot dog + papa + gaseosa'),
              onTap: () {
                agregarComida('Hot dog + papa + gaseosa');
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.fastfood, color: Colors.deepOrange),
              title: const Text('Nuggets + papa + gaseosa'),
              onTap: () {
                agregarComida('Nuggets + papa + gaseosa');
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.fastfood, color: Colors.deepOrange),
              title: const Text('Ensalada + jugo'),
              onTap: () {
                agregarComida('Ensalada + jugo');
                Navigator.pop(context);
              },
            ),
          ],
        ),
      );
    },
  );
}

//se le tiene que pasar el index del elemento que se va a elminar
void showDeleteModal(BuildContext context, int index, Function(int) eliminarComida){
  showDialog(
      context: context,
      builder: (context){
        return AlertDialog(
          title: const Text('Eliminar combo'),
          content: const Text('¿Deseas eliminar este combo?'),
          actions: [
            TextButton(
              onPressed: ()=>Navigator.pop(context),
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: (){
                eliminarComida(index);
                Navigator.pop(context);
              },
              child: const Text('Aceptar'),
             )
          ]
        );
      }
  );
}
