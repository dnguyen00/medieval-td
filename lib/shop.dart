import 'package:flutter/material.dart';

class shopScreen extends StatelessWidget {
  const shopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shop',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const shopScreen(),
    );
  }
}

class ShopScreen extends StatefulWidget {
  const ShopScreen({super.key});

  @override
  _ShopScreenState createState() => _ShopScreenState();
}

class _ShopScreenState extends State<ShopScreen> {
  int coins = 100; // Initial in-game currency
  Character character = CharacterManager.character;
  List<Item> items = [
    Item(
        name: 'Steel Chestplate',
        price: 20,
        imageUrl: 'images/steel_chestplate.png'),
    Item(
        name: 'Archer\'s Cloak',
        price: 30,
        imageUrl: 'images/archer_cloak.png'),
    Item(name: 'Golden Bow', price: 15, imageUrl: 'images/golden_bow.png'),
    // Add more items as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shop'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text('Coins: $coins'),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text('Character: ${character.toString()}'),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                return ShopItemWidget(item: items[index], onBuy: buyItem);
              },
            ),
          ),
        ],
      ),
    );
  }

  void buyItem(Item item) {
    if (coins >= item.price) {
      setState(() {
        coins -= item.price;
        applyItemToCharacter(item);
      });
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Purchase Successful'),
          content: Text('You have successfully purchased ${item.name}.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Insufficient Coins'),
          content:
              Text('You do not have enough coins to purchase ${item.name}.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  void applyItemToCharacter(Item item) {
    setState(() {
      if (item.name == 'Steel Chestplate') {
        character.equipSteelChestplate();
      } else if (item.name == 'Archer\'s Cloak') {
        character.equipArcherCloak();
      } else if (item.name == 'Golden Bow') {
        character.equipGoldenBow();
      }
      CharacterManager.updateCharacter(character);
    });
  }
}

class Item {
  final String name;
  final int price;
  final String imageUrl;

  Item({required this.name, required this.price, required this.imageUrl});
}

class ShopItemWidget extends StatelessWidget {
  final Item item;
  final Function(Item) onBuy;

  const ShopItemWidget({super.key, required this.item, required this.onBuy});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      child: ListTile(
        leading: Image.asset(
          'assets/${item.imageUrl}',
          width: 50,
          height: 50,
        ),
        title: Text(item.name),
        subtitle: Text('Price: ${item.price} coins'),
        trailing: ElevatedButton(
          onPressed: () => onBuy(item),
          child: const Text('Buy'),
        ),
      ),
    );
  }
}

class CharacterManager {
  static Character tempcharacter = Character();

  static Character get character => tempcharacter;

  static void updateCharacter(Character newCharacter) {
    tempcharacter = newCharacter;
  }
}

class Character {
  String armor = 'Default Armor';
  String bow = 'Default Bow';
  String hat = 'Default Hat';

  void equipSteelChestplate() {
    armor = 'Steel Chestplate';
  }

  void equipArcherCloak() {
    hat = 'Archer\'s Cloak';
  }

  void equipGoldenBow() {
    bow = 'Golden Bow';
  }

  @override
  String toString() {
    return 'Armor: $armor, Hat: $hat, Bow: $bow';
  }
}
