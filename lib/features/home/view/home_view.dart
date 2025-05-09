import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'home_detail.dart';

class Book {
  final String title;
  final String author;
  final Color color;
  final String? tag;
  final String? coverUrl;

  Book({
    required this.title,
    this.author = '',
    this.color = Colors.white,
    this.tag,
    this.coverUrl,
  });
}

class Podcast {
  final String title;
  final String number;
  final String? imageUrl;

  Podcast({required this.title, required this.number, this.imageUrl});
}

class Review {
  final String bookTitle;
  final String author;
  final String reviewerName;
  final String timeAgo;
  final int rating;
  final String comment;

  Review({
    required this.bookTitle,
    required this.author,
    required this.reviewerName,
    required this.timeAgo,
    required this.rating,
    required this.comment,
  });
}

// API Service for Audiobooks - Using Open Library API instead
class AudiobookApiService {
  static const String baseUrl = 'https://openlibrary.org/subjects';

  Future<List<Map<String, dynamic>>> getAudiobooks({
    int limit = 20,
    int offset = 0,
    String subject = 'audiobooks',
  }) async {
    final Uri uri = Uri.parse('$baseUrl/$subject.json?limit=$limit&offset=$offset');

    try {
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        final List<dynamic> works = data['works'];

        return works.map((work) => {
          'title': work['title'],
          'authors': work['authors']?.map((a) => {'name': a['name']})?.toList() ?? [],
          'cover_id': work['cover_id'],
          'key': work['key'],
        } as Map<String, dynamic>).toList();
      } else {
        throw Exception('Failed to load books: ${response.statusCode}');
      }
    } catch (e) {
      // Fallback to mock data if API fails
      return _getMockBooks();
    }
  }

  // Fallback mock data in case the API fails
  List<Map<String, dynamic>> _getMockBooks() {
    return [
      {
        'title': 'Đắc Nhân Tâm',
        'authors': [{'name': 'Dale Carnegie'}],
        'cover_id': null,
        'key': '/works/1',
      },
      {
        'title': 'Nhà Giả Kim',
        'authors': [{'name': 'Paulo Coelho'}],
        'cover_id': null,
        'key': '/works/2',
      },
      {
        'title': 'Tư Duy Nhanh Và Chậm',
        'authors': [{'name': 'Daniel Kahneman'}],
        'cover_id': null,
        'key': '/works/3',
      },
      {
        'title': 'Người Giàu Có Nhất Thành Babylon',
        'authors': [{'name': 'George S. Clason'}],
        'cover_id': null,
        'key': '/works/4',
      },
      {
        'title': 'Điểm Đến Của Cuộc Đời',
        'authors': [{'name': 'James Allen'}],
        'cover_id': null,
        'key': '/works/5',
      },
      {
        'title': 'Bí Mật',
        'authors': [{'name': 'Rhonda Byrne'}],
        'cover_id': null,
        'key': '/works/6',
      },
      {
        'title': 'Đọc Vị Bất Kỳ Ai',
        'authors': [{'name': 'David J. Lieberman'}],
        'cover_id': null,
        'key': '/works/7',
      },
      {
        'title': 'Nghĩ Giàu Làm Giàu',
        'authors': [{'name': 'Napoleon Hill'}],
        'cover_id': null,
        'key': '/works/8',
      },
      {
        'title': 'Đời Ngắn Đừng Ngủ Dài',
        'authors': [{'name': 'Robin Sharma'}],
        'cover_id': null,
        'key': '/works/9',
      },
      {
        'title': 'Cà Phê Cùng Tony',
        'authors': [{'name': 'Tony Buổi Sáng'}],
        'cover_id': null,
        'key': '/works/10',
      },
    ];
  }

  // Get cover URL from Open Library
  String? getCoverUrl(dynamic coverId, String size) {
    if (coverId == null) return null;
    return 'https://covers.openlibrary.org/b/id/$coverId-$size.jpg';
  }
}

// Section Header Component
class SectionHeader extends StatelessWidget {
  final String title;
  final VoidCallback onSeeAll;

