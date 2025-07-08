// clear_cache_dialog.dart
import 'package:flutter/material.dart';
import 'package:it_agent/services/browser_cache_service.dart';

class ClearCacheDialog extends StatefulWidget {
  const ClearCacheDialog({super.key});

  @override
  State<ClearCacheDialog> createState() => _ClearCacheDialogState();
}

class _ClearCacheDialogState extends State<ClearCacheDialog> {
  final BrowserCacheService _service = BrowserCacheService();
  late Future<List<BrowserInfo>> _browsersFuture;
  String _statusMessage = '';
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _browsersFuture = _service.getInstalledBrowsers();
  }

  Future<void> _clearCache(BrowserInfo browser) async {
    setState(() {
      _isLoading = true;
      _statusMessage = 'Clearing cache for ${browser.name}...';
    });

    final success = await _service.clearCache(browser);

    setState(() {
      _isLoading = false;
      _statusMessage = success
          ? '${browser.name} cache cleared successfully ✅'
          : 'Failed to clear cache for ${browser.name} ❌';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      backgroundColor: Colors.white,
      child: SizedBox(
        width: 400,
        height: 350,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Clear Browser Cache',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.of(context).pop(),
                  )
                ],
              ),
              const SizedBox(height: 16),
              const Text('Select a browser to clear its cache:'),
              const SizedBox(height: 16),
              Expanded(
                child: FutureBuilder<List<BrowserInfo>>(
                  future: _browsersFuture,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return const Center(child: Text('No supported browsers found.'));
                    }
                    final browsers = snapshot.data!;
                    return ListView.separated(
                      itemCount: browsers.length,
                      separatorBuilder: (_, __) => const Divider(),
                      itemBuilder: (context, index) {
                        final browser = browsers[index];
                        return ListTile(
                          leading: Icon(Icons.web, color: Colors.blue),
                          title: Text(browser.name),
                          subtitle: Text(browser.cacheDirectory.path),
                          trailing: ElevatedButton(
                            onPressed: _isLoading ? null : () => _clearCache(browser),
                            child: const Text('Clear'),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
              const SizedBox(height: 8),
              if (_statusMessage.isNotEmpty)
                Text(
                  _statusMessage,
                  style: TextStyle(
                    color: _statusMessage.contains('✅')
                        ? Colors.green
                        : (_statusMessage.contains('❌') ? Colors.red : Colors.black),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
