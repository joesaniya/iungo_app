import 'package:flutter/material.dart';
import 'package:iungo_application/Business-Logic/client_provider.dart';
import 'package:iungo_application/theme/app_theme.dart';
import 'package:iungo_application/theme/app_colors.dart';
import 'package:provider/provider.dart';
import '../models/client_item.dart';

class ClientSelector extends StatefulWidget {
  const ClientSelector({super.key});

  @override
  State<ClientSelector> createState() => _ClientSelectorState();
}

class _ClientSelectorState extends State<ClientSelector> {
  final TextEditingController _searchController = TextEditingController();
  OverlayEntry? _overlayEntry;
  final LayerLink _layerLink = LayerLink();
  bool _isOpen = false;
  bool _isDisposed = false;

  @override
  void dispose() {
    _isDisposed = true;
    _removeOverlay();
    _searchController.dispose();
    super.dispose();
  }

  void _removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;

    // Only clear if controller is not disposed
    if (!_isDisposed && mounted) {
      _searchController.clear();
      setState(() {
        _isOpen = false;
      });
    }
  }

  void _toggleDropdown(BuildContext context) {
    if (_overlayEntry != null) {
      _removeOverlay();
      return;
    }

    setState(() {
      _isOpen = true;
    });

    final clientProvider = Provider.of<ClientProvider>(context, listen: false);
    clientProvider.clearSearch();

    _overlayEntry = _createOverlayEntry(context);
    Overlay.of(context).insert(_overlayEntry!);
  }

  OverlayEntry _createOverlayEntry(BuildContext context) {
    final RenderBox renderBox = context.findRenderObject() as RenderBox;
    final size = renderBox.size;
    final offset = renderBox.localToGlobal(Offset.zero);

    return OverlayEntry(
      builder: (context) => Stack(
        children: [
          // Semi-transparent overlay to disable background
          Positioned.fill(
            child: GestureDetector(
              onTap: _removeOverlay,
              child: Container(color: Colors.black.withOpacity(0.2)),
            ),
          ),
          // Dropdown positioned below the selector
          Positioned(
            left: 20,
            right: 20,
            top: offset.dy + size.height + 8,
            child: Material(
              color: Colors.transparent,
              child: Container(
                constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height * 0.4,
                ),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: AppTheme.elevation9,
                ),
                child: _ClientDropdownContent(
                  searchController: _searchController,
                  onClientSelected: (client) {
                    final clientProvider = Provider.of<ClientProvider>(
                      context,
                      listen: false,
                    );
                    clientProvider.selectClient(client);
                    _removeOverlay();
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _layerLink,
      child: Consumer<ClientProvider>(
        builder: (context, clientProvider, _) {
          return GestureDetector(
            onTap: () => _toggleDropdown(context),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              decoration: BoxDecoration(
                color: AppColors.white,
                border: Border.all(color: AppColors.border),
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.08),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    clientProvider.selectedClient?.name ??
                        'Tap to select client',
                    style: AppTheme.h5Light.copyWith(
                      color: clientProvider.selectedClient != null
                          ? AppColors.textPrimary
                          : AppColors.textDisabled,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Icon(
                    Icons.keyboard_arrow_down,
                    color: AppColors.textDisabled,
                    size: 20,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  bool get isOpen => _isOpen;
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
    return Consumer<ClientProvider>(
      builder: (context, clientProvider, _) {
        final filteredClients = clientProvider.getFilteredClients();

        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Search bar
            Padding(
              padding: const EdgeInsets.all(16),
              child: Container(
                height: 44,
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: AppColors.border),
                ),
                child: Row(
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(left: 14, right: 10),
                      child: Icon(
                        Icons.search,
                        color: AppColors.textDisabled,
                        size: 20,
                      ),
                    ),
                    Expanded(
                      child: TextField(
                        controller: widget.searchController,
                        onChanged: (value) {
                          clientProvider.setSearchQuery(value);
                        },
                        style: AppTheme.pStrong.copyWith(
                          color: AppColors.textPrimary,
                          height: 1.4,
                        ),
                        decoration: InputDecoration(
                          hintText: 'Search by client name',
                          hintStyle: AppTheme.pStrong.copyWith(
                            color: AppColors.textDisabled,
                            height: 1.4,
                          ),
                          border: InputBorder.none,
                          isDense: true,
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 12,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 14),
                  ],
                ),
              ),
            ),

            // Divider
            Container(height: 1, color: AppColors.border),

            // Client list
            Flexible(
              child: filteredClients.isEmpty
                  ? Padding(
                      padding: const EdgeInsets.all(20),
                      child: Text(
                        'No clients found',
                        style: AppTheme.pStrong.copyWith(
                          color: AppColors.textDisabled,
                        ),
                      ),
                    )
                  : ListView.separated(
                      shrinkWrap: true,
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      itemCount: filteredClients.length,
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 1),
                      itemBuilder: (context, index) {
                        final client = filteredClients[index];
                        return InkWell(
                          onTap: () => widget.onClientSelected(client),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 12,
                            ),
                            child: Text(
                              client.name,
                              style: AppTheme.pStrong.copyWith(
                                color: const Color(0xFF354252),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        );
      },
    );
  }
}

/*import 'package:flutter/material.dart';
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
  OverlayEntry? _overlayEntry;
  final LayerLink _layerLink = LayerLink();
  bool _isOpen = false;

  @override
  void dispose() {
    _searchController.dispose();
    _removeOverlay();
    super.dispose();
  }

  void _removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
    _searchController.clear();
    setState(() {
      _isOpen = false;
    });
  }

  void _toggleDropdown(BuildContext context) {
    if (_overlayEntry != null) {
      _removeOverlay();
      return;
    }

    setState(() {
      _isOpen = true;
    });

    final clientProvider = Provider.of<ClientProvider>(context, listen: false);
    clientProvider.clearSearch();

    _overlayEntry = _createOverlayEntry(context);
    Overlay.of(context).insert(_overlayEntry!);
  }

  OverlayEntry _createOverlayEntry(BuildContext context) {
    final RenderBox renderBox = context.findRenderObject() as RenderBox;
    final size = renderBox.size;
    final offset = renderBox.localToGlobal(Offset.zero);

    return OverlayEntry(
      builder: (context) => Stack(
        children: [
          // Semi-transparent overlay to disable background
          Positioned.fill(
            child: GestureDetector(
              onTap: _removeOverlay,
              child: Container(color: Colors.black.withOpacity(0.2)),
            ),
          ),
          // Dropdown positioned below the selector
          Positioned(
            left: 20,
            right: 20,
            top: offset.dy + size.height + 8,
            child: Material(
              color: Colors.transparent,
              child: Container(
                constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height * 0.4,
                ),
                decoration: BoxDecoration(
                  color: AppTheme.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: AppTheme.elevation9,
                ),
                child: _ClientDropdownContent(
                  searchController: _searchController,
                  onClientSelected: (client) {
                    final clientProvider = Provider.of<ClientProvider>(
                      context,
                      listen: false,
                    );
                    clientProvider.selectClient(client);
                    _removeOverlay();
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _layerLink,
      child: Consumer<ClientProvider>(
        builder: (context, clientProvider, _) {
          return GestureDetector(
            onTap: () => _toggleDropdown(context),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              decoration: BoxDecoration(
                color: AppTheme.white,
                border: Border.all(color: AppTheme.lightNeutral200),
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.08),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    clientProvider.selectedClient?.name ??
                        'Tap to select client',
                    style: AppTheme.h5Light.copyWith(
                      color: clientProvider.selectedClient != null
                          ? const Color(0xFF333333)
                          : AppTheme.gray,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Icon(
                    Icons.keyboard_arrow_down,
                    color: AppTheme.gray,
                    size: 20,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  bool get isOpen => _isOpen;
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
    return Consumer<ClientProvider>(
      builder: (context, clientProvider, _) {
        final filteredClients = clientProvider.getFilteredClients();

        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Search bar
            Padding(
              padding: const EdgeInsets.all(16),
              child: Container(
                height: 44,
                decoration: BoxDecoration(
                  color: AppTheme.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: AppTheme.lightNeutral200),
                ),
                child: Row(
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(left: 14, right: 10),
                      child: Icon(Icons.search, color: AppTheme.gray, size: 20),
                    ),
                    Expanded(
                      child: TextField(
                        controller: widget.searchController,
                        onChanged: (value) {
                          clientProvider.setSearchQuery(value);
                        },
                        style: AppTheme.pStrong.copyWith(
                          color: const Color(0xFF333333),
                          height: 1.4,
                        ),
                        decoration: InputDecoration(
                          hintText: 'Search by client name',
                          hintStyle: AppTheme.pStrong.copyWith(
                            color: AppTheme.gray,
                            height: 1.4,
                          ),
                          border: InputBorder.none,
                          isDense: true,
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 12,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 14),
                  ],
                ),
              ),
            ),

            // Divider
            Container(height: 1, color: AppTheme.lightNeutral200),

            // Client list
            Flexible(
              child: filteredClients.isEmpty
                  ? Padding(
                      padding: const EdgeInsets.all(20),
                      child: Text(
                        'No clients found',
                        style: AppTheme.pStrong.copyWith(color: AppTheme.gray),
                      ),
                    )
                  : ListView.separated(
                      shrinkWrap: true,
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      itemCount: filteredClients.length,
                      separatorBuilder: (context, index) => SizedBox(height: 1),
                      itemBuilder: (context, index) {
                        final client = filteredClients[index];
                        return InkWell(
                          onTap: () => widget.onClientSelected(client),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 12,
                            ),
                            child: Text(
                              client.name,
                              style: AppTheme.pStrong.copyWith(
                                color: const Color(0xFF354252),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        );
      },
    );
  }
}

*/
