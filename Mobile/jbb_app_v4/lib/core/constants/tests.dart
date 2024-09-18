import 'package:jbb_app_v4/features/jewelry/models/jewelry_model.dart';

List<String> imageList = [
  "EvilEye.jpg",
  "FlatBracelet.jpg",
  "SolidRing.jpg"
];

List<JewelryModel> jewelryFeatured = [
  JewelryModel(
      id: '123',
      name: 'Moissanite Engagement Ring',
      price: 2499.99,
      description: 'Amazing',
      imageUrls: ['SolidRing.jpg', 'SolidRing2.jpg'],
      averageRating: 5.0,
      lensID: '',
      groupID: '',
      category: 'Ring',
      modelUrl: 'MoissaniteRing.glb',),
  JewelryModel(
      id: '456',
      name: 'Heart Ring',
      price: 1499.99,
      description: 'Kakoi',
      imageUrls: ['HeartRing.jpg', 'HeartRing2.jpg'],
      averageRating: 4.9,
      lensID: '',
      groupID: '',
      category: 'Ring',
      modelUrl: 'MoissaniteRing.glb',),
  JewelryModel(
      id: '789',
      name: 'Palay Bracelet',
      price: 3499.99,
      description: 'Umoshiroi',
      imageUrls: ['PalayBracelet.jpg', 'PalayBracelet2.jpg'],
      averageRating: 4.8,
      lensID: '',
      groupID: '',
      category: 'Bracelet',
      modelUrl: 'MoissaniteRing.glb',),
  JewelryModel(
      id: '111',
      name: 'Evil Eye',
      price: 5499.99,
      description: 'Gloomy',
      imageUrls: ['EvilEye.jpg', 'EvilEye2.jpg'],
      averageRating: 4.8,
      lensID: '',
      groupID: '',
      category: 'Earring',
      modelUrl: 'MoissaniteRing.glb',),
];
