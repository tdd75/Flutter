import 'package:flutter/material.dart';

import './models/category.dart';
import './models/meal.dart';

const DUMMY_CATEGORIES = const [
  Category(
    id: 'a1',
    title: 'Asian',
    color: Colors.purple,
  ),
  Category(
    id: 'a2',
    title: 'Vietnamese',
    color: Colors.red,
  ),
  Category(
    id: 'a3',
    title: 'American',
    color: Colors.greenAccent,
  ),
  Category(
    id: 'b1',
    title: 'Italian',
    color: Colors.deepPurpleAccent,
  ),
  Category(
    id: 'b2',
    title: 'German',
    color: Colors.yellow,
  ),
  Category(
    id: 'c1',
    title: 'Japanese',
    color: Colors.pink,
  ),
  Category(
    id: 'c1',
    title: 'British',
    color: Colors.blueAccent,
  ),
];

const DUMMY_MEALS = const [
  Meal(
    id: 'm1',
    categories: ['a1', 'a2', 'a3', 'b1', 'c1'],
    title: 'Rice Spicy',
    imageUrl:
        'https://www.rockrecipes.com/wp-content/uploads/2016/07/Spicy-Turmeric-Fried-Rice-featured-image.jpg',
    ingredients: [
      'Rice',
      'Salt',
      'Onion',
      'Chilli',
      'Rice',
      'Salt',
      'Onion',
      'Chilli',
      'Rice',
      'Salt',
      'Onion',
      'Chilli'
    ],
    steps: ['Step 1: ', 'Step 2: ', 'Step 3: ', 'Step 4: '],
    duration: 15,
    complexity: Complexity.Simple,
    affordability: Affordability.Affordable,
    isGlutenFree: true,
    isLactoseFree: false,
    isVegan: false,
    isVegetarian: false,
  ),
  Meal(
    id: 'm2',
    categories: ['a3', 'c1', 'b2', 'a1'],
    title: 'Bread',
    imageUrl:
        'https://images.immediate.co.uk/production/volatile/sites/30/2020/08/processed-food700-350-e6d0f0f.jpg?quality=90&resize=385%2C350',
    ingredients: ['Rice', 'Salt', 'Onion', 'Chilli'],
    steps: ['Step 1: ', 'Step 2: ', 'Step 3: ', 'Step 4: '],
    duration: 5,
    complexity: Complexity.Hard,
    affordability: Affordability.Pricey,
    isGlutenFree: false,
    isLactoseFree: true,
    isVegan: false,
    isVegetarian: false,
  ),
  Meal(
    id: 'm3',
    categories: ['b1', 'c2', 'c1', 'a3'],
    title: 'Vegetable',
    imageUrl:
        'https://blogs.biomedcentral.com/on-medicine/wp-content/uploads/sites/6/2019/09/iStock-1131794876.t5d482e40.m800.xtDADj9SvTVFjzuNeGuNUUGY4tm5d6UGU5tkKM0s3iPk-620x342.jpg',
    ingredients: ['Rice', 'Salt', 'Onion', 'Chilli'],
    steps: ['Step 1: ', 'Step 2: ', 'Step 3: ', 'Step 4: '],
    duration: 10,
    complexity: Complexity.Challenging,
    affordability: Affordability.Pricey,
    isGlutenFree: false,
    isLactoseFree: false,
    isVegan: false,
    isVegetarian: true,
  ),
];
