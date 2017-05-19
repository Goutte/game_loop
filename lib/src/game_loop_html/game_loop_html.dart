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

/** Called when it is time to draw. */
typedef void GameLoopRenderFunction(GameLoop gameLoop);

/** Called whenever the element is resized. */
typedef void GameLoopResizeFunction(GameLoop gameLoop);

/** Called whenever the element moves between fullscreen and non-fullscreen
 * mode.
 */
typedef void GameLoopFullscreenChangeFunction(GameLoop gameLoop);

/** Called whenever the element moves between locking the pointer and
 * not locking the pointer.
 */
typedef void GameLoopPointerLockChangeFunction(GameLoop gameLoop);

/** Called whenever a touch event begins */
typedef void GameLoopTouchEventFunction(GameLoop gameLoop, GameLoopTouch touch);

/**
 * Called from inside keydown. Process the event, possibly
 * preventing default.
 */
typedef void GameLoopKeyDownHandler(html.KeyboardEvent event);

/** The game loop */
class GameLoopHtml extends GameLoop {
  final html.Element element;
  int _frameCounter = 0;
  bool _initialized = false;
  bool _interrupt = false;
  double _previousFrameTime;
  double _frameTime = 0.0;
  double get frameTime => _frameTime;
  bool _resizePending = false;
  double _nextResize = 0.0;

  /** Seconds of accumulated time. */
  double get accumulatedTime => _accumulatedTime;

  /** Frame counter value. Incremented once per frame. */
  int get frame => _frameCounter;

  double maxAccumulatedTime = 0.03;
  double _accumulatedTime = 0.0;
  /** Width of game display [Element] */
  int get width => element.client.width;
  /** Height of game display [Element] */
  int get height => element.client.height;

  double _gameTime = 0.0;
  double get gameTime => _gameTime;

  double _renderInterpolationFactor = 0.0;
  double get renderInterpolationFactor => _renderInterpolationFactor;
  /** The minimum amount of time between two onResize calls in seconds*/
  double resizeLimit = 0.05;

  /// If [processAllKeyboardEvents] is false, keyboard events are only processed,
  /// if the body is the active element. That means that no keyboard events are
  /// processed while input elements are focused.
  bool processAllKeyboardEvents = true;

  PointerLock _pointerLock;
  PointerLock get pointerLock => _pointerLock;

  Keyboard _keyboard;
  /** Keyboard. */
  Keyboard get keyboard => _keyboard;
  Mouse _mouse;
  /** Mouse. */
  Mouse get mouse => _mouse;
  Gamepad _gamepad0;
  Gamepad _gamepad1;
  Gamepad _gamepad2;
  Gamepad _gamepad3;
  html.Point _lastMousePos = new html.Point(0, 0);
  /** Gamepad #0. */
  Gamepad get gamepad0 => _gamepad0;
  /** Gamepad #1. */
  Gamepad get gamepad1 => _gamepad1;
  /** Gamepad #2. */
  Gamepad get gamepad2 => _gamepad2;
  /** Gamepad #3. */
  Gamepad get gamepad3 => _gamepad3;
  /** Touch */
  GameLoopTouchSet _touchSet;
  GameLoopTouchSet get touchSet => _touchSet;

  /// True if the offset is going to be always (0,0) instead of being calculated.
  /// Useful for accelerated canvas engines with no full DOM implementation.
  bool forceFullScreenOffset = false;

  /** Construct a new game loop attaching it to [element]. */
  GameLoopHtml(this.element) : super() {
    _keyboard = new Keyboard(this);
    _mouse = new Mouse(this);
    _gamepad0 = new Gamepad(this, 0);
    _gamepad1 = new Gamepad(this, 1);
    _gamepad2 = new Gamepad(this, 2);
    _gamepad3 = new Gamepad(this, 3);
    _pointerLock = new PointerLock(this);
    _touchSet = new GameLoopTouchSet(this);
  }

  void _processInputEvents() {
    _processKeyboardEvents();
    _processMouseEvents();
    _processGamepadsEvents();
    _processTouchEvents();
  }

  void _processKeyboardEvents() {
    // If processAllKeyboardEvents is false, before processing the keyboard events,
    // check if they should be processed or if they are processed by another
    // element, like an input element.
    if (processAllKeyboardEvents ||
        html.document.activeElement == html.document.body) {
      for (html.KeyboardEvent keyboardEvent in _keyboardEvents) {
        DigitalButtonEvent event;
        bool down = keyboardEvent.type == "keydown";
        double time = GameLoop.timeStampToSeconds(keyboardEvent.timeStamp);
        int buttonId = keyboardEvent.keyCode;
        event = new DigitalButtonEvent(buttonId, down, frame, time);
        _keyboard.digitalButtonEvent(event);
      }
    }
    _keyboardEvents.clear();
  }

  void _processMouseEvents() {
    mouse._resetAccumulators();

    // TODO(alexgann): Remove custom offset logic once dart:html supports natively (M6).
    int canvasX = 0;
    int canvasY = 0;
    if (!forceFullScreenOffset) {
      try {
        final docElem = html.document.documentElement;
        final box = element.getBoundingClientRect();
        canvasX =
            (box.left + html.window.pageXOffset - docElem.clientLeft).floor();
        canvasY =
            (box.top + html.window.pageYOffset - docElem.clientTop).floor();
      } catch (_) {
        forceFullScreenOffset = true;
      }
    }

    for (html.MouseEvent mouseEvent in _mouseEvents) {
      bool moveEvent = mouseEvent.type == 'mousemove';
      bool wheelEvent =
          mouseEvent.type == 'wheel' || mouseEvent.type == 'mousewheel';
      bool down = mouseEvent.type == 'mousedown';
      double time = GameLoop.timeStampToSeconds(mouseEvent.timeStamp);
      if (moveEvent) {
        int mouseX = mouseEvent.page.x;
        int mouseY = mouseEvent.page.y;
        int x = mouseX - canvasX;
        int y = mouseY - canvasY;
        int clampX = 0;
        int clampY = 0;
        bool withinCanvas = false;
        if (mouseX < canvasX) {
          clampX = 0;
        } else if (mouseX > canvasX + width) {
          clampX = width;
        } else {
          clampX = x;
          withinCanvas = true;
        }
        if (mouseY < canvasY) {
          clampY = 0;
          withinCanvas = false;
        } else if (mouseY > canvasY + height) {
          clampY = height;
          withinCanvas = false;
        } else {
          clampY = y;
        }

        int dx, dy;
        if (_pointerLock.locked) {
          dx = mouseEvent.movement.x;
          dy = mouseEvent.movement.y;
        } else {
          dx = mouseEvent.client.x - _lastMousePos.x;
          dy = mouseEvent.client.y - _lastMousePos.y;
          _lastMousePos = mouseEvent.client;
        }
        _lastMousePos = mouseEvent.client;
        var event = new GameLoopMouseEvent(
            x, y, dx, dy, clampX, clampY, withinCanvas, time, frame);
        _mouse.gameLoopMouseEvent(event);
      } else if (wheelEvent) {
        html.WheelEvent wheel = mouseEvent as html.WheelEvent;
        _mouse._accumulateWheel(wheel.deltaX.toInt(), wheel.deltaY.toInt());
      } else {
        int buttonId = mouseEvent.button;
        var event = new DigitalButtonEvent(buttonId, down, frame, time);
        _mouse.digitalButtonEvent(event);
      }
    }
    _mouseEvents.clear();
  }

  void _processGamepadsEvents() {
    final gamepads = html.window.navigator.getGamepads();

    assert(gamepads.length == 4);

    _processGamepadEvents(gamepads[0], gamepad0);
    _processGamepadEvents(gamepads[1], gamepad1);
    _processGamepadEvents(gamepads[2], gamepad2);
    _processGamepadEvents(gamepads[3], gamepad3);
  }

  void _processGamepadEvents(html.Gamepad pad, Gamepad gamepad) {
    //TODO (DART-23494): pad is "undefined" here due to a bug in Dart2Js, but
    // Dart has no way to tell if something is "undefined". Therefore we use
    // dart:js to convert it to and from js to make it null.
    final temp = new js.JsArray();
    temp.add(pad);

    if (temp.first == null || !pad.connected) {
      if (gamepad.connected) {
        gamepad.digitalButtons.buttons.forEach((id, v) {
          gamepad.digitalButtons.digitalButtonEvent(
              new DigitalButtonEvent(id, false, frame, time));
        });
        gamepad.analogButtons.buttons.forEach((id, v) {
          gamepad.analogButtons
              .analogButtonEvent(new AnalogButtonEvent(id, 0.0, frame, time));
        });
        gamepad.sticks.buttons.forEach((id, v) {
          gamepad.sticks
              .analogButtonEvent(new AnalogButtonEvent(id, 0.0, frame, time));
        });
        gamepad._connected = false;
      }
    } else {
      gamepad._connected = true;
      gamepad.digitalButtons.buttons.forEach((id, v) {
        gamepad.digitalButtons.digitalButtonEvent(
            new DigitalButtonEvent(id, pad.buttons[id].pressed, frame, time));
      });
      gamepad.analogButtons.buttons.forEach((id, v) {
        gamepad.analogButtons.analogButtonEvent(
            new AnalogButtonEvent(id, pad.buttons[id].value, frame, time));
      });
      gamepad.sticks.buttons.forEach((id, v) {
        gamepad.sticks.analogButtonEvent(
            new AnalogButtonEvent(id, pad.axes[id], frame, time));
      });
    }
  }

  void _processTouchEvents() {
    for (_GameLoopTouchEvent touchEvent in _touchEvents) {
      switch (touchEvent.type) {
        case _GameLoopTouchEvent.Start:
          _touchSet._start(touchEvent.event);
          break;
        case _GameLoopTouchEvent.End:
          _touchSet._end(touchEvent.event);
          break;
        case _GameLoopTouchEvent.Move:
          _touchSet._move(touchEvent.event);
          break;
        default:
          throw new StateError('Invalid _GameLoopTouchEvent type.');
      }
    }
    _touchEvents.clear();
  }

  int _rafId;

  void _requestAnimationFrame(num _) {
    if (_previousFrameTime == null) {
      _frameTime = time;
      _previousFrameTime = _frameTime;
      _processInputEvents();
      _rafId = html.window.requestAnimationFrame(_requestAnimationFrame);
      return;
    }
    if (_interrupt == true) {
      _rafId = null;
      return;
    }
    _rafId = html.window.requestAnimationFrame(_requestAnimationFrame);
    _previousFrameTime = _frameTime;
    _frameTime = time;
    double timeDelta = _frameTime - _previousFrameTime;
    _accumulatedTime += timeDelta;
    if (_accumulatedTime > maxAccumulatedTime) {
      // If the animation frame callback was paused we may end up with
      // a huge time delta. Clamp it to something reasonable.
      _accumulatedTime = maxAccumulatedTime;
    }
    while (_accumulatedTime >= updateTimeStep) {
      _frameCounter++;
      _processInputEvents();

      processTimers();
      _gameTime += updateTimeStep;
      if (onUpdate != null) {
        onUpdate(this);
      }
      _accumulatedTime -= updateTimeStep;
    }
    if (_resizePending == true &&
        onResize != null &&
        _nextResize <= _frameTime) {
      onResize(this);
      _nextResize = _frameTime + resizeLimit;
      _resizePending = false;
    }

    if (onRender != null) {
      _renderInterpolationFactor = _accumulatedTime / updateTimeStep;
      onRender(this);
    }

    if (onAfterFrame != null) {
      onAfterFrame(this);
    }
  }

  void _fullscreenChange(html.Event _) {
    if (onFullscreenChange == null) {
      return;
    }
    onFullscreenChange(this);
  }

  void _fullscreenError(html.Event _) {
    if (onFullscreenChange == null) {
      return;
    }
    onFullscreenChange(this);
  }

  final List<_GameLoopTouchEvent> _touchEvents =
      new List<_GameLoopTouchEvent>();
  void _touchStartEvent(html.TouchEvent event) {
    _touchEvents.add(new _GameLoopTouchEvent(event, _GameLoopTouchEvent.Start));
    event.preventDefault();
  }

  void _touchMoveEvent(html.TouchEvent event) {
    _touchEvents.add(new _GameLoopTouchEvent(event, _GameLoopTouchEvent.Move));
    event.preventDefault();
  }

