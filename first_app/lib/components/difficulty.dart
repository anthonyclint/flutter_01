import 'package:flutter/material.dart';

class Difficulty extends StatelessWidget {

  final int hardshipLevel;

  const Difficulty({
    required this.hardshipLevel, // variável int não poderia ficar com null, portanto foi incluída a propriedade required
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(// utilizado para permitir que as estrelas fiquem em linha
      children: [
        Icon(
          Icons.star,
          size: 15,
          color: (hardshipLevel >= 1) ? Colors.blue : Colors.blue[100], //if ternário (condição) ? resultado1 : resultado2
        ),
        Icon(
          Icons.star,
          size: 15,
          color: (hardshipLevel >= 2) ? Colors.blue : Colors.blue[100],
        ),
        Icon(
          Icons.star,
          size: 15,
          color: (hardshipLevel >= 3) ? Colors.blue : Colors.blue[100],
        ),
        Icon(
          Icons.star,
          size: 15,
          color: (hardshipLevel >= 4) ? Colors.blue : Colors.blue[100],
        ),
        Icon(
          Icons.star,
          size: 15,
          color: (hardshipLevel >= 5) ? Colors.blue : Colors.blue[100],
        ),
      ],
    );
  }
}