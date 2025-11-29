import 'package:flutter/material.dart';
import 'package:movies/core/theme/app_colors.dart';
import 'package:movies/features/watchlist/data/database/watchlist_database.dart';
import 'package:movies/features/watchlist/data/models/watchlist_movie_model.dart';

class SliverAppBarWidget extends StatefulWidget {
  const SliverAppBarWidget({
    super.key,
    this.movieId,
    this.title,
    this.posterPath,
    this.releaseDate,
    this.voteAverage,
    this.runtime,
    this.genre,
  });

  final int? movieId;
  final String? title;
  final String? posterPath;
  final String? releaseDate;
  final double? voteAverage;
  final int? runtime;
  final String? genre;

  @override
  State<SliverAppBarWidget> createState() => _SliverAppBarWidgetState();
}

class _SliverAppBarWidgetState extends State<SliverAppBarWidget> {
  final WatchlistDatabase _database = WatchlistDatabase();
  bool _isBookmarked = false;

  @override
  void initState() {
    super.initState();
    _checkBookmarkStatus();
  }

  @override
  void didUpdateWidget(SliverAppBarWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.movieId != oldWidget.movieId) {
      _checkBookmarkStatus();
    }
  }

  void _checkBookmarkStatus() {
    if (widget.movieId != null) {
      setState(() {
        _isBookmarked = _database.isInWatchlist(widget.movieId!);
      });
    }
  }

  void _toggleBookmark() {
    if (widget.movieId == null ||
        widget.title == null ||
        widget.releaseDate == null ||
        widget.voteAverage == null ||
        widget.runtime == null ||
        widget.genre == null) {
      return;
    }

    if (!mounted) return;

    setState(() {
      if (_isBookmarked) {
        _database.removeFromWatchlist(widget.movieId!);
        _isBookmarked = false;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Removed from watchlist'),
            duration: Duration(seconds: 1),
          ),
        );
      } else {
        final movie = WatchlistMovieModel(
          movieId: widget.movieId!,
          title: widget.title!,
          posterPath: widget.posterPath,
          releaseDate: widget.releaseDate!,
          voteAverage: widget.voteAverage!,
          runtime: widget.runtime!,
          genre: widget.genre!,
        );
        _database.addToWatchlist(movie);
        _isBookmarked = true;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Added to watchlist'),
            duration: Duration(seconds: 1),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      title: Text('Details', style: Theme.of(context).textTheme.titleLarge),
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios, color: AppColors.titleText),
        onPressed: () => Navigator.pop(context),
      ),
      actions: [
        IconButton(
          icon: Icon(
            _isBookmarked ? Icons.bookmark : Icons.bookmark_border_outlined,
            color: AppColors.titleText,
          ),
          onPressed: _toggleBookmark,
        ),
      ],
    );
  }
}
