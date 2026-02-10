class Client {
  final String id;
  final String name;

  Client({
    required this.id,
    required this.name,
  });
}

class ClientConfig {
  static final List<Client> clients = [
    Client(id: '1', name: 'Backpath'),
    Client(id: '2', name: 'CitGo'),
    Client(id: '3', name: 'CIT Group LTD'),
    Client(id: '4', name: 'Netli'),
    Client(id: '5', name: 'Noderoad'),
    Client(id: '6', name: 'Tobi Group'),
  ];
}