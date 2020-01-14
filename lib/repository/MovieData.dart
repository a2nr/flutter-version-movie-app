class MovieData {
  bool adult;
  String backdropPath;
  List<CreatedBy> createdBy;
  List<int> episodeRunTime;
  String firstAirDate;
  BelongsToCollection belongsToCollection;
  int budget;
  List<Genres> genres;
  String homepage;
  int id;
  bool inProduction;
  List<String> languages;
  String lastAirDate;
  LastEpisodeToAir lastEpisodeToAir;
  String name;
  NextEpisodeToAir nextEpisodeToAir;
  List<Networks> networks;
  int numberOfEpisodes;
  int numberOfSeasons;
  List<String> originCountry;
  String imdbId;
  String originalLanguage;
  String originalName;
  String originalTitle;
  String overview;
  double popularity;
  String posterPath;
  List<ProductionCompanies> productionCompanies;
  List<Seasons> seasons;
  List<ProductionCountries> productionCountries;
  String releaseDate;
  int revenue;
  int runtime;
  List<SpokenLanguages> spokenLanguages;
  String status;
  String type;
  double voteAverage;
  String tagline;
  String title;
  bool video;
  int voteCount;

  MovieData(
      {this.adult,
      this.backdropPath,
      this.belongsToCollection,
      this.budget,
      this.createdBy,
      this.episodeRunTime,
      this.firstAirDate,
      this.genres,
      this.homepage,
      this.id,
      this.inProduction,
      this.languages,
      this.lastAirDate,
      this.lastEpisodeToAir,
      this.name,
      this.nextEpisodeToAir,
      this.networks,
      this.numberOfEpisodes,
      this.numberOfSeasons,
      this.originCountry,
      this.imdbId,
      this.originalLanguage,
      this.originalName,
      this.originalTitle,
      this.overview,
      this.popularity,
      this.posterPath,
      this.productionCompanies,
      this.seasons,
      this.productionCountries,
      this.releaseDate,
      this.revenue,
      this.runtime,
      this.spokenLanguages,
      this.status,
      this.type,
      this.tagline,
      this.title,
      this.video,
      this.voteAverage,
      this.voteCount});

  MovieData.fromJson(Map<String, dynamic> map){
    adult = map['adult'];
    backdropPath = map['backdrop_path'];
    if (map['created_by'] != null) {
      createdBy = new List<CreatedBy>();
      map['created_by'].forEach((v) {
        createdBy.add(new CreatedBy.fromJson(v));
      });
    }
    episodeRunTime = map['episode_run_time']!=null?map['episode_run_time'].cast<int>():null;
    firstAirDate = map['first_air_date'];
    belongsToCollection = map['belongs_to_collection'] != null
        ? new BelongsToCollection.fromJson(map['belongs_to_collection'])
        : null;
    budget = map['budget'];
    if (map['genres'] != null) {
      genres = new List<Genres>();
      map['genres'].forEach((v) {
        genres.add(new Genres.fromJson(v));
      });
    }
    homepage = map['homepage'];
    id = map['id'];
    inProduction = map['in_production'];
    languages = map['languages']!=null?map['languages'].cast<String>():null;
    lastAirDate = map['last_air_date'];
    lastEpisodeToAir = map['last_episode_to_air'] != null
        ? new LastEpisodeToAir.fromJson(map['last_episode_to_air'])
        : null;
    name = map['name'];
    nextEpisodeToAir = map['next_episode_to_air'] != null
        ? new NextEpisodeToAir.fromJson(map['next_episode_to_air'])
        : null;
    if (map['networks'] != null) {
      networks = new List<Networks>();
      map['networks'].forEach((v) {
        networks.add(new Networks.fromJson(v));
      });
    }
    numberOfEpisodes = map['number_of_episodes'];
    numberOfSeasons = map['number_of_seasons'];
    originCountry = map['origin_country']!=null?map['origin_country'].cast<String>():null;
    imdbId = map['imdb_id'];
    originalLanguage = map['original_language'];
    originalName = map['original_name'];
    originalTitle = map['original_title'];
    overview = map['overview'];
    popularity = map['popularity'];
    posterPath = map['poster_path'];
    if (map['production_companies'] != null) {
      productionCompanies = new List<ProductionCompanies>();
      map['production_companies'].forEach((v) {
        productionCompanies.add(new ProductionCompanies.fromJson(v));
      });
    }
    if (map['seasons'] != null) {
      seasons = new List<Seasons>();
      map['seasons'].forEach((v) {
        seasons.add(new Seasons.fromJson(v));
      });
    }
    if (map['production_countries'] != null) {
      productionCountries = new List<ProductionCountries>();
      map['production_countries'].forEach((v) {
        productionCountries.add(new ProductionCountries.fromJson(v));
      });
    }
    releaseDate = map['release_date'];
    revenue = map['revenue'];
    runtime = map['runtime'];
    if (map['spoken_languages'] != null) {
      spokenLanguages = new List<SpokenLanguages>();
      map['spoken_languages'].forEach((v) {
        spokenLanguages.add(new SpokenLanguages.fromJson(v));
      });
    }
    status = map['status'];
    type = map['type'];
    tagline = map['tagline'];
    title = map['title'];
    video = map['video'];
    voteAverage = map['vote_average'];
    voteCount = map['vote_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['adult'] = this.adult;
    data['backdrop_path'] = this.backdropPath;
    if (this.createdBy != null) {
      data['created_by'] = this.createdBy.map((v) => v.toJson()).toList();
    }    
    if (this.belongsToCollection != null) {
      data['belongs_to_collection'] = this.belongsToCollection.toJson();
    }
    data['episode_run_time'] = this.episodeRunTime;
    data['first_air_date'] = this.firstAirDate;
    data['budget'] = this.budget;
    if (this.genres != null) {
      data['genres'] = this.genres.map((v) => v.toJson()).toList();
    }
    data['homepage'] = this.homepage;
    data['id'] = this.id;
    data['in_production'] = this.inProduction;
    data['languages'] = this.languages;
    data['last_air_date'] = this.lastAirDate;
    if (this.lastEpisodeToAir != null) {
      data['last_episode_to_air'] = this.lastEpisodeToAir.toJson();
    }
    data['name'] = this.name;
    if (this.nextEpisodeToAir != null) {
      data['next_episode_to_air'] = this.nextEpisodeToAir.toJson();
    }
    if (this.networks != null) {
      data['networks'] = this.networks.map((v) => v.toJson()).toList();
    }
    data['number_of_episodes'] = this.numberOfEpisodes;
    data['number_of_seasons'] = this.numberOfSeasons;
    data['origin_country'] = this.originCountry;
    data['imdb_id'] = this.imdbId;
    data['original_language'] = this.originalLanguage;
    data['original_name'] = this.originalName;
    data['original_title'] = this.originalTitle;
    data['overview'] = this.overview;
    data['popularity'] = this.popularity;
    data['poster_path'] = this.posterPath;
    if (this.productionCompanies != null) {
      data['production_companies'] =
          this.productionCompanies.map((v) => v.toJson()).toList();
    }
    if (this.seasons != null) {
      data['seasons'] = this.seasons.map((v) => v.toJson()).toList();
    }
    if (this.productionCountries != null) {
      data['production_countries'] =
          this.productionCountries.map((v) => v.toJson()).toList();
    }
    data['release_date'] = this.releaseDate;
    data['revenue'] = this.revenue;
    data['runtime'] = this.runtime;
    if (this.spokenLanguages != null) {
      data['spoken_languages'] =
          this.spokenLanguages.map((v) => v.toJson()).toList();
    }
    data['status'] = this.status;
    data['type'] = this.type;
    data['tagline'] = this.tagline;
    data['title'] = this.title;
    data['video'] = this.video;
    data['vote_average'] = this.voteAverage;
    data['vote_count'] = this.voteCount;
    return data;
  }
}

class CreatedBy {
  int id;
  String creditId;
  String name;
  int gender;
  String profilePath;

  CreatedBy({this.id, this.creditId, this.name, this.gender, this.profilePath});

  CreatedBy.fromJson(Map<String, dynamic> map) {
    id = map['id'];
    creditId = map['credit_id'];
    name = map['name'];
    gender = map['gender'];
    profilePath = map['profile_path'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['credit_id'] = this.creditId;
    data['name'] = this.name;
    data['gender'] = this.gender;
    data['profile_path'] = this.profilePath;
    return data;
  }
}

class Genres {
  int id;
  String name;

  Genres({this.id, this.name});

  Genres.fromJson(Map<String, dynamic> map) {
    id = map['id'];
    name = map['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}

class LastEpisodeToAir {
  String airDate;
  int episodeNumber;
  int id;
  String name;
  String overview;
  String productionCode;
  int seasonNumber;
  int showId;
  String stillPath;
  double voteAverage;
  int voteCount;

  LastEpisodeToAir(
      {this.airDate,
      this.episodeNumber,
      this.id,
      this.name,
      this.overview,
      this.productionCode,
      this.seasonNumber,
      this.showId,
      this.stillPath,
      this.voteAverage,
      this.voteCount});

  LastEpisodeToAir.fromJson(Map<String, dynamic> map) {
    airDate = map['air_date'];
    episodeNumber = map['episode_number'];
    id = map['id'];
    name = map['name'];
    overview = map['overview'];
    productionCode = map['production_code'];
    seasonNumber = map['season_number'];
    showId = map['show_id'];
    stillPath = map['still_path'];
    voteAverage = map['vote_average']!=null? map['vote_average']:null;
    voteCount = map['vote_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['air_date'] = this.airDate;
    data['episode_number'] = this.episodeNumber;
    data['id'] = this.id;
    data['name'] = this.name;
    data['overview'] = this.overview;
    data['production_code'] = this.productionCode;
    data['season_number'] = this.seasonNumber;
    data['show_id'] = this.showId;
    data['still_path'] = this.stillPath;
    data['vote_average'] = this.voteAverage;
    data['vote_count'] = this.voteCount;
    return data;
  }
}

class NextEpisodeToAir {
  String airDate;
  int episodeNumber;
  int id;
  String name;
  String overview;
  String productionCode;
  int seasonNumber;
  int showId;
  String stillPath;
  double voteAverage;
  int voteCount;

  NextEpisodeToAir(
      {this.airDate,
      this.episodeNumber,
      this.id,
      this.name,
      this.overview,
      this.productionCode,
      this.seasonNumber,
      this.showId,
      this.stillPath,
      this.voteAverage,
      this.voteCount});

  NextEpisodeToAir.fromJson(Map<String, dynamic> map) {
    airDate = map['air_date'];
    episodeNumber = map['episode_number'];
    id = map['id'];
    name = map['name'];
    overview = map['overview'];
    productionCode = map['production_code'];
    seasonNumber = map['season_number'];
    showId = map['show_id'];
    stillPath = map['still_path'];
    voteAverage = map['vote_average'];
    voteCount = map['vote_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['air_date'] = this.airDate;
    data['episode_number'] = this.episodeNumber;
    data['id'] = this.id;
    data['name'] = this.name;
    data['overview'] = this.overview;
    data['production_code'] = this.productionCode;
    data['season_number'] = this.seasonNumber;
    data['show_id'] = this.showId;
    data['still_path'] = this.stillPath;
    data['vote_average'] = this.voteAverage;
    data['vote_count'] = this.voteCount;
    return data;
  }
}

class Networks {
  String name;
  int id;
  String logoPath;
  String originCountry;

  Networks({this.name, this.id, this.logoPath, this.originCountry});

  Networks.fromJson(Map<String, dynamic> map) {
    name = map['name'];
    id = map['id'];
    logoPath = map['logo_path'];
    originCountry = map['origin_country'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['id'] = this.id;
    data['logo_path'] = this.logoPath;
    data['origin_country'] = this.originCountry;
    return data;
  }
}

class Seasons {
  String airDate;
  int episodeCount;
  int id;
  String name;
  String overview;
  String posterPath;
  int seasonNumber;

  Seasons(
      {this.airDate,
      this.episodeCount,
      this.id,
      this.name,
      this.overview,
      this.posterPath,
      this.seasonNumber});

  Seasons.fromJson(Map<String, dynamic> map) {
    airDate = map['air_date'];
    episodeCount = map['episode_count'];
    id = map['id'];
    name = map['name'];
    overview = map['overview'];
    posterPath = map['poster_path'];
    seasonNumber = map['season_number'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['air_date'] = this.airDate;
    data['episode_count'] = this.episodeCount;
    data['id'] = this.id;
    data['name'] = this.name;
    data['overview'] = this.overview;
    data['poster_path'] = this.posterPath;
    data['season_number'] = this.seasonNumber;
    return data;
  }
}
class BelongsToCollection {
  int id;
  String name;
  String posterPath;
  String backdropPath;

  BelongsToCollection({this.id, this.name, this.posterPath, this.backdropPath});

  BelongsToCollection.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    posterPath = json['poster_path'];
    backdropPath = json['backdrop_path'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['poster_path'] = this.posterPath;
    data['backdrop_path'] = this.backdropPath;
    return data;
  }
}

class ProductionCompanies {
  int id;
  String logoPath;
  String name;
  String originCountry;

  ProductionCompanies({this.id, this.logoPath, this.name, this.originCountry});

  ProductionCompanies.fromJson(Map<String, dynamic> map) {
    id = map['id'];
    logoPath = map['logo_path'];
    name = map['name'];
    originCountry = map['origin_country'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['logo_path'] = this.logoPath;
    data['name'] = this.name;
    data['origin_country'] = this.originCountry;
    return data;
  }
}

class ProductionCountries {
  String iso31661;
  String name;

  ProductionCountries({this.iso31661, this.name});

  ProductionCountries.fromJson(Map<String, dynamic> json) {
    iso31661 = json['iso_3166_1'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['iso_3166_1'] = this.iso31661;
    data['name'] = this.name;
    return data;
  }
}

class SpokenLanguages {
  String iso6391;
  String name;

  SpokenLanguages({this.iso6391, this.name});

  SpokenLanguages.fromJson(Map<String, dynamic> json) {
    iso6391 = json['iso_639_1'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['iso_639_1'] = this.iso6391;
    data['name'] = this.name;
    return data;
  }
}
