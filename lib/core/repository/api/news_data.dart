import 'package:aws_covid_care/core/parsing/network_service.dart';
import 'package:aws_covid_care/models/articles.dart';
import 'package:aws_covid_care/utils/constants.dart';

class NewsData {
  List<Article> articles = [];
  String url =
      'https://newsapi.org/v2/everything?q=covid-19&sortBy=publishedAt&from=2020-10-25&language=en&apiKey=${AppConstants.apiKey}';
  refresh() async {
    var data = await NetworkService.fetchData(url);
    List newsData = data['articles'];
    newsData.forEach((article) {
      if (article['title'] != null &&
          article['url'] != null &&
          article['urlToImage'] != null &&
          article['content'] != null) {
        articles.add(Article(
          author: article['author'],
          title: article['title'],
          description: article['description'],
          url: article['url'],
          urlToImage: article['urlToImage'],
          publishedAt: article['publishedAt'],
          content: article['content'],
        ));
      }
    });
  }
}
