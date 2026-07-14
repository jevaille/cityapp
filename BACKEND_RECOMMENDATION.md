# Backend Recommendation for CityApp News API

## Overview

The CityApp Flutter application requires a backend API to handle RSS feed fetching, processing, and serving JSON data to the mobile app. This document provides recommendations for implementing this backend.

## Architecture

```
Flutter App
    ↓ (HTTP GET /api/news)
Backend API
    ↓ (RSS Feeds)
Multiple News Sources
    ↓ (Processed JSON)
Flutter App
```

## Recommended Backend Options

### Option 1: Firebase Cloud Functions (Recommended)

**Pros:**
- Serverless, no infrastructure management
- Scalable and cost-effective for small to medium traffic
- Built-in authentication with Firebase
- Easy deployment and monitoring
- Good integration with other Firebase services

**Cons:**
- Cold starts can cause slight delays
- Limited execution time (max 9 minutes)
- Vendor lock-in

**Implementation:**
```javascript
// functions/index.js
const functions = require('firebase-functions');
const Parser = require('rss-parser');
const parser = new Parser();

exports.getNews = functions.https.onRequest(async (req, res) => {
  try {
    const feeds = [
      'https://pia.gov.ph/feed/regions/region-12',
      'https://www.brigadanews.ph/category/local-news/mindanao/gensan/feed',
      'https://www.sunstar.com.ph/rss/general-santos',
    ];

    const allArticles = [];

    for (const feedUrl of feeds) {
      try {
        const feed = await parser.parseURL(feedUrl);
        feed.items.forEach(item => {
          allArticles.push({
            id: item.link,
            title: item.title,
            summary: item.contentSnippet,
            content: item.content || item.contentSnippet,
            imageUrl: extractImage(item.content),
            source: extractSource(feedUrl),
            author: item.creator || item.author || '',
            publishedAt: item.pubDate,
            category: categorizeArticle(item.title),
            url: item.link,
            readingTime: calculateReadingTime(item.content || item.contentSnippet),
          });
        });
      } catch (error) {
        console.error(`Error fetching ${feedUrl}:`, error);
      }
    }

    // Filter for relevant articles
    const filteredArticles = allArticles.filter(article =>
      article.title.toLowerCase().includes('general santos') ||
      article.title.toLowerCase().includes('gensan') ||
      article.title.toLowerCase().includes('south cotabato') ||
      article.title.toLowerCase().includes('socsksargen')
    );

    // Remove duplicates by URL
    const uniqueArticles = removeDuplicates(filteredArticles, 'url');

    // Sort by date (newest first)
    uniqueArticles.sort((a, b) => new Date(b.publishedAt) - new Date(a.publishedAt));

    // Pagination
    const page = parseInt(req.query.page) || 1;
    const limit = parseInt(req.query.limit) || 20;
    const startIndex = (page - 1) * limit;
    const paginatedArticles = uniqueArticles.slice(startIndex, startIndex + limit);

    res.json({
      articles: paginatedArticles,
      total: uniqueArticles.length,
      page,
      limit,
      hasMore: startIndex + limit < uniqueArticles.length,
    });
  } catch (error) {
    console.error('Error:', error);
    res.status(500).json({ error: 'Failed to fetch news' });
  }
});
```

### Option 2: Node.js Express

**Pros:**
- Full control over the server
- No cold starts
- Can handle longer-running processes
- Large ecosystem of packages
- Easy to deploy to various platforms (Heroku, Vercel, AWS, etc.)

**Cons:**
- Requires server management
- Scaling requires manual configuration
- Higher cost for high traffic

**Implementation:**
```javascript
// server.js
const express = require('express');
const Parser = require('rss-parser');
const parser = new Parser();
const app = express();

app.get('/api/news', async (req, res) => {
  try {
    const { page = 1, limit = 20 } = req.query;
    
    // Fetch and process RSS feeds (similar to Firebase implementation)
    const articles = await fetchAndProcessFeeds();
    
    const startIndex = (page - 1) * limit;
    const paginatedArticles = articles.slice(startIndex, startIndex + parseInt(limit));

    res.json({
      articles: paginatedArticles,
      total: articles.length,
      page: parseInt(page),
      limit: parseInt(limit),
      hasMore: startIndex + parseInt(limit) < articles.length,
    });
  } catch (error) {
    res.status(500).json({ error: 'Failed to fetch news' });
  }
});

app.listen(3000, () => console.log('Server running on port 3000'));
```

### Option 3: Supabase Edge Functions

**Pros:**
- Serverless like Firebase
- PostgreSQL database included
- Real-time subscriptions
- Built-in authentication
- Open source