  void _touchEndEvent(html.TouchEvent event) {
    _touchEvents.add(new _GameLoopTouchEvent(event, _GameLoopTouchEvent.End));
    event.preventDefault();
  }

  final List<html.KeyboardEvent> _keyboardEvents =
      new List<html.KeyboardEvent>();
  void _keyDown(html.KeyboardEvent event) {
    if (onKeyDown != null) {
      onKeyDown(event);
    }

    _keyboardEvents.add(event);
  }

  void _keyUp(html.KeyboardEvent event) {
    _keyboardEvents.add(event);
  }

  final List<html.MouseEvent> _mouseEvents = new List<html.MouseEvent>();
  void _mouseDown(html.MouseEvent event) {
    _mouseEvents.add(event);
  }

  void _mouseUp(html.MouseEvent event) {
    _mouseEvents.add(event);
  }

  void _mouseMove(html.MouseEvent event) {
    _mouseEvents.add(event);
  }

  void _mouseWheel(html.MouseEvent event) {
    _mouseEvents.add(event);
    event.preventDefault();
  }

  void _resize(html.Event _) {
    if (_resizePending == false) {
      _resizePending = true;
    }
  }

  /** Start the game loop. */
  void start() {
    if (_initialized == false) {
      html.document.onFullscreenError.listen(_fullscreenError);
      html.document.onFullscreenChange.listen(_fullscreenChange);
      element.onTouchStart.listen(_touchStartEvent);
      element.onTouchEnd.listen(_touchEndEvent);
      element.onTouchCancel.listen(_touchEndEvent);
      element.onTouchMove.listen(_touchMoveEvent);
      html.window.onKeyDown.listen(_keyDown);
      html.window.onKeyUp.listen(_keyUp);
      html.window.onResize.listen(_resize);

      element.onMouseMove.listen(_mouseMove);
      element.onMouseDown.listen(_mouseDown);
      element.onMouseUp.listen(_mouseUp);
      element.onMouseWheel.listen(_mouseWheel);
      _initialized = true;
    }
    _interrupt = false;
    _rafId = html.window.requestAnimationFrame(_requestAnimationFrame);
  }

  /** Stop the game loop. */
  void stop() {
    if (_rafId != null) {
      html.window.cancelAnimationFrame(_rafId);
      _rafId = null;
    }
    _interrupt = true;
  }

  /** Is the element visible on the screen? */
  bool get isVisible =>
      html.document.visibilityState == 'visible' && element.hidden == false;

  /** Is the element being displayed full screen? */
  bool get isFullscreen => html.document.fullscreenElement == element;

  /** Enable or disable fullscreen display of the element. */
  void enableFullscreen(bool enable) {
    if (enable) {
      element.requestFullscreen();
      return;
    }
    html.document.exitFullscreen();
  }

  /** Called when it is time to draw. */
  GameLoopRenderFunction onRender;

  /** Called when element is resized. */
  GameLoopResizeFunction onResize;
  /** Called when element enters or exits fullscreen mode. */
  GameLoopFullscreenChangeFunction onFullscreenChange;
  /** Called when the element moves between owning and not
   *  owning the pointer.
   */
  GameLoopPointerLockChangeFunction onPointerLockChange;
  /** Called when a touch begins. */
  GameLoopTouchEventFunction onTouchStart;
  /** Called when a touch moves. */
  GameLoopTouchEventFunction onTouchMove;
  /** Called when a touch ends. */
  GameLoopTouchEventFunction onTouchEnd;

  /** Called when key is down. */
  GameLoopKeyDownHandler onKeyDown;

  GameLoopHtmlState _state;

  GameLoopState get state => _state;
  set state(GameLoopHtmlState state) {
    _state = state;
    onUpdate = state.onUpdate;

    onFullscreenChange = state.onFullScreenChange;
    onKeyDown = state.onKeyDown;
    onPointerLockChange = state.onPointerLockChange;
    onRender = state.onRender;
    onResize = state.onResize;
    onTouchStart = state.onTouchStart;
    onTouchMove = state.onTouchMove;
    onTouchEnd = state.onTouchEnd;
  }
}
