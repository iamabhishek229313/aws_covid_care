import 'package:aws_covid_care/core/parsing/network_service.dart';
import 'package:aws_covid_care/models/articles.dart';
import 'package:aws_covid_care/utils/constants.dart';

class TopheadlinesData {
  String url = 'https://newsapi.org/v2/top-headlines?country=us&q=covid-19&apiKey=${AppConstants.apiKey}';
  List<Article> headlines = [];

  refresh() async {
    var headlinesData = await NetworkService.fetchData(url);

    List articles = headlinesData['articles'];
    articles.forEach((article) {
      headlines.add(Article(
          author: article['author'],
          title: article['title'],
          description: article['description'],
          url: article['url'],
          urlToImage: article['urlToImage'],
          publishedAt: article['publishedAt'],
          content: article['content']));
    });
    headlines.forEach((element) {
      print('Title : ${element.title}');
    });
  }
}
