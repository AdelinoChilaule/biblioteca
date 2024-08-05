// import 'package:bibilioteca/components/livro_tile.dart';
// import 'package:bibilioteca/models/livro_alugado.dart';
// import 'package:bibilioteca/routes/app_routes.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// import '../components/Livro_reservado.dart';
// import '../components/alugar_livro.dart';
// import '../models/livro.dart';
// import '../provider/livroalugado.dart';
// import '../provider/livros.dart';

// class Livro_Alugado extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final livrosProvider = Provider.of<Alugarlivro>(context);
//     final List<LivroAlugado> livros = livrosProvider.all;

//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Lista de Livros Reservados'),
//         actions: <Widget>[
//           IconButton(
//             onPressed: () {
//               //Chamando a nova página do formulário
//               Navigator.of(context).pushNamed(AppRoutes.LivroReservado);
//             },
//             icon: Icon(Icons.add),
//           ),
//         ],
//       ),
//       body: ListView.builder(
//         itemCount: livros.length,
//         itemBuilder: (ctx, i) => LivroAlugar(livros[i]),
//       ),
//     );
//   }
// }