  const SectionHeader({
    Key? key,
    required this.title,
    required this.onSeeAll,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        GestureDetector(
          onTap: onSeeAll,
          child: Row(
            children: [
              Text(
                'Xem tất cả',
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                ),
              ),
              const SizedBox(width: 4),
              Icon(
                Icons.arrow_forward_ios,
                size: 12,
                color: Theme.of(context).primaryColor,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// Book Card Components
class RelatedBookCard extends StatelessWidget {
  final String title;
  final String author;
  final Color color;
  final VoidCallback onTap;
  final String? coverUrl;

  const RelatedBookCard({
    Key? key,
    required this.title,
    required this.author,
    required this.color,
    required this.onTap,
    this.coverUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 120,
        margin: const EdgeInsets.only(right: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 120,
              height: 160,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: coverUrl != null
                  ? ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  coverUrl!,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Center(
                      child: Text(
                        title.split(' ').take(2).join('\n'),
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    );
                  },
                ),
              )
                  : Center(
                child: Text(
                  title.split(' ').take(2).join('\n'),
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            if (author.isNotEmpty)
              Text(
                author,
                style: const TextStyle(fontSize: 10, color: Colors.grey),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
          ],
        ),
      ),
    );
  }
}

class AuthorBookCard extends StatelessWidget {
  final String title;
  final String author;
  final bool isPurchased;
  final String? coverUrl;

  const AuthorBookCard({
    Key? key,
    required this.title,
    required this.author,
    this.isPurchased = false,
    this.coverUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      margin: const EdgeInsets.only(right: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Container(
                width: 120,
                height: 160,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: coverUrl != null
                    ? ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    coverUrl!,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Center(
                        child: Text(
                          title.split(' ').take(2).join('\n'),
                          textAlign: TextAlign.center,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      );
                    },
                  ),
                )
                    : Center(
                  child: Text(
                    title.split(' ').take(2).join('\n'),
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              if (isPurchased)
                Positioned(
                  top: 4,
                  right: 4,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: const Text(
                      '1 THẺ FONOS',
                      style: TextStyle(color: Colors.white, fontSize: 8, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            title,
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 2),
          Text(
            author,
            style: const TextStyle(fontSize: 10, color: Colors.grey),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}

class PublisherBookCard extends StatelessWidget {
  final String title;
  final String author;
  final Color color;
  final bool isPurchased;
  final String? tokenInfo;
  final String? coverUrl;

  const PublisherBookCard({
    Key? key,
    required this.title,
    required this.author,
    required this.color,
    this.isPurchased = false,
    this.tokenInfo,
    this.coverUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textColor = color.computeLuminance() > 0.5 ? Colors.black : Colors.white;

    return Container(
      width: 120,
      margin: const EdgeInsets.only(right: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Container(
                width: 120,
                height: 160,
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: coverUrl != null
                    ? ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    coverUrl!,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Center(
                        child: Text(
                          title.split(' ').take(2).join('\n'),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: textColor,
                          ),
                        ),
                      );
                    },
                  ),
                )
                    : Center(
                  child: Text(
                    title.split(' ').take(2).join('\n'),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: textColor,
                    ),
                  ),
                ),
              ),
              if (tokenInfo != null)
                Positioned(
                  top: 4,
                  right: 4,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: tokenInfo == 'MIỄN PHÍ' ? Colors.green : Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      tokenInfo!,
                      style: const TextStyle(color: Colors.white, fontSize: 8, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            title,
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          if (author.isNotEmpty)
            Text(
              author,
              style: const TextStyle(fontSize: 10, color: Colors.grey),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
        ],
      ),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final AudiobookApiService _apiService = AudiobookApiService();
  List<Book> _trendingBooks = [];
  List<Book> _newReleases = [];
  List<Book> _featuredBooks = [];
  bool _isLoading = true;
  String _errorMessage = '';

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    setState(() {
      _isLoading = true;
      _errorMessage = '';
    });

    try {
      // Load trending books
      final trending = await _apiService.getAudiobooks(
        limit: 10,
        offset: 0,
        subject: 'fiction',
      );

      // Load new releases
      final newReleases = await _apiService.getAudiobooks(
        limit: 10,
        offset: 10,
        subject: 'bestsellers',
      );

      // Load featured books
      final featured = await _apiService.getAudiobooks(
        limit: 2,
        subject: 'popular',
      );

      // Generate random colors for books
      final List<Color> colors = [
        Colors.blue[100]!,
        Colors.purple[100]!,
        Colors.orange[100]!,
        Colors.green[100]!,
        Colors.red[100]!,
      ];

      setState(() {
        _trendingBooks = trending.map((book) => Book(
          title: book['title'] ?? 'Unknown Title',
          author: book['authors']?.isNotEmpty ? book['authors'][0]['name'] : 'Unknown Author',
          color: colors[trending.indexOf(book) % colors.length],
          coverUrl: book['cover_id'] != null ? _apiService.getCoverUrl(book['cover_id'], 'M') : null,
        )).toList();

        _newReleases = newReleases.map((book) => Book(
          title: book['title'] ?? 'Unknown Title',
          author: book['authors']?.isNotEmpty ? book['authors'][0]['name'] : 'Unknown Author',
          color: colors[newReleases.indexOf(book) % colors.length],
          coverUrl: book['cover_id'] != null ? _apiService.getCoverUrl(book['cover_id'], 'M') : null,
        )).toList();

        _featuredBooks = featured.map((book) => Book(
          title: book['title'] ?? 'Unknown Title',
          author: book['authors']?.isNotEmpty ? book['authors'][0]['name'] : 'Unknown Author',
          color: Colors.purple[100]!,
          coverUrl: book['cover_id'] != null ? _apiService.getCoverUrl(book['cover_id'], 'M') : null,
        )).toList();

        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _errorMessage = 'Failed to load audiobooks: ${e.toString()}';
        _isLoading = false;
      });
    }
  }

  // Navigate to book detail page
  void _navigateToBookDetail(BuildContext context, Book book) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const HomeDetail()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    final List<Color> colorPalette = [
      const Color(0xFF8875C7), // Purple
      const Color(0xFF5E97F6), // Blue
      const Color(0xFFFF8A65), // Orange
      const Color(0xFF4CAF50), // Green
      const Color(0xFFFF5252), // Red
      const Color(0xFFFFCA28), // Amber
    ];

    // Sample data for sections that don't use API
    final List<Podcast> podcourses = [
      Podcast(
        title: '5 Sai Lầm Đặt Giá Khi Triển Khai Trải Nghiệm Khách Hàng',
        number: '1',
      ),
      Podcast(
        title: 'Giao Tiếp Hiệu Quả',
        number: '2',
      ),
    ];

    final List<Book> collectionBooks = [
      Book(title: '100 NGỌC SÁNG TRONG CUỘC SỐNG', author: ''),
      Book(title: 'MỘT CUỐN SÁCH HAY', author: ''),
      Book(title: 'MÃ THẦN THOẠI', author: ''),
      Book(title: 'CUỘC SỐNG TƯƠI ĐẸP', author: ''),
      Book(title: 'BÁC GIỐNG CUỘC ĐỜI', author: ''),
      Book(title: 'SỨC MẠNH TIỀM THỨC', author: ''),
    ];

    final List<Book> crmBooks = [
      Book(title: 'CỦA ĐỂ CRM', author: '', tag: '1 THẺ FONOS'),
      Book(title: 'KHÁM PHÁ BÍ MẬT CỦA TÂM HỒN', author: '', tag: 'MIỄN PHÍ'),
      Book(title: 'PHONG CÁCH', author: '', tag: '1 THẺ FONOS'),
      Book(title: 'XUÂN PHƯƠNG', author: '', tag: '1 THẺ FONOS'),
      Book(title: 'PHẨM CHẤT CHÍNH MINH', author: '', tag: '1 THẺ FONOS'),
      Book(title: 'TÂM HỒN CAO THƯỢNG', author: '', tag: '1 THẺ FONOS'),
    ];

    final List<Review> reviews = [
      Review(
        bookTitle: 'Ông Trăm Tuổi Trèo Qua Cửa Sổ và Biến Mất',
        author: 'Jonas Jonasson',
        reviewerName: 'Đỗ Hoa',
        timeAgo: '3 ngày trước',
        rating: 5,
        comment: 'Dù câu chuyện thú vị nhưng không phải gu của mình. Dù cuốn sách khá thú vị khi kể về chuyện phiêu lưu của cụ Alan, khá đáng để đọc, nhưng nó không phải gu của mình.',
      ),
      Review(
        bookTitle: 'Đắc Nhân Tâm',
        author: 'Dale Carnegie',
        reviewerName: 'Nguyễn Văn A',
        timeAgo: '1 tuần trước',
        rating: 4,
        comment: 'Sách hay, nhiều bài học bổ ích về cách ứng xử và giao tiếp với mọi người xung quanh.',
      ),
      Review(
        bookTitle: 'Nhà Giả Kim',
        author: 'Paulo Coelho',
        reviewerName: 'Trần Thị B',
        timeAgo: '2 tuần trước',
        rating: 5,
        comment: 'Cuốn sách đã thay đổi cách nhìn của tôi về cuộc sống. Câu chuyện về hành trình tìm kiếm kho báu thật sự sâu sắc.',
      ),
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F7),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        toolbarHeight: 70,
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF8875C7), Color(0xFF5E97F6)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(15),
              ),
              child: const Icon(Icons.music_note, color: Colors.white, size: 18),
            ),
            const SizedBox(width: 8),
            const Text(
              'Premium',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            const Spacer(),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Icon(Icons.card_membership, color: primaryColor, size: 16),
                  const SizedBox(width: 4),
                  const Text(
                    '1 thẻ Fonos',
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(width: 4),
                  const Icon(Icons.arrow_drop_down, size: 16),
                ],
              ),
            ),
            const SizedBox(width: 12),
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: const CircleAvatar(
                radius: 18,
                backgroundColor: Colors.grey,
                backgroundImage: NetworkImage('https://randomuser.me/api/portraits/men/1.jpg'),
              ),
            ),
          ],
        ),
      ),

      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _errorMessage.isNotEmpty
          ? AudiobookErrorHandler(
        message: _errorMessage,
        onRetry: _loadData,
      )
          : SafeArea(
        child: RefreshIndicator(
          onRefresh: _loadData,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Category tabs
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    children: [
                      _buildCategoryTab('Mới & Hot', true, primaryColor),
                      const SizedBox(width: 10),
                      _buildCategoryTab('Ưu đãi', false, primaryColor),
                    ],
                  ),
                ),

                // Featured book carousel with navigation
                GestureDetector(
                  onTap: () {
                    if (_featuredBooks.isNotEmpty) {
                      _navigateToBookDetail(context, _featuredBooks[0]);
                    }
                  },
                  child: FeaturedBookCarousel(books: _featuredBooks),
                ),

                // Top trending audiobooks section
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: SectionHeader(
                    title: 'Top Sách Nói Thịnh Hành',
                    onSeeAll: () {},
                  ),
                ),

                // Top books horizontal list with navigation
                SizedBox(
                  height: 120,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    itemCount: _trendingBooks.length,
                    itemBuilder: (context, index) {
                      final book = _trendingBooks[index];
                      return GestureDetector(
                        onTap: () => _navigateToBookDetail(context, book),
                        child: _buildTopBook(
                          (index + 1).toString(),
                          book.title,
                          book.author,
                          book.color,
                          coverUrl: book.coverUrl,
                        ),
                      );
                    },
                  ),
                ),

                // Podcourse section
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 12,
                            backgroundColor: primaryColor.withOpacity(0.7),
                            child: const Icon(Icons.mic, color: Colors.white, size: 14),
                          ),
                          const SizedBox(width: 8),
                          const Text(
                            'PODCOURSE',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Row(
                          children: [
                            const Text('Top thịnh hành hôm nay', style: TextStyle(fontSize: 12, color: Colors.grey)),
                            const SizedBox(width: 4),
                            const Icon(Icons.arrow_forward_ios, size: 14),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                // Podcourse horizontal list with navigation
                SizedBox(
                  height: 180,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    itemCount: podcourses.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () => _navigateToBookDetail(context, Book(title: podcourses[index].title, author: '')),
                        child: _buildPodcourse(
                          podcourses[index].number,
                          podcourses[index].title,
                          primaryColor: primaryColor,
                        ),
                      );
                    },
                  ),
                ),