**Cons:**
- Newer platform, smaller community
- Learning curve for Supabase-specific features

**Implementation:**
```typescript
// functions/news/index.ts
import { serve } from 'https://deno.land/std@0.168.0/http/server.ts'
import Parser from 'https://esm.sh/rss-parser@3.13.0'

serve(async (req) => {
  try {
    const parser = new Parser();
    const feeds = [
      'https://pia.gov.ph/feed/regions/region-12',
      // ... other feeds
    ];

    const allArticles = [];
    
    for (const feedUrl of feeds) {
      const feed = await parser.parseURL(feedUrl);
      // Process articles...
    }

    return new Response(
      JSON.stringify({ articles: allArticles }),
      { headers: { 'Content-Type': 'application/json' } }
    );
  } catch (error) {
    return new Response(
      JSON.stringify({ error: 'Failed to fetch news' }),
      { status: 500, headers: { 'Content-Type': 'application/json' } }
    );
  }
});
```

### Option 4: PHP

**Pros:**
- Widely supported by hosting providers
- Easy to deploy on shared hosting
- Low cost
- Simple to implement for small projects

**Cons:**
- Not as modern as Node.js
- Performance limitations for high traffic
- Less suitable for real-time features

**Implementation:**
```php
// api/news.php
<?php
header('Content-Type: application/json');

require_once 'vendor/autoload.php';
use SimplePie\SimplePie;

$feeds = [
    'https://pia.gov.ph/feed/regions/region-12',
    'https://www.brigadanews.ph/category/local-news/mindanao/gensan/feed',
];

$allArticles = [];

foreach ($feeds as $feedUrl) {
    $feed = new SimplePie();
    $feed->set_feed_url($feedUrl);
    $feed->enable_cache(false);
    $feed->init();
    
    foreach ($feed->get_items() as $item) {
        $allArticles[] = [
            'id' => $item->get_permalink(),
            'title' => $item->get_title(),
            'summary' => $item->get_description(),
            // ... other fields
        ];
    }
}

// Process and return JSON
echo json_encode(['articles' => $allArticles]);
?>
```

## RSS Feed Sources

### Active Philippine News Sources

1. **Philippine Information Agency (PIA)**
   - URL: `https://pia.gov.ph/feed/regions/region-12`
   - Reliable government source
   - Covers Region 12 (SOCCSKSARGEN)

2. **Brigada News**
   - URL: `https://www.brigadanews.ph/category/local-news/mindanao/gensan/feed`
   - Local news for General Santos
   - Active and regularly updated

3. **SunStar General Santos**
   - URL: `https://www.sunstar.com.ph/rss/general-santos`
   - Regional news coverage
   - Well-established news outlet

4. **Mindanao Times**
   - URL: `https://www.mindanaotimes.com.ph/feed/`
   - Covers Mindanao region
   - Alternative source for regional news

5. **MindaNews**
   - URL: `https://www.mindanews.com/feed/`
   - Specialized Mindanao news
   - Good for in-depth coverage

### Deprecated/Unavailable Sources

- **Google News RSS**: No longer provides reliable RSS feeds for custom searches
- **Philstar RSS**: May have CORS restrictions or rate limiting

## Filtering Criteria

The backend should filter articles mentioning:
- General Santos
- GenSan
- South Cotabato
- SOCCSKSARGEN
- Region 12

## Data Processing

### Required Fields

Each article should include:
- `id`: Unique identifier (use URL)
- `title`: Article title
- `summary`: Short description
- `content`: Full article content
- `imageUrl`: Featured image URL
- `source`: News source name
- `author`: Article author (if available)
- `publishedAt`: Publication date (ISO 8601 format)
- `category`: Article category
- `url`: Article URL
- `readingTime`: Estimated reading time (e.g., "3 min read")

### Processing Steps

1. **Fetch**: Retrieve RSS feeds from all sources
2. **Parse**: Extract article data from RSS XML
3. **Filter**: Keep only relevant articles (GenSan, SOCCSKSARGEN, etc.)
4. **Deduplicate**: Remove duplicate articles by URL
5. **Sort**: Order by publication date (newest first)
6. **Categorize**: Assign categories based on keywords
7. **Calculate**: Compute reading time
8. **Paginate**: Return paginated results

### Categorization Logic

