import 'search_model.dart';

enum SearchResultKind { noTerm, empty, populated }

class SearchResult {
  final SearchResultKind kind;
  final List<SearchModel> items;

  SearchResult(this.kind, this.items);

  factory SearchResult.noTerm() => SearchResult(SearchResultKind.noTerm, <SearchModel>[]);

  factory SearchResult.fromJson(List json) {
    final items = json.map((item) => SearchModel.fromJson(item)).toList();

    return SearchResult(
      items.isEmpty ? SearchResultKind.empty : SearchResultKind.populated,
      items,
    );
  }

  bool get isPopulated => kind == SearchResultKind.populated;

  bool get isEmpty => kind == SearchResultKind.empty;

  bool get isNoTerm => kind == SearchResultKind.noTerm;
}
