import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

import 'search_result.dart';

final http.Client httpClient = http.Client();

class GithubRepository {
  static const String baseUrl = "https://api.github.com/search/repositories?q=";

  final Map<String, SearchResult> cache;

  GithubRepository({
    Map<String, SearchResult>? cache,
  }) : this.cache = cache ?? <String, SearchResult>{};

  Future<SearchResult> search(String term) async {
    if (cache.containsKey(term)) {
      return cache[term]!;
    } else {
      final result = await getResult(term);
      cache[term] = result;
      return result;
    }
  }

  Future<SearchResult> getResult(String term) async {
    final response = await httpClient.get(Uri.parse("$baseUrl$term"));
    final results = json.decode(response.body);
    return SearchResult.fromJson(results['items']);
  }
}
