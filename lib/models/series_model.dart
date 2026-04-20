class SeriesDao {
  int seriesId;
  String url;
  String name;
  String title;
  String summary;
  String body;
  String kicker;
  String thumbUrl;
  String heroUrl;
  String titleUrl;
  String teaser;
  bool isMass;
  List<dynamic> shows;
  List<dynamic> tags;
  String platformPlayerId;
  bool hiddenFromApps;
  int relatedTagId;

  SeriesDao({
    required this.seriesId,
    required this.url,
    required this.name,
    required this.title,
    required this.summary,
    required this.body,
    required this.kicker,
    required this.thumbUrl,
    required this.heroUrl,
    required this.titleUrl,
    required this.teaser,
    required this.isMass,
    required this.shows,
    required this.tags,
    required this.platformPlayerId,
    required this.hiddenFromApps,
    required this.relatedTagId,
  });

  factory SeriesDao.fromMap(Map<String,dynamic> serie){
    return SeriesDao(
      seriesId: serie['seriesId'],
      url: serie['url'],
      name: serie['name'],
      title: serie['title'],
      summary: serie['summary'],
      body: serie['body'],
      kicker: serie['kicker'],
      thumbUrl: serie['thumbUrl'],
      heroUrl: serie['heroUrl'],
      titleUrl: serie['titleUrl'],
      teaser: serie['teaser'],
      isMass: serie['isMass'],
      shows: serie['shows'],
      tags: serie['tags'],
      platformPlayerId: serie['platformPlayerId'],
      hiddenFromApps: serie['hiddenFromApps'],
      relatedTagId: serie['relatedTagId']
    );
  }

}
