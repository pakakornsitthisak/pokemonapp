import 'package:flutter/material.dart';
import 'package:skinxtest/models/pokemon_tag.dart';
import 'package:skinxtest/pages/search_page.dart';
import 'package:skinxtest/pages/history_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SkinX',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentPage = 0;
  _changePage(int i) {
    setState(() {
      _currentPage = i;
    });
  }

  _addTeam(List<PokemonTag> pokemonTeam) {
    setState(() {
      _pokemonTeams.add(pokemonTeam);
    });
  }

  _removeTeam(List<PokemonTag> pokemonTeam) {
    setState(() {
      _pokemonTeams.remove(pokemonTeam);
    });
  }

  List<List<PokemonTag>> _pokemonTeams = [];
  @override
  Widget build(BuildContext context) {
    final List<Widget> _pages = [
      SearchPage(
        onAddTeam: _addTeam,
        onRemoveTeam: _removeTeam,
      ),
      HistoryPage(pokemonTeams: _pokemonTeams),
    ];
    return Scaffold(
      appBar: AppBar(
        title: _currentPage == 0 ? Text('Pokemons') : Text('History'),
      ),
      body: Padding(
        padding: EdgeInsets.all(5),
        child: Center(child: _pages[_currentPage]),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentPage,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: "home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: "history",
          ),
        ],
        onTap: (index) => _changePage(index),
      ),
    );
  }
}
