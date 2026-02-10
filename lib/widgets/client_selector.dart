import 'package:flutter/material.dart';
import 'package:iungo_application/Business-Logic/client_provider.dart';
import 'package:iungo_application/theme/app_theme.dart';
import 'package:provider/provider.dart';
import '../models/client_item.dart';

class ClientSelector extends StatefulWidget {
  const ClientSelector({super.key});

  @override
  State<ClientSelector> createState() => _ClientSelectorState();
}

class _ClientSelectorState extends State<ClientSelector> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _showClientDropdown(BuildContext context) {
    final clientProvider = Provider.of<ClientProvider>(context, listen: false);

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => _ClientDropdownContent(
        searchController: _searchController,
        onClientSelected: (client) {
          clientProvider.selectClient(client);
          Navigator.pop(context);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ClientProvider>(
      builder: (context, clientProvider, _) {
        return GestureDetector(
          onTap: () => _showClientDropdown(context),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: BoxDecoration(
              color: AppTheme.white,
              border: Border.all(color: AppTheme.lightNeutral200),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  clientProvider.selectedClient?.name ?? 'Tap to select client',
                  style: AppTheme.h4.copyWith(
                    color: clientProvider.selectedClient != null
                        ? const Color(0xFF333333)
                        : AppTheme.gray,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(width: 8),
                Icon(Icons.keyboard_arrow_down, color: AppTheme.gray, size: 20),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _ClientDropdownContent extends StatefulWidget {
  final TextEditingController searchController;
  final Function(Client) onClientSelected;

  const _ClientDropdownContent({
    required this.searchController,
    required this.onClientSelected,
  });

  @override
  State<_ClientDropdownContent> createState() => _ClientDropdownContentState();
}

class _ClientDropdownContentState extends State<_ClientDropdownContent> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ClientProvider(),
      child: Consumer<ClientProvider>(
        builder: (context, clientProvider, _) {
          final filteredClients = clientProvider.getFilteredClients();

          return Container(
            height: MediaQuery.of(context).size.height * 0.6,
            decoration: const BoxDecoration(
              color: AppTheme.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: Column(
              children: [
                // Handle bar
                Container(
                  margin: const EdgeInsets.only(top: 12),
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: AppTheme.lightNeutral200,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),

                const SizedBox(height: 20),

                // Search bar
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppTheme.lightNeutral100,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: AppTheme.lightNeutral200),
                    ),
                    child: TextField(
                      controller: widget.searchController,
                      onChanged: (value) {
                        clientProvider.setSearchQuery(value);
                      },
                      style: AppTheme.h4.copyWith(
                        fontSize: 16,
                        color: const Color(0xFF333333),
                      ),
                      decoration: InputDecoration(
                        hintText: 'Search by client name',
                        hintStyle: AppTheme.h4.copyWith(
                          fontSize: 16,
                          color: AppTheme.gray,
                        ),
                        prefixIcon: const Icon(
                          Icons.search,
                          color: AppTheme.gray,
                          size: 24,
                        ),
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 14,
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // Divider
                const Divider(
                  height: 1,
                  thickness: 1,
                  color: AppTheme.lightNeutral200,
                ),

                // Client list
                Expanded(
                  child: filteredClients.isEmpty
                      ? Center(
                          child: Text(
                            'No clients found',
                            style: AppTheme.h4.copyWith(color: AppTheme.gray),
                          ),
                        )
                      : ListView.separated(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          itemCount: filteredClients.length,
                          separatorBuilder: (context, index) => const Divider(
                            height: 1,
                            thickness: 1,
                            color: AppTheme.lightNeutral200,
                            indent: 20,
                            endIndent: 20,
                          ),
                          itemBuilder: (context, index) {
                            final client = filteredClients[index];
                            return InkWell(
                              onTap: () => widget.onClientSelected(client),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 16,
                                ),
                                child: Text(
                                  client.name,
                                  style: AppTheme.h3.copyWith(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w400,
                                    color: const Color(0xFF333333),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
