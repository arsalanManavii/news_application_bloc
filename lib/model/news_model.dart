class NewsModel {
  String? author;
  String? title;
  String? description;
  String? urlToImage;
  String? content;
  String? url;
  NewsModel(
    this.author,
    this.title,
    this.description,
    this.urlToImage,
    this.content,
    this.url,
  );

  factory NewsModel.fromjson(Map<String, dynamic> jsonObject) {
    return NewsModel(
      jsonObject['author'],
      jsonObject['title'],
      jsonObject['description'],
      jsonObject['urlToImage'],
      jsonObject['content'],
      jsonObject['url'],
    );
  }
}
