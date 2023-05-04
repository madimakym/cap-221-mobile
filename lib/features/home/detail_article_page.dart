import 'package:cap221_app/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_html/flutter_html.dart';
import '../../utils/global_vars.dart';
import '../../widgets/custom_dialog.dart';
import 'repository/article_repository.dart';
import 'widgets/drawer.dart';

class DetailArticlePage extends StatefulWidget {
  final String url;
  final String title;
  const DetailArticlePage({super.key, required this.url, required this.title});

  @override
  State<DetailArticlePage> createState() => _DetailArticlePageState();
}

class _DetailArticlePageState extends State<DetailArticlePage> {
  int _selectedIndex = 0;
  final _articlesRepository = ArticleRepository();
  dynamic listArticle = [];
  dynamic currentArticle = Container();
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    getCurrentArticle();
    super.initState();
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
        children: [currentArticle],
      ),
    );
  }

  getCurrentArticle() async {
    EasyLoading.show(status: 'Chargement...');
    String url = "wp-json/wp/v2/posts/${widget.url}";
    try {
      var response = await _articlesRepository.getArticleById(url);
      print(response);
      setState(() {
        currentArticle = formatArticle(response, context);
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

  formatArticle(data, context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Image.network("https://cap221.com/assets/img/cap221-logo.png",
              fit: BoxFit.cover, width: MediaQuery.of(context).size.width),
        ),
        Padding(
          padding: const EdgeInsets.all(5.0),
          child: Text(
            "${data["title"]["rendered"]}",
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Html(data: data['content']['rendered']),
        ),
        const SizedBox(
          height: 30,
        )
      ],
    );
  }
}
