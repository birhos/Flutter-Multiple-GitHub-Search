class SearchModel {
  final String fullName;
  final String url;
  final String avatarUrl;

  SearchModel(this.fullName, this.url, this.avatarUrl);

  factory SearchModel.fromJson(Map<String, dynamic> json) {
    return SearchModel(
      json['full_name'] as String,
      json["html_url"] as String,
      (json["owner"] as Map<String, dynamic>)["avatar_url"] as String,
    );
  }
}
