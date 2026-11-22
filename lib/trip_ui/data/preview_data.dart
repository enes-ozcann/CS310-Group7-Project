import '../models/packing_item.dart';
import '../models/place.dart';
import '../models/activity.dart';

// Local sample data only; no API or database connection.
List<PackingPreviewItem> createPackingItems() => [
      PackingPreviewItem('Waterproof Jacket / Raincoat', 'Clothing',
          packed: true, suggestion: 'Weather Suggestion'),
      PackingPreviewItem('Comfortable Walking Shoes', 'Clothing',
          quantity: 2, packed: true, suggestion: 'Walking Activity Tip'),
      PackingPreviewItem('Cotton T-shirt', 'Clothing',
          quantity: 5, packed: true),
      PackingPreviewItem('Linen Trousers / Jeans', 'Clothing', quantity: 3),
      PackingPreviewItem('Powerbank', 'Electronics', packed: true),
      PackingPreviewItem('Travel Adapter', 'Electronics'),
      PackingPreviewItem('Passport and Schengen Visa', 'Documents',
          packed: true),
      PackingPreviewItem('Flight Tickets', 'Documents', packed: true),
      PackingPreviewItem('Sunscreen', 'Personal Care',
          suggestion: 'Weather Suggestion'),
      PackingPreviewItem('Personal Medication', 'Personal Care', packed: true),
      PackingPreviewItem('Travel Umbrella', 'Trip Essentials',
          packed: true, suggestion: 'Weather Suggestion'),
    ];

const previewPlaces = [
  PlacePreview('Colosseum & Roman Forum', 'History',
      'https://images.unsplash.com/photo-1552832230-c0197dd311b5?w=300'),
  PlacePreview('Trevi Fountain', 'History',
      'https://images.unsplash.com/photo-1525874684015-58379d421a52?w=300'),
  PlacePreview('Vatican Museums and Sistine Chapel', 'Museum',
      'https://images.unsplash.com/photo-1531572753322-ad063cecc140?w=300',
      visited: true),
];
const previewActivities = [
  ActivityPreview(
      'Colosseum & Roman Forum Tour',
      'Sightseeing',
      'May 11 · 10:00 - 13:30',
      'Piazza del Colosseo',
      'Comfortable walking shoes and a sun hat.'),
  ActivityPreview('Dinner in Trastevere', 'Food', 'May 11 · 19:30 - 22:00',
      'Trastevere', 'A light cardigan for the evening breeze.'),
  ActivityPreview('Vatican Museums Tour', 'Museum', 'May 12 · 09:00 - 12:30',
      'Vatican City', 'Clothing that covers shoulders and knees.',
      done: true),
  ActivityPreview('Sunset Walk by the Tiber', 'Walking',
      'May 13 · 18:00 - 20:00', 'Ponte Sant’Angelo', 'Camera and power bank.'),
];