                // Fonos collection
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: SectionHeader(
                    title: 'Fonos Đoán Gu Bạn Là...',
                    onSeeAll: () {},
                  ),
                ),

                // Book collection horizontal list with navigation
                SizedBox(
                  height: 220,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    itemCount: collectionBooks.length,
                    itemBuilder: (context, index) {
                      return RelatedBookCard(
                        title: collectionBooks[index].title,
                        author: collectionBooks[index].author,
                        color: Colors.white,
                        onTap: () => _navigateToBookDetail(context, collectionBooks[index]),
                      );
                    },
                  ),
                ),

                // CRM section
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: SectionHeader(
                    title: 'Cảm Nhận Quà Giọng Tác Giả',
                    onSeeAll: () {},
                  ),
                ),

                // CRM books horizontal list with navigation
                SizedBox(
                  height: 220,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    itemCount: crmBooks.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () => _navigateToBookDetail(context, crmBooks[index]),
                        child: PublisherBookCard(
                          title: crmBooks[index].title,
                          author: crmBooks[index].author,
                          color: index % 2 == 0 ? Colors.black : const Color(0xFFFFE082),
                          isPurchased: true,
                          tokenInfo: crmBooks[index].tag,
                        ),
                      );
                    },
                  ),
                ),

                // Book review section
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: SectionHeader(
                    title: 'Đánh Giá Nổi Bật',
                    onSeeAll: () {},
                  ),
                ),

                // Book reviews horizontal list with navigation
                SizedBox(
                  height: 240,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    itemCount: reviews.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () => _navigateToBookDetail(
                            context,
                            Book(
                              title: reviews[index].bookTitle,
                              author: reviews[index].author,
                            )
                        ),
                        child: _buildReviewCard(
                          reviews[index].bookTitle,
                          reviews[index].author,
                          reviews[index].reviewerName,
                          reviews[index].timeAgo,
                          reviews[index].rating,
                          reviews[index].comment,
                          primaryColor: primaryColor,
                        ),
                      );
                    },
                  ),
                ),

                // Recently published section
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: SectionHeader(
                    title: 'Mới Xuất Bản',
                    onSeeAll: () {},
                  ),
                ),

                // Recently published books with navigation
                SizedBox(
                  height: 220,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    itemCount: _newReleases.length,
                    itemBuilder: (context, index) {
                      final book = _newReleases[index];
                      return GestureDetector(
                        onTap: () => _navigateToBookDetail(context, book),
                        child: AuthorBookCard(
                          title: book.title,
                          author: book.author,
                          isPurchased: true,
                          coverUrl: book.coverUrl,
                        ),
                      );
                    },
                  ),
                ),

                // Categories section
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: SectionHeader(
                    title: 'Danh Mục Sách Nói',
                    onSeeAll: () {},
                  ),
                ),

                // Category list
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: Wrap(
                    spacing: 12,
                    runSpacing: 12,
                    children: [
                      _buildCategory('Tâm lý học', Icons.psychology, primaryColor),
                      _buildCategory('Kỹ năng', Icons.lightbulb, primaryColor),
                      _buildCategory('Tư duy', Icons.emoji_objects, primaryColor),
                      _buildCategory('Tâm linh - Tôn giáo', Icons.auto_awesome, primaryColor),
                      _buildCategory('Văn học', Icons.book, primaryColor),
                      _buildCategory('Kinh doanh', Icons.business, primaryColor),
                    ],
                  ),
                ),

                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: primaryColor,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Trang chủ'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Tìm kiếm'),
          BottomNavigationBarItem(icon: Icon(Icons.library_books), label: 'Thư viện'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Cá nhân'),
        ],
      ),
    );
  }
}

  // Widget building methods
  Widget _buildCategoryTab(String title, bool isActive, Color primaryColor) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        gradient: isActive
            ? const LinearGradient(
          colors: [Color(0xFF8875C7), Color(0xFF5E97F6)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        )
            : null,
        color: isActive ? null : Colors.grey[200],
        borderRadius: BorderRadius.circular(20),
        boxShadow: isActive
            ? [
          BoxShadow(
            color: const Color(0xFF8875C7).withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ]
            : null,
      ),
      child: Text(
        title,
        style: TextStyle(
          color: isActive ? Colors.white : Colors.black87,
          fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
          fontSize: 13,
        ),
      ),
    );
  }

  Widget _buildTopBook(String number, String title, String author, Color color, {String? coverUrl}) {
    return Container(
      width: 120,
      margin: const EdgeInsets.only(right: 12),
      child: Row(
        children: [
          Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [color, color.withOpacity(0.7)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: color.withOpacity(0.3),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            alignment: Alignment.center,
            child: Text(
              number,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: color.withOpacity(0.2),
                        blurRadius: 6,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: coverUrl != null
                      ? ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      coverUrl,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Center(
                          child: Icon(Icons.book, color: color),
                        );
                      },
                    ),
                  )
                      : Center(
                    child: Icon(Icons.book, color: color),
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  title,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  author,
                  style: const TextStyle(fontSize: 10, color: Colors.grey),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPodcourse(String number, String title, {String? imageUrl, required Color primaryColor}) {
    return Container(
      width: 160,
      margin: const EdgeInsets.only(right: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Container(
                width: 160,
                height: 120,
                decoration: BoxDecoration(
                  color: primaryColor.withOpacity(0.8),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: imageUrl != null
                    ? ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    imageUrl,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return const Center(
                        child: Icon(Icons.person, color: Colors.white, size: 40),
                      );
                    },
                  ),
                )
                    : const Center(
                  child: Icon(Icons.person, color: Colors.white, size: 40),
                ),
              ),
              Positioned(
                top: 8,
                left: 8,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.7),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: const Row(
                    children: [
                      Icon(Icons.podcasts, color: Colors.white, size: 12),
                      SizedBox(width: 2),
                      Text('PodCourse', style: TextStyle(color: Colors.white, fontSize: 10)),
                    ],
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Colors.transparent, Colors.black.withOpacity(0.7)],
                    ),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 24,
                        height: 24,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(Icons.play_arrow, size: 16),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReviewCard(String bookTitle, String author, String reviewerName, String timeAgo, int rating, String comment, {required Color primaryColor}) {
    return Container(
      width: 320,
      margin: const EdgeInsets.only(right: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.15),
            spreadRadius: 2,
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxHeight: 240),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Book info section
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 70,
                  height: 100,
                  decoration: BoxDecoration(
                    color: primaryColor.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: primaryColor.withOpacity(0.1),
                        spreadRadius: 1,
                        blurRadius: 3,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Icon(Icons.book, color: primaryColor, size: 32),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        bookTitle,
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 6),
                      Text(
                        author,
                        style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Reviewer info section
            Row(
              children: [
                CircleAvatar(
                  radius: 16,
                  backgroundColor: const Color(0xFFF5F5F7),
                  child: const Icon(Icons.person, size: 20, color: Colors.grey),
                ),
                const SizedBox(width: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                        reviewerName,
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)
                    ),
                    Text(
                        timeAgo,
                        style: TextStyle(fontSize: 12, color: Colors.grey[600])
                    ),
                  ],
                ),
                const Spacer(),
                Row(
                  children: List.generate(
                    rating,
                        (index) => const Icon(Icons.star, color: Colors.amber, size: 16),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),

            // Comment section - using Expanded to take available space
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: Text(
                    comment,
                    style: TextStyle(fontSize: 14, height: 1.4, color: Colors.grey[800]),
                  ),
                ),
              ),
            ),

            // "Xem thêm" button
            Align(
              alignment: Alignment.centerRight,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: primaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                    'Xem thêm',
                    style: TextStyle(color: primaryColor, fontSize: 12, fontWeight: FontWeight.w500)
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategory(String title, IconData icon, Color primaryColor) {
    return Container(
      width: 100,
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [primaryColor, primaryColor.withOpacity(0.7)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: primaryColor.withOpacity(0.3),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Icon(icon, color: Colors.white, size: 24),
          ),
          const SizedBox(height: 8),
          Text(
            title,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

class FeaturedBookCarousel extends StatefulWidget {
  final List<Book> books;

  const FeaturedBookCarousel({
    Key? key,
    required this.books,
  }) : super(key: key);

  @override
  State<FeaturedBookCarousel> createState() => _FeaturedBookCarouselState();
}

class _FeaturedBookCarouselState extends State<FeaturedBookCarousel> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.books.isEmpty) {
      return const SizedBox(
        height: 200,
        child: Center(
          child: Text('No featured books available'),
        ),
      );
    }

    return Column(
      children: [
        SizedBox(
          height: 200,
          child: PageView.builder(
            controller: _pageController,
            itemCount: widget.books.length,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
            },
            itemBuilder: (context, index) {
              return FeaturedBookCard(book: widget.books[index]);
            },
          ),
        ),
        if (widget.books.length > 1)
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                widget.books.length,
                    (index) => Container(
                  width: 8,
                  height: 8,
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _currentPage == index
                        ? const Color(0xFF8875C7) // Purple accent color
                        : Colors.grey.withOpacity(0.3),
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}

class FeaturedBookCard extends StatelessWidget {
  final Book book;

  const FeaturedBookCard({
    Key? key,
    required this.book,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Container(
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFF8875C7), Color(0xFF6A5CB8)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF8875C7).withOpacity(0.3),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Stack(
          children: [
            // Decorative elements
            Positioned(
              right: -20,
              top: -20,
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
              ),
            ),
            Positioned(
              left: -15,
              bottom: -15,
              child: Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
              ),
            ),

            // Book cover on the left
            Positioned(
              left: 16,
              top: 16,
              bottom: 16,
              child: Container(
                width: 100,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFFFFF9C4), Color(0xFFFFECB3)],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: book.coverUrl != null && book.coverUrl!.isNotEmpty
                    ? ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    book.coverUrl!,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return _buildDefaultCover();
                    },
                  ),
                )
                    : _buildDefaultCover(),
              ),
            ),

            // Book details
            Positioned(
              left: 132,
              top: 24,
              right: 16,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    book.title.toUpperCase(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      letterSpacing: 0.5,
                      shadows: [
                        Shadow(
                          color: Colors.black26,
                          offset: Offset(0, 2),
                          blurRadius: 4,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    book.author,
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.9),
                      fontSize: 14,
                      letterSpacing: 0.3,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Text(
                      'Khám phá ngay',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Play button
            Positioned(
              right: 16,
              bottom: 16,
              child: Container(
                padding: const EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF4A3B89), Color(0xFF362A66)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.play_arrow,
                  color: Colors.white,
                  size: 28,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDefaultCover() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                book.title.toUpperCase(),
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.brown,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                  letterSpacing: 0.5,
                ),
              ),
            ),
          ),
        ),
        // Audio badge with only bottom left and bottom right rounded corners
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 5),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.black.withOpacity(0.6), Colors.black.withOpacity(0.8)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(12),
              bottomRight: Radius.circular(12),
            ),
          ),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.headphones,
                color: Colors.white,
                size: 10,
              ),
              SizedBox(width: 4),
              Text(
                'SÁCH NÓI MỚI',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 8,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.5,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class AudiobookErrorHandler extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const AudiobookErrorHandler({
    Key? key,
    required this.message,
    required this.onRetry,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error_outline, size: 48, color: Colors.red),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Text(
              message,
              style: const TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: onRetry,
            child: const Text('Thử lại'),
          ),
        ],
      ),
    );
  }
}