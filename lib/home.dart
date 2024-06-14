import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Las más vendidas de Nike'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          children: const [
            ProductCard(
              image: 'Img/air-force.png',
              name: 'Nike Air Force 1',
              price: '\$100.00',
              colors: 'Blanco, Negro',
            ),
            ProductCard(
              image: 'Img/air-max-270.png',
              name: 'Nike Air Max 270',
              price: '\$150.00',
              colors: 'Rojo, Azul, Negro',
            ),
            ProductCard(
              image: 'Img/air-max-90.jpg',
              name: 'Nike Air Max 90',
              price: '\$120.00',
              colors: 'Blanco, Gris, Negro',
            ),
            ProductCard(
              image: 'Img/air-jordan-1.png',
              name: 'Nike Air Jordan 1',
              price: '\$160.00',
              colors: 'Rojo, Blanco, Negro',
            ),
            ProductCard(
              image: 'Img/blazer.png',
              name: 'Nike Blazer',
              price: '\$110.00',
              colors: 'Blanco, Negro',
            ),
            ProductCard(
              image: 'Img/react-infinity-3.png',
              name: 'Nike React Infinity',
              price: '\$140.00',
              colors: 'Azul, Blanco, Negro',
            ),
            ProductCard(
              image: 'Img/pegasus.png',
              name: 'Nike Pegasus',
              price: '\$130.00',
              colors: 'Verde, Azul, Negro',
            ),
            ProductCard(
              image: 'Img/zoom-fly.png',
              name: 'Nike Zoom Fly',
              price: '\$170.00',
              colors: 'Amarillo, Negro',
            ),
            ProductCard(
              image: 'Img/vapor-max.jpeg',
              name: 'Nike Vapor Max',
              price: '\$180.00',
              colors: 'Blanco, Negro',
            ),
          ],
        ),
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  final String image;
  final String name;
  final String price;
  final String colors;

  const ProductCard({
    super.key,
    required this.image,
    required this.name,
    required this.price,
    required this.colors,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(4),
                topRight: Radius.circular(4),
              ),
              child: Image.asset(
                image,
                fit: BoxFit.cover,
                width: double.infinity,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              name,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              price,
              style: const TextStyle(fontSize: 14, color: Colors.grey),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Colores: $colors',
              style: const TextStyle(fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }
}
