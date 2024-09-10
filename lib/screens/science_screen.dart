import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';

import '../repository/news_api.dart';
import '../view_model/article_view_model.dart';
import '../view_model/articles_view_model.dart';
import 'article_details_screen.dart';

class ScienceScreen extends StatefulWidget {
  const ScienceScreen({super.key});

  @override
  State<ScienceScreen> createState() => _ScienceScreenState();
}

class _ScienceScreenState extends State<ScienceScreen> {
  final articlesListViewModel =
      ArticlesListViewModel(classRepository: NewsApi());

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<ArticleViewModel>>(
      future: articlesListViewModel.fetchNewsScience(),
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
            body: Swiper(
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
                        child: Image.network(
                          article.urlToImage,
                          fit: BoxFit.contain,
                          height: double.infinity,
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
              autoplayDelay: 5000, // Adjust autoplay delay if needed
              pagination: const SwiperPagination(
                alignment: Alignment.bottomCenter,
                builder: SwiperPagination.dots,
              ),
            ),
          );
        }
      },
    );
  }
}
