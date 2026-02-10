import 'package:flutter/material.dart';
import 'package:iungo_application/models/client_item.dart';


class ClientProvider extends ChangeNotifier {
  Client? _selectedClient;
  String _searchQuery = '';

  Client? get selectedClient => _selectedClient;
  String get searchQuery => _searchQuery;

  void selectClient(Client client) {
    _selectedClient = client;
    notifyListeners();
  }

  void setSearchQuery(String query) {
    _searchQuery = query;
    notifyListeners();
  }

  void clearSearch() {
    _searchQuery = '';
    notifyListeners();
  }

  List<Client> getFilteredClients() {
    if (_searchQuery.isEmpty) {
      return ClientConfig.clients;
    }
    
    return ClientConfig.clients
        .where((client) =>
            client.name.toLowerCase().contains(_searchQuery.toLowerCase()))
        .toList();
  }
}