// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// import '../components/Comentario_tile.dart';
// import '../models/user.dart';
// import '../provider/comentarios.dart';
// import '../provider/users.dart';

// class Comentario extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final comentariosProvider = Provider.of<Comentarios>(context);
//     final List<Comentario> comentarios =
//         comentariosProvider.all.cast<Comentario>();
//     final usersProvider = Provider.of<Users>(context);

//     final User loggedInUser = usersProvider.loggedInUser!;

//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Lista de Comentários'),
//         actions: <Widget>[
//           IconButton(
//             onPressed: () {
//               // Lógica para adicionar um novo comentário
//             },
//             icon: Icon(Icons.add),
//           ),
//         ],
//       ),
//       body: ListView.builder(
//         itemCount: comentarios.length,
//         itemBuilder: (ctx, i) => ComentarioTile(
//           comentarios[i],
//           loggedInUser: loggedInUser,
//         ),
//       ),
//     );
//   }
// }
