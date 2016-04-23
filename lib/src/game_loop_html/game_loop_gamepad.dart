/*
  Copyright (C) 2013 John McCutchan <john@johnmccutchan.com>

  This software is provided 'as-is', without any express or implied
  warranty.  In no event will the authors be held liable for any damages
  arising from the use of this software.

  Permission is granted to anyone to use this software for any purpose,
  including commercial applications, and to alter it and redistribute it
  freely, subject to the following restrictions:

  1. The origin of this software must not be misrepresented; you must not
     claim that you wrote the original software. If you use this software
     in a product, an acknowledgment in the product documentation would be
     appreciated but is not required.
  2. Altered source versions must be plainly marked as such, and must not be
     misrepresented as being the original software.
  3. This notice may not be removed or altered from any source distribution.
*/

part of game_loop_html;

/// A gamepad
class Gamepad {
  static const int BUTTON_A = 0;
  static const int BUTTON_B = 1;
  static const int BUTTON_X = 2;
  static const int BUTTON_Y = 3;
  static const int BUTTON_BUMPER_LEFT = 4;
  static const int BUTTON_BUMPER_RIGHT = 5;
  static const int BUTTON_TRIGGER_LEFT = 6;
  static const int BUTTON_TRIGGER_RIGHT = 7;
  static const int BUTTON_BACK = 8;
  static const int BUTTON_START = 9;
  static const int BUTTON_STICK_LEFT = 10;
  static const int BUTTON_STICK_RIGHT = 11;
  static const int BUTTON_D_UP = 12;
  static const int BUTTON_D_DOWN = 13;
  static const int BUTTON_D_LEFT = 14;
  static const int BUTTON_D_RIGHT = 15;
  static const int STICK_LEFT_X = 0;
  static const int STICK_LEFT_Y = 1;
  static const int STICK_RIGHT_X = 2;
  static const int STICK_RIGHT_Y = 3;

  bool _connected = false;

  final GameLoop gameLoop;
  final int index;

  final DigitalInput digitalButtons;
  final AnalogInput analogButtons;
  final AnalogInput sticks;

  bool get connected => _connected;

  Gamepad(GameLoopHtml gameLoop, this.index)
      : gameLoop = gameLoop,
        digitalButtons = new DigitalInput(gameLoop, [
          BUTTON_A,
          BUTTON_B,
          BUTTON_X,
          BUTTON_Y,
          BUTTON_BUMPER_LEFT,
          BUTTON_BUMPER_RIGHT,
          BUTTON_TRIGGER_LEFT,
          BUTTON_TRIGGER_RIGHT,
          BUTTON_BACK,
          BUTTON_START,
          BUTTON_STICK_LEFT,
          BUTTON_STICK_RIGHT,
          BUTTON_D_UP,
          BUTTON_D_DOWN,
          BUTTON_D_LEFT,
          BUTTON_D_RIGHT
        ]),
        analogButtons = new AnalogInput(gameLoop, [
          BUTTON_A,
          BUTTON_B,
          BUTTON_X,
          BUTTON_Y,
          BUTTON_BUMPER_LEFT,
          BUTTON_BUMPER_RIGHT,
          BUTTON_TRIGGER_LEFT,
          BUTTON_TRIGGER_RIGHT,
          BUTTON_BACK,
          BUTTON_START,
          BUTTON_STICK_LEFT,
          BUTTON_STICK_RIGHT,
          BUTTON_D_UP,
          BUTTON_D_DOWN,
          BUTTON_D_LEFT,
          BUTTON_D_RIGHT
        ]),
        sticks = new AnalogInput(gameLoop,
            [STICK_LEFT_X, STICK_LEFT_Y, STICK_RIGHT_X, STICK_RIGHT_Y]);
}
