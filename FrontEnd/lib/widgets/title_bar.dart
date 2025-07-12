import 'dart:io';

import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';

class TitleBar extends StatefulWidget {
  final String appName;
  final Widget? logo;
  final Color backgroundColor;
  final Color textColor;

  const TitleBar({
    super.key,
    required this.appName,
    this.logo,
    this.backgroundColor = const Color(0xFF1e1e1e),
    this.textColor = Colors.white,
  });

  @override
  State<TitleBar> createState() => _TitleBarState();
}

class _TitleBarState extends State<TitleBar> {
  bool isMaximized = false;

  @override
  void initState() {
    _checkMiximized();
    super.initState();
  }

  void _checkMiximized() async {
    final maximized = await windowManager.isMaximized();
    setState(() {
      isMaximized = maximized;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: _getTitleBarHeight(),
      color: widget.backgroundColor,
      child: Row(
        children: [
          if (Platform.isMacOS) ...[
            _buildMacOSControls(),
            _buildDraggableArea(),
          ] else ...[
            _buildDraggableArea(),
            _buildWindowsLinuxControls(),
          ],
        ],
      ),
    );
  }

  double _getTitleBarHeight() {
    if (Platform.isMacOS) {
      return 28;
    } else if (Platform.isWindows) {
      return 45;
    } else {
      return 40;
    }
  }

  Widget _buildDraggableArea() {
    return Expanded(
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onPanStart: (details) {
          windowManager.startDragging();
        },
        onDoubleTap: () {
          if (Platform.isMacOS) {
            windowManager.isMaximized().then((isMaximized) {
              if (isMaximized) {
                windowManager.unmaximize();
              } else {
                windowManager.maximize();
              }
              _checkMiximized();
            });
          } else {
            windowManager.isMaximized().then((isMaximized) {
              if (isMaximized) {
                windowManager.unmaximize();
              } else {
                windowManager.maximize();
              }
              _checkMiximized();
            });
          }
        },
        child: Row(
          children: [
            SizedBox(width: Platform.isMacOS ? 8 : 12),
            if (widget.logo != null) ...[
              SizedBox(
                width: Platform.isMacOS ? 14 : 16,
                height: Platform.isMacOS ? 14 : 16,
                child: widget.logo,
              ),
              const SizedBox(width: 8),
            ],
            Text(
              widget.appName,
              style: TextStyle(
                color: widget.textColor,
                fontSize: Platform.isMacOS ? 11 : 12,
                fontWeight: Platform.isMacOS
                    ? FontWeight.w500
                    : FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMacOSControls() {
    return Container(
      padding: const EdgeInsets.only(left: 8),
      child: Row(
        children: [
          _buildMacOSButton(
            color: Color(0xFFFF5F57),
            onPressed: () => windowManager.close(),
            icon: Icons.close,
          ),
          SizedBox(width: 8),
          _buildMacOSButton(
            color: Color(0xFFFFBD2E),
            onPressed: () => windowManager.maximize(),
            icon: Icons.minimize,
          ),

          SizedBox(width: 8),
          _buildMacOSButton(
            color: Color(0xFF28CA42),
            onPressed: () {
              windowManager.isMaximized().then((isMaximized) {
                if (isMaximized) {
                  windowManager.unmaximize();
                } else {
                  windowManager.maximize();
                }
                _checkMiximized();
              });
            },
            icon: isMaximized ? Icons.fullscreen_exit : Icons.fullscreen,
          ),
          const SizedBox(width: 16),
        ],
      ),
    );
  }

  Widget _buildMacOSButton({
    required Color color,
    required VoidCallback onPressed,
    required IconData icon,
  }) {
    return SizedBox(
      width: 12,
      height: 12,
      child: Material(
        color: color,
        shape: const CircleBorder(),
        child: InkWell(
          onTap: onPressed,
          customBorder: CircleBorder(),
          child: Icon(icon, size: 6, color: Colors.black54),
        ),
      ),
    );
  }

  Widget _buildWindowsLinuxControls() {
    return Row(
      children: [
        _buildWindowsLinuxButton(
          icon: Icons.minimize,
          onPressed: () => windowManager.minimize(),
          isClose: false,
        ),

        _buildWindowsLinuxButton(
          icon: isMaximized ? Icons.filter_none : Icons.crop_square,
          onPressed: () {
            windowManager.isMaximized().then((isMaximized) {
              if (isMaximized) {
                windowManager.unmaximize();
              } else {
                windowManager.maximize();
              }
              _checkMiximized();
            });
          },
          isClose: false,
        ),
        _buildWindowsLinuxButton(
          icon: Icons.close,
          onPressed: () => windowManager.close(),
          isClose: true,
        ),
      ],
    );
  }

  Widget _buildWindowsLinuxButton({
    required IconData icon,
    required VoidCallback onPressed,
    required bool isClose,
  }) {
    return SizedBox(
      width: Platform.isWindows ? 46 : 40,
      height: _getTitleBarHeight(),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          hoverColor: isClose
              ? const Color(0xFFE81123)
              : (Platform.isWindows
                    ? const Color(0xFF404040)
                    : const Color(0xFF505050)),
          child: Icon(
            icon,
            size: Platform.isWindows ? 10 : 12,
            color: widget.textColor,
          ),
        ),
      ),
    );
  }
}
