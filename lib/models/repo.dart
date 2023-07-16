import 'license.dart';

class Repo {
  int? id;
  String? name;
  String? fullName;
  bool? private;
  String? description;
  bool? fork;
  String? language;
  int? stargazersCount;
  int? size;
  String? defaultBranch;
  int? openIssuesCount;
  String? pushedAt;
  String? createdAt;
  String? updatedAt;
  int? subscribersCount;
  License? license;

  Repo({
    this.id,
    this.name,
    this.fullName,
    this.private,
    this.description,
    this.fork,
    this.language,
    this.stargazersCount,
    this.size,
    this.defaultBranch,
    this.openIssuesCount,
    this.pushedAt,
    this.createdAt,
    this.updatedAt,
    this.subscribersCount,
    this.license,
  });

  factory Repo.fromJson(Map<String, Object?> json) => Repo(
        id: json['id'] as int?,
        name: json['name'] as String?,
        fullName: json['full_name'] as String?,
        private: json['private'] as bool?,
        description: json['description'] as String?,
        fork: json['fork'] as bool?,
        language: json['language'] as String?,
        stargazersCount: json['stargazers_count'] as int?,
        size: json['size'] as int?,
        defaultBranch: json['default_branch'] as String?,
        openIssuesCount: json['open_issues_count'] as int?,
        pushedAt: json['pushed_at'] as String?,
        createdAt: json['created_at'] as String?,
        updatedAt: json['updated_at'] as String?,
        subscribersCount: json['subscribers_count?'] as int?,
        license: json['license'] == null
            ? null
            : License.fromJson(json['license']! as Map<String, Object?>),
      );

  Map<String, Object?> toJson() => {
        'id': id,
        'name': name,
        'full_name': fullName,
        'private': private,
        'description': description,
        'fork': fork,
        'language': language,
        'stargazers_count': stargazersCount,
        'size': size,
        'default_branch': defaultBranch,
        'open_issues_count': openIssuesCount,
        'pushed_at': pushedAt,
        'created_at': createdAt,
        'updated_at': updatedAt,
        'subscribers_count?': subscribersCount,
        'license': license?.toJson(),
      };
}
