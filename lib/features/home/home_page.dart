import 'package:cap221_app/features/home/detail_article_page.dart';
import 'package:cap221_app/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_html/flutter_html.dart';
import '../../utils/global_vars.dart';
import '../../widgets/custom_dialog.dart';
import 'repository/article_repository.dart';
import 'widgets/drawer.dart';

class HomePage extends StatefulWidget {
  final String url;
  final String title;
  const HomePage({super.key, required this.url, required this.title});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  final _articlesRepository = ArticleRepository();
  dynamic listArticle = [];
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getArticles();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        title: InkWell(
          onTap: () => setState(() {}),
          child: Text(widget.title,
              style: const TextStyle(color: Colors.white, fontSize: 15)),
        ),
        elevation: 0.0,
      ),
      body: ListView(
        children: [
          for (var item in (listArticle))
            _buildNewsItem(
                "${item['id']}",
                'https://cap221.com/assets/img/cap221-logo.png',
                "${item['title']['rendered']}",
                Html(data: item['excerpt']['rendered']),
                context),
        ],
      ),
      drawer: const CustomDrawer(),
      /*bottomNavigationBar: BottomNavigationBar(
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
      ),*/
    );
  }

  getArticles() async {
    EasyLoading.show(status: 'Chargement...');
    try {
      var response = await _articlesRepository.getArticle(widget.url);
      if (widget.url == '/wp-json/wp/v2/posts?per_page=100') {
        totalArticle = response.length;
        print("on verifie le tout $totalArticle");
      }
      setState(() {
        listArticle = response;
      });
      EasyLoading.dismiss();
    } catch (error) {
      EasyLoading.dismiss();
      error as Map;
      dialogError(context,
          code: error['code'].toString(),
          message: error['message'],
          color: AppColors.danger);
    }
  }

  Widget _buildNewsItem(
      id, String imageUrl, String title, dynamic description, context) {
    return InkWell(
      child: Card(
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
                  description,
                ],
              ),
            ),
          ],
        ),
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailArticlePage(
              url: id,
              title: title,
            ),
          ),
        );
      },
    );
  }
}
