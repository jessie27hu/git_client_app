class User {
  String? login;
  String? avatarUrl;
  String? type;
  String? name;
  String? company;
  String? blog;
  String? location;
  String? email;
  bool? hireable;
  String? bio;
  int? publicRepos;
  int? followers;
  int? following;
  String? createdAt;
  String? updatedAt;
  int? totalPrivateRepos;
  int? ownedPrivateRepos;

  User({
    this.login,
    this.avatarUrl,
    this.type,
    this.name,
    this.company,
    this.blog,
    this.location,
    this.email,
    this.hireable,
    this.bio,
    this.publicRepos,
    this.followers,
    this.following,
    this.createdAt,
    this.updatedAt,
    this.totalPrivateRepos,
    this.ownedPrivateRepos,
  });

  factory User.fromJson(Map<String, Object?> json) => User(
        login: json['login'] as String?,
        avatarUrl: json['avatar_url'] as String?,
        type: json['type'] as String?,
        name: json['name'] as String?,
        company: json['company'] as String?,
        blog: json['blog'] as String?,
        location: json['location'] as String?,
        email: json['email'] as String?,
        hireable: json['hireable'] as bool?,
        bio: json['bio'] as String?,
        publicRepos: json['public_repos'] as int?,
        followers: json['followers'] as int?,
        following: json['following'] as int?,
        createdAt: json['created_at'] as String?,
        updatedAt: json['updated_at'] as String?,
        totalPrivateRepos: json['total_private_repos'] as int?,
        ownedPrivateRepos: json['owned_private_repos'] as int?,
      );

  Map<String, Object?> toJson() => {
        'login': login,
        'avatar_url': avatarUrl,
        'type': type,
        'name': name,
        'company': company,
        'blog': blog,
        'location': location,
        'email': email,
        'hireable': hireable,
        'bio': bio,
        'public_repos': publicRepos,
        'followers': followers,
        'following': following,
        'created_at': createdAt,
        'updated_at': updatedAt,
        'total_private_repos': totalPrivateRepos,
        'owned_private_repos': ownedPrivateRepos,
      };
}
