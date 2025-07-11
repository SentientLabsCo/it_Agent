/* 
This is a Dart service class for managing browser cache.
It provides functionality to find installed browsers, clear their cache, and retrieve browser information.
It supports multiple platforms including Windows, macOS, and Linux.
Author: [Arpit Raghuvanshi]
*/

import 'dart:io';
import 'package:path/path.dart' as p;


class BrowserInfo {
  final String name;
  final Directory cacheDirectory;
  

  BrowserInfo({
    required this.name,
    required this.cacheDirectory,
  });
}

class BrowserCacheService{
  final String userHome = Platform.environment['HOME'] ?? Platform.environment['USERPROFILE'] ?? '';
  
  Future<List<BrowserInfo>> getInstalledBrowsers () async{
    final List<BrowserInfo> browsers = [];

    if (Platform.isWindows) {
      final chromePath = p.join(userHome, 'AppData', 'Local', 'Google', 'Chrome', 'User Data');
      final edgePath = p.join(userHome, 'AppData', 'Local', 'Microsoft', 'Edge', 'User Data');
      final bravePath = p.join(userHome, 'AppData', 'Local', 'BraveSoftware', 'Brave-Browser', 'User Data');
      final firefoxPath = p.join(userHome, 'AppData', 'Roaming', 'Mozilla', 'Firefox', 'Profiles');

      browsers.addAll(await _findProfilesIn(chromePath, 'Chrome'));
      browsers.addAll(await _findProfilesIn(edgePath, 'Edge'));
      browsers.addAll(await _findProfilesIn(bravePath, 'Brave'));
      browsers.addAll(await _findFirefoxProfiles(firefoxPath, 'Firefox'));
    }else if (Platform.isMacOS) {
      final chromePath = p.join(userHome, 'Library', 'Application Support', 'Google', 'Chrome');
      final edgePath = p.join(userHome, 'Library', 'Application Support', 'Microsoft Edge');
      final bravePath = p.join(userHome, 'Library', 'Application Support', 'BraveSoftware', 'Brave-Browser');
      final firefoxPath = p.join(userHome, 'Library', 'Application Support', 'Firefox', 'Profiles');

      browsers.addAll(await _findProfilesIn(chromePath, 'Chrome'));
      browsers.addAll(await _findProfilesIn(edgePath, 'Edge'));
      browsers.addAll(await _findProfilesIn(bravePath, 'Brave'));
      browsers.addAll(await _findFirefoxProfiles(firefoxPath, 'Firefox'));
    } else if (Platform.isLinux) {
      final chromePath = p.join(userHome, '.config', 'google-chrome');
      final edgePath = p.join(userHome, '.config', 'microsoft-edge');
      final bravePath = p.join(userHome, '.config', 'BraveSoftware', 'Brave-Browser');
      final firefoxPath = p.join(userHome, '.mozilla', 'firefox');

      browsers.addAll(await _findProfilesIn(chromePath, 'Chrome'));
      browsers.addAll(await _findProfilesIn(edgePath, 'Edge'));
      browsers.addAll(await _findProfilesIn(bravePath, 'Brave'));
      browsers.addAll(await _findFirefoxProfiles(firefoxPath, 'Firefox'));
    }

    return browsers;
  }

  Future<List<BrowserInfo>> _findProfilesIn(String userDataPath, String browserName)async{
    final List<BrowserInfo> found = [];
    final userDataDirectory = Directory(userDataPath);

    print('DEBUG: Checking $browserName at path: $userDataPath');
    
    // FIX: Added the missing ! operator
    if(!await userDataDirectory.exists()) {
      print('DEBUG: $browserName directory does not exist: $userDataPath');
      return found;
    }

    print('DEBUG: $browserName directory exists, listing contents...');
    final entries = await userDataDirectory.list().toList();
    
    for(var entity in entries){
      if(entity is Directory) {
        print('DEBUG: Found directory: ${entity.path}');
        // Check for common Chrome profile patterns
        final baseName = p.basename(entity.path);
        if(baseName == 'Default' || baseName.startsWith('Profile') || baseName.contains('Profile')){
          print('DEBUG: Checking profile: $baseName');
          
          // Check multiple possible cache locations for Chrome/Edge
          final possibleCachePaths = [
            p.join(entity.path, 'Cache'),
            p.join(entity.path, 'Cache', 'Cache_Data'),
          ];
          
          List<Directory> foundCaches = [];
          
          for (final cachePath in possibleCachePaths) {
            final cacheDirectory = Directory(cachePath);
            print('DEBUG: Looking for cache at: ${cacheDirectory.path}');
            
            if (await cacheDirectory.exists()) {
              print('DEBUG: Cache found for $browserName profile: $baseName at ${cacheDirectory.path}');
              foundCaches.add(cacheDirectory);
            }
          }
          
          // If we found any cache directories, add them as separate entries
          if (foundCaches.isNotEmpty) {
            for (int i = 0; i < foundCaches.length; i++) {
              final cacheType = p.basename(foundCaches[i].path);
              final displayName = foundCaches.length > 1 
                  ? '$browserName ($baseName - $cacheType)'
                  : '$browserName ($baseName)';
              found.add(BrowserInfo(name: displayName, cacheDirectory: foundCaches[i]));
            }
          } else {
            print('DEBUG: No cache directories found for $browserName profile: $baseName');
          }
        }
      }
    }
    print('DEBUG: Found ${found.length} profiles for $browserName');
    return found;
  }

  Future<List<BrowserInfo>> _findFirefoxProfiles(String profilePath, String browserName) async {
    final List<BrowserInfo> found = [];
    final profileDir = Directory(profilePath);

    if (!await profileDir.exists()) return found;

    final entries = await profileDir.list().toList();
    for (var entity in entries) {
      if (entity is Directory) {
        final cacheDir = Directory(p.join(entity.path, 'cache2', 'entries'));
        if (await cacheDir.exists()) {
          found.add(BrowserInfo(name: '$browserName (${p.basename(entity.path)})', cacheDirectory: cacheDir));
        }
      }
    }
    return found;
  }

  Future<bool> clearCache(BrowserInfo browser) async {
    try {
      if (!await browser.cacheDirectory.exists()) return false;

      await for (var entity in browser.cacheDirectory.list(recursive: true)) {
        try {
          if (entity is File) {
            await entity.delete();
          } else if (entity is Directory) {
            await entity.delete(recursive: true);
          }
        } catch (_) {
          // Ignore deletion error per file/folder
        }
      }
      return true;
    } catch (e) {
      return false;
    }
  }
}