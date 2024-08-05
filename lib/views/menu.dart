import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../routes/app_routes.dart';

class BottomNavBarFb5 extends StatelessWidget {
  const BottomNavBarFb5({Key? key}) : super(key: key);

  final primaryColor = const Color(0xff4338CA);
  final secondaryColor = const Color(0xff6D28D9);
  final accentColor = const Color(0xffffffff);
  final backgroundColor = const Color(0xffffffff);
  final errorColor = const Color(0xffEF4444);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        color: primaryColor,
        child: SizedBox(
          height: 56,
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: const EdgeInsets.only(left: 25.0, right: 25.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconBottomBar(
                  text: "Home",
                  icon: Icons.home,
                  selected: true,
                  onPressed: () {
                    Navigator.of(context).pushNamed(
                      AppRoutes.Livro,
                    );
                  },
                ),
                IconBottomBar(
                  text: "Search",
                  icon: Icons.search_outlined,
                  selected: false,
                  onPressed: () {
                    Navigator.of(context).pushNamed(
                      AppRoutes.Pesquisar,
                    );
                  },
                ),
                IconBottomBar(
                  text: "Add",
                  icon: Icons.add_to_photos_outlined,
                  selected: false,
                  onPressed: () {
                    Navigator.of(context).pushNamed(
                      AppRoutes.Livro_Form,
                    );
                  },
                ),
                IconBottomBar(
                  text: "Cart",
                  icon: Icons.local_grocery_store_outlined,
                  selected: false,
                  onPressed: () {
                    Navigator.of(context).pushNamed(
                      AppRoutes.LivroReservado,
                    );
                  },
                ),
                IconBottomBar(
                  text: "Review",
                  icon: Icons.message,
                  selected: false,
                  onPressed: () {
                    Navigator.of(context).pushNamed(
                      AppRoutes.Comentar,
                    );
                  },
                ),
                IconBottomBar(
                  text: "Perfil",
                  icon: Icons.person,
                  selected: false,
                  onPressed: () {
                    Navigator.of(context).pushNamed(
                      AppRoutes.USER_List,
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      body: Container(
        // Conteúdo da página
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/livro.jpeg'), fit: BoxFit.cover),
        ),
        child: Column(
          children: [
            Expanded(
              child: Center(
                child: Image.asset('assets/livro.jpeg'),
              ),
            ),
            // Outros widgets ou conteúdo da página abaixo da imagem, se houver.
          ],
        ),
      ),
    );
  }
}

class IconBottomBar extends StatelessWidget {
  const IconBottomBar({
    Key? key,
    required this.text,
    required this.icon,
    required this.selected,
    required this.onPressed,
  }) : super(key: key);

  final String text;
  final IconData icon;
  final bool selected;
  final Function() onPressed;

  final primaryColor = const Color(0xff4338CA);
  final accentColor = const Color(0xffffffff);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          onPressed: onPressed,
          icon: Icon(
            icon,
            size: 25,
            color: selected ? accentColor : Colors.grey,
          ),
        ),
        Text(
          text,
          style: TextStyle(
            fontSize: 12,
            height: .1,
            color: selected ? accentColor : Colors.grey,
          ),
        ),
      ],
    );
  }
}

// void main() {
//   runApp(MaterialApp(
//     home: BottomNavBarFb5(),
//   ));
// }
