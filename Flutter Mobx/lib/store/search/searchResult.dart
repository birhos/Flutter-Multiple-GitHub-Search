import 'package:example/domain/models/search.dart';

enum AramaResultKind { noTerm, empty, populated }

class SearchResult {
  final AramaResultKind kind;
  final List<SearchModel> items;

  SearchResult(this.kind, this.items);

  factory SearchResult.noTerm() =>
      SearchResult(AramaResultKind.noTerm, <SearchModel>[]);

  factory SearchResult.fromJson(dynamic json) {
    final items = (json as List)
        .cast<Map<String, Object>>()
        .map((Map<String, Object> item) {
      return SearchModel.fromJson(item);
    }).toList();

    return SearchResult(
      items.isEmpty ? AramaResultKind.empty : AramaResultKind.populated,
      items,
    );
  }

  bool get isPopulated => kind == AramaResultKind.populated;

  bool get isEmpty => kind == AramaResultKind.empty;

  bool get isNoTerm => kind == AramaResultKind.noTerm;
}
