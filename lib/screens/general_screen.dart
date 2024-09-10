import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';

import '../repository/news_api.dart';
import '../view_model/article_view_model.dart';
import '../view_model/articles_view_model.dart';
import 'article_details_screen.dart';

class GeneralScreen extends StatefulWidget {
  const GeneralScreen({super.key});

  @override
  State<GeneralScreen> createState() => _GeneralScreenState();
}

class _GeneralScreenState extends State<GeneralScreen> {
  final articlesListViewModel =
      ArticlesListViewModel(classRepository: NewsApi());

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<ArticleViewModel>>(
      future: articlesListViewModel.fetchNewsGeneral(),
      builder: (BuildContext context,
          AsyncSnapshot<List<ArticleViewModel>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (snapshot.hasError) {
          return Scaffold(
            body: Center(
              child: Text('Error: ${snapshot.error}'),
            ),
          );
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Scaffold(
            body: Center(
              child: Text('No news available.'),
            ),
          );
        } else {
          final news = snapshot.data!;
          return Scaffold(
            body: Column(
              children: [
                Expanded(
                  flex: 3,
                  child: Swiper(
                    itemBuilder: (BuildContext context, int index) {
                      final article = news[index];
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ArticleDetailsScreen(
                                title: article.title,
                                author: article.author,
                                publishedAt: article.publishedAt,
                                description: article.description,
                                content: article.content,
                                urlToImage: article.urlToImage,
                                url: article.url,
                              ),
                            ),
                          );
                        },
                        child: Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(20.0),
                              child: ColorFiltered(
                                colorFilter: ColorFilter.mode(
                                  Colors.black.withOpacity(0.5),
                                  BlendMode.darken,
                                ),
                                child: Image.network(
                                  article.urlToImage,
                                  fit: BoxFit.cover,
                                  height: double.infinity,
                                  width: double.infinity,
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 0,
                              left: 0,
                              right: 0,
                              child: Container(
                                padding: const EdgeInsets.all(16.0),
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      Colors.black.withOpacity(0.7),
                                      Colors.black.withOpacity(0.2),
                                    ],
                                    begin: Alignment.bottomCenter,
                                    end: Alignment.center,
                                  ),
                                  borderRadius: const BorderRadius.vertical(
                                    bottom: Radius.circular(20.0),
                                  ),
                                ),
                                child: Text(
                                  article.title,
                                  style: const TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                    itemCount: news.length,
                    viewportFraction: 0.8,
                    scale: 0.9,
                    autoplay: true,
                    autoplayDelay: 5000,
                    pagination: const SwiperPagination(
                      alignment: Alignment.bottomCenter,
                      builder: SwiperPagination.dots,
                    ),
                  ),
                ),
                // Below the swiper, display the list of latest news headlines
                Expanded(
                  flex: 2,
                  child: ListView.builder(
                    itemCount: news.length,
                    itemBuilder: (BuildContext context, int index) {
                      final article = news[index];
                      return ListTile(
                        leading: ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Image.network(
                            article.urlToImage,
                            fit: BoxFit.cover,
                            width: 80.0,
                            height: 80.0,
                          ),
                        ),
                        title: Text(
                          article.title,
                          style: const TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        subtitle: Text(
                          article.publishedAt.toString(),
                          style: const TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ArticleDetailsScreen(
                                title: article.title,
                                author: article.author,
                                publishedAt: article.publishedAt,
                                description: article.description,
                                content: article.content,
                                urlToImage: article.urlToImage,
                                url: article.url,
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        }
      },
    );
  }
}
