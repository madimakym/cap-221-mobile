import 'package:cap221_app/utils/app_colors.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        title: InkWell(
          onTap: () => setState(() {}),
          child: const Text("CAP 221",
              style: TextStyle(color: Colors.white, fontSize: 23)),
        ),
        elevation: 0.0,
      ),
      body: ListView(
        children: [
          _buildNewsItem(
              'https://www.ucad.sn/sites/default/files/articles/5Q5A7997.jpg',
              "Signature de convention entre  l’UCAD et l'Université de Douala.",
              " La salle des Actes du Rectorat a abrité ce mercredi 25 janvier , une signature de convention entre  l’Université Cheikh Anta Diop de Dakar et l'Université de Douala. Les deux parties ont longuement échangé sur la convention liant les deux universités."),
          _buildNewsItem(
              'https://img-0.journaldunet.com/Env4W_FEQYR_edOaX7jJrk7kcGo=/1500x/smart/2816456362b344cca0be0476b18ef59d/ccmcms-jdn/34122968.jpg',
              'Comment scaler une IA ?',
              "L'industrialisation du machine learning implique à la fois un outillage et de la méthode. Le point sur la démarche à mettre en œuvre en six étapes clés."),
          _buildNewsItem(
              'https://inseps.ucad.sn/sites/default/files/ibcdame.jpg',
              'UCAD/SC BASKETBALL',
              "L'UCAD/SC est en plein tournoi de monté chez les hommes. Tout commes leurs homologues dames de qui ont reussi à jouer en D1 la saison 2020-2021, les hommes vont tenter le tout pour le tout pour accéder en première division sénégalaise."),
          _buildNewsItem(
              'https://www.ucad.sn/sites/default/files/articles/carte%20invitation-6.jpg',
              'FST célébre la Journée Internationale des Mathématiques',
              "Le Département de Mathématiques-informatique de la faculté des Sciences et Techniques organise la Journée Internationale des Mathématiques le 14 mars 2023 à partir de 8h30 à l'amphi 7 de ladite faculté."),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Accueil',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.newspaper_sharp),
            label: 'Articles',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Mon compte',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: AppColors.primary,
        onTap: _onItemTapped,
      ),
    );
  }

  Widget _buildNewsItem(String imageUrl, String title, String description) {
    return Card(
      margin: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Image.network(imageUrl, fit: BoxFit.cover, height: 200),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  description,
                  style: const TextStyle(
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