```javascript
function categorizeArticle(title) {
  const lowerTitle = title.toLowerCase();
  
  if (lowerTitle.includes('government') || lowerTitle.includes('city') || 
      lowerTitle.includes('mayor') || lowerTitle.includes('council')) {
    return 'Government';
  }
  if (lowerTitle.includes('business') || lowerTitle.includes('economy')) {
    return 'Business';
  }
  if (lowerTitle.includes('crime') || lowerTitle.includes('police')) {
    return 'Crime & Safety';
  }
  if (lowerTitle.includes('health') || lowerTitle.includes('hospital')) {
    return 'Health';
  }
  if (lowerTitle.includes('education') || lowerTitle.includes('school')) {
    return 'Education';
  }
  if (lowerTitle.includes('infrastructure') || lowerTitle.includes('project')) {
    return 'Infrastructure';
  }
  
  return 'General';
}
```

## API Endpoint Specification

### GET /api/news

**Query Parameters:**
- `page` (optional): Page number (default: 1)
- `limit` (optional): Items per page (default: 20)

**Response Format:**
```json
{
  "articles": [
    {
      "id": "unique-id",
      "title": "Article Title",
      "summary": "Short summary",
      "content": "Full content",
      "imageUrl": "https://example.com/image.jpg",
      "source": "News Source",
      "author": "Author Name",
      "publishedAt": "2024-01-15T10:30:00Z",
      "category": "Government",
      "url": "https://example.com/article",
      "readingTime": "3 min read"
    }
  ],
  "total": 100,
  "page": 1,
  "limit": 20,
  "hasMore": true
}
```

**Error Response:**
```json
{
  "error": "Failed to fetch news",
  "message": "Detailed error message"
}
```

## Caching Strategy

To improve performance and reduce API calls:

1. **Cache Duration**: Cache RSS feeds for 15-30 minutes
2. **Cache Storage**: Use Redis or in-memory cache
3. **Cache Invalidation**: Manual refresh endpoint or time-based

Example (Firebase):
```javascript
const cache = require('memory-cache');

exports.getNews = functions.https.onRequest(async (req, res) => {
  const cacheKey = 'news_articles';
  const cachedData = cache.get(cacheKey);
  
  if (cachedData) {
    return res.json(cachedData);
  }
  
  // Fetch and process feeds...
  const data = { articles: processedArticles };
  
  cache.put(cacheKey, data, 15 * 60 * 1000); // 15 minutes
  res.json(data);
});
```

## Deployment Recommendations

### For Firebase Cloud Functions:
1. Create Firebase project
2. Install Firebase CLI: `npm install -g firebase-tools`
3. Initialize: `firebase init functions`
4. Deploy: `firebase deploy --only functions`

### For Node.js Express:
1. **Heroku**: Easy deployment, free tier available
2. **Vercel**: Good for serverless functions
3. **AWS EC2**: Full control, scalable
4. **DigitalOcean**: Cost-effective VPS

### For Supabase:
1. Create Supabase project
2. Install Supabase CLI
3. Deploy edge functions

## Security Considerations

1. **CORS**: Enable CORS for your Flutter app domain
2. **Rate Limiting**: Implement rate limiting to prevent abuse
3. **Authentication**: Add API key or authentication if needed
4. **Input Validation**: Validate all query parameters
5. **Error Handling**: Don't expose sensitive error details

## Monitoring and Logging

1. **Error Tracking**: Use Sentry or similar for error monitoring
2. **Logging**: Implement structured logging
3. **Performance**: Monitor API response times
4. **Uptime**: Use uptime monitoring services

## Cost Estimates

### Firebase Cloud Functions:
- Free tier: 2M invocations/month
- Pay-as-you-go: ~$0.40 per million invocations
- Estimated monthly cost: $0-10 for small app

### Node.js (Heroku):
- Free tier: Available
- Eco dyno: $5/month
- Production dyno: $7+/month

### Supabase:
- Free tier: 500MB database, 1GB bandwidth
- Pro tier: $25/month

## Recommended Choice

**For CityApp, we recommend Firebase Cloud Functions** because:
1. Serverless - no server management
2. Scalable - grows with your user base
3. Cost-effective - free tier for small apps
4. Easy integration with Flutter
5. Built-in authentication available
6. Good documentation and community support

## Next Steps

1. Choose backend platform based on requirements
2. Set up the backend project
3. Implement RSS fetching and processing
4. Deploy to chosen platform
5. Update Flutter app with actual API base URL
6. Test end-to-end functionality
7. Set up monitoring and error tracking

## Flutter Configuration

Update the API base URL in `lib/services/news_api_service.dart`:

```dart
static const String _baseUrl = 'https://your-function-url.cloudfunctions.net';
// or
static const String _baseUrl = 'https://your-api-domain.com';
```

## Support

For implementation questions or issues, refer to:
- Firebase Cloud Functions docs
- Express.js documentation
- Supabase documentation
- RSS parser library documentation
