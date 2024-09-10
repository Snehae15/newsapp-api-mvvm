import '/model/article_model.dart';

abstract class ClassRepository {
  Future<List<ArticleModel>> getCompleteNews();
  Future<List<ArticleModel>> getCategory(String category);
}
