import 'ab_packing_item_model.dart';
import 'ab_place_model.dart';
import 'ab_activity_model.dart';

// Local sample data for packing, places, and activities
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
  PlacePreview(
    id: 'colosseum-roma',
    name: 'Colosseum & Roman Forum',
    city: 'Rome',
    category: 'History',
    description: 'Ancient amphitheater and historic ruins in Rome.',
    image: 'assets/images/rome.png',
    isLocal: true,
  ),
  PlacePreview(
    id: 'trevi-fountain',
    name: 'Trevi Fountain',
    city: 'Rome',
    category: 'History',
    description: 'Iconic 18th-century fountain in the Trevi district.',
    image: 'assets/images/rome.png',
    isLocal: true,
  ),
  PlacePreview(
    id: 'vatican-museums',
    name: 'Vatican Museums and Sistine Chapel',
    city: 'Rome',
    category: 'Museum',
    description: 'World-famous museum housing classic sculptures and Renaissance art.',
    image: 'assets/images/rome.png',
    isLocal: true,
    visited: true,
  ),
];

const previewActivities = [
  ActivityPreview('Vatican Museums and Sistine Chapel', 'Museum Visit',
      'Day 1 - 09:30', 'Vatican City', 'Modest attire required',
      done: true),
  ActivityPreview('Sunset Walk at Roman Forum', 'Walking Tour',
      'Day 2 - 18:00', 'Via della Salara Vecchia', 'Wear comfortable shoes'),
  ActivityPreview('Trastevere Food Tasting', 'Food Experience',
      'Day 3 - 19:30', 'Piazza di Santa Maria in Trastevere',
      'Cash required for small cafes'),
];
