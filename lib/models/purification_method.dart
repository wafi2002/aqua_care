import 'package:flutter/material.dart';

class PurificationMethod {
  final String name;
  final IconData icon;
  final String description;
  final String videoPath;
  final List<String> steps; // New field for steps

  PurificationMethod({
    required this.name,
    required this.icon,
    required this.description,
    required this.videoPath,
    required this.steps, // Add steps to the constructor
  });
}

List<PurificationMethod> purificationMethods = [
  PurificationMethod(
    name: 'Boiling',
    icon: Icons.local_fire_department,
    description: 'Boiling is one of the simplest and most effective methods to purify water. By heating water to its boiling point, most harmful microorganisms like bacteria, viruses, and parasites are killed. This method is especially useful during emergencies or when other purification methods are unavailable.',
    videoPath: 'https://www.youtube.com/watch?v=K5j12tvXeA0&t=19s',
    steps: [
      'Gather water in a clean pot.',
      'Place the pot on a heat source and bring the water to a rolling boil.',
      'Let it boil for at least one minute (or three minutes at high altitudes).',
      'Allow the water to cool before drinking.',
      'Store the water in a clean, covered container.'
    ],
  ),
  PurificationMethod(
    name: 'Solar Disinfection',
    icon: Icons.wb_sunny,
    description: 'Solar disinfection (SODIS) uses the sun’s UV radiation to kill harmful microorganisms in water. It is a low-cost, eco-friendly method best suited for small quantities of clear water in sunny climates. Transparent bottles play a crucial role in this process.',
    videoPath: 'https://www.youtube.com/watch?v=J9MqzlMJOkQ&t=14s',
    steps: [
      'Fill transparent plastic or glass bottles with water.',
      'Ensure the water is free of sediment (filter if needed).',
      'Place the bottles in direct sunlight for 6-8 hours.',
      'If cloudy, extend exposure time to 2 days.',
      'Store disinfected water in a clean container.'
    ],
  ),
  PurificationMethod(
    name: 'Reverse Osmosis',
    icon: Icons.wb_sunny,
    description: 'Reverse osmosis (RO) is an advanced purification method that forces water through a semi-permeable membrane, removing impurities such as salts, heavy metals, and chemicals. It provides high-quality drinking water but requires a specialized unit and maintenance.',
    videoPath: 'https://www.youtube.com/watch?v=djhhGwJb4VA',
    steps: [
      'Install a reverse osmosis (RO) unit.',
      'Connect the unit to a water source.',
      'Allow the water to pass through the RO membrane.',
      'Collect purified water from the outlet.',
      'Regularly maintain and clean the RO unit for optimal performance.'
    ],
  ),
  PurificationMethod(
    name: 'Chlorination',
    icon: Icons.wb_sunny,
    description: 'Chlorination involves adding chlorine-based substances to water, effectively killing bacteria, viruses, and other harmful microorganisms. This method is widely used for large-scale water treatment and is an affordable way to ensure safe drinking water.',
    videoPath: 'https://www.youtube.com/watch?v=qjmCOYyIy4E',
    steps: [
      'Add chlorine tablets or liquid bleach to the water.',
      'Follow the manufacturer’s instructions for the correct dosage.',
      'Stir the water thoroughly to ensure even distribution.',
      'Let the water sit for at least 30 minutes.',
      'Store treated water in a clean, covered container.'
    ],
  ),
  PurificationMethod(
    name: 'Filtration',
    icon: Icons.wb_sunny,
    description: 'Filtration is a mechanical process that removes particles, sediments, and impurities from water. Using sand, ceramic, or activated carbon filters, this method is effective for improving water clarity and taste, though it may not eliminate all microorganisms.',
    videoPath: 'https://www.youtube.com/watch?v=3uzXeCnzf0c',
    steps: [
      'Set up a filtration system (e.g., sand, ceramic, or activated carbon).',
      'Pour water through the filter.',
      'Collect the filtered water in a clean container.',
      'Ensure the filter is clean and maintained regularly.',
      'Repeat the process if necessary for highly turbid water.'
    ],
  ),
  PurificationMethod(
    name: 'Plant-Based Filtration',
    icon: Icons.wb_sunny,
    description: 'Plant-based filtration uses natural coagulants like Moringa seeds to purify water. These natural substances bind impurities, making them easier to filter out. This sustainable method is ideal for regions with limited access to industrial purification methods.',
    videoPath: 'https://www.youtube.com/watch?v=nSBwJNDDUfc',
    steps: [
      'Crush Moringa seeds into a powder.',
      'Mix the powder into the water and stir thoroughly.',
      'Let the water sit for an hour to allow impurities to settle.',
      'Filter the water through a clean cloth.',
      'Store the filtered water in a clean container.'
    ],
  ),
];

