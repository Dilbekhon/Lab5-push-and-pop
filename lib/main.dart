import 'package:flutter/material.dart';

void main() {
  runApp(const LabApp());
}

class LabApp extends StatelessWidget {
  const LabApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lab 5 - Navigation & Routing',
      theme: ThemeData(primarySwatch: Colors.blue),
      initialRoute: '/',
      routes: {
        '/': (context) => const HomeScreen(),
        '/details': (context) => const DetailsScreen(),
      },
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Lab 5: Main Navigation Menu')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Выберите тип перехода для демонстрации:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),
              
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(minimumSize: const Size(250, 45)),
                icon: const Icon(Icons.arrow_forward),
                label: const Text('1. Push & Pop (Chain)'),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const ChainScreenB()),
                  );
                },
              ),
              const SizedBox(height: 15),

              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(minimumSize: const Size(250, 45)),
                icon: const Icon(Icons.alt_route),
                label: const Text('2. Named Route (/details)'),
                onPressed: () {
                  Navigator.pushNamed(context, '/details');
                },
              ),
              const SizedBox(height: 15),

              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(minimumSize: const Size(250, 45)),
                icon: const Icon(Icons.input),
                label: const Text('3. Pass Data & Get Result'),
                onPressed: () async {
                  final result = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const DataPassScreen(data: 'Привет с главного экрана!'),
                    ),
                  );
                  
                  if (context.mounted && result != null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Результат от дочернего экрана: $result')),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ChainScreenB extends StatelessWidget {
  const ChainScreenB({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Chain Screen B'), backgroundColor: Colors.green),
      body: Center(
        child: ElevatedButton(
          child: const Text('Назад на главную'),
          onPressed: () => Navigator.pop(context),
        ),
      ),
    );
  }
}

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Named Details Screen'), backgroundColor: Colors.orange),
      body: Center(
        child: ElevatedButton(
          child: const Text('Вернуться назад'),
          onPressed: () => Navigator.pop(context),
        ),
      ),
    );
  }
}

class DataPassScreen extends StatelessWidget {
  final String data;
  const DataPassScreen({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Data & Result Screen'), backgroundColor: Colors.purple),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Получено: $data', style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.teal),
              child: const Text('Вернуть результат "Успех!"'),
              onPressed: () {
                Navigator.pop(context, 'Успех!');
              },
            ),
          ],
        ),
      ),
    );
  }
}
