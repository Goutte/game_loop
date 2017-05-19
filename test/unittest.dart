import 'package:unittest/unittest.dart';
import 'dart:html';
import 'package:unittest/html_enhanced_config.dart';
import 'package:game_loop/game_loop_html.dart';

class TestState extends GameLoopHtmlState {

  void onFullScreenChange(GameLoop gameLoop) {
    // TODO implement this method
  }

  void onKeyDown(KeyboardEvent event) {
    // TODO implement this method
  }

  void onPointerLockChange(GameLoop gameLoop) {
    // TODO implement this method
  }

  void onRender(GameLoop gameLoop) {
    // TODO implement this method
  }

  void onResize(GameLoop gameLoop) {
    // TODO implement this method
  }

  void onTouchEnd(GameLoop gameLoop, GameLoopTouch touch) {
    // TODO implement this method
  }

  void onTouchStart(GameLoop gameLoop, GameLoopTouch touch) {
    // TODO implement this method
  }

  void onTouchMove(GameLoop gameLoop, GameLoopTouch touch) {
    // TODO implement this method
  }

  void onUpdate(GameLoop gameLoop) {
    // TODO implement this method
  }
}

main() {
  useHtmlEnhancedConfiguration();

  group("GameLoop,", () {
    GameLoopHtml game_loop;
    CanvasElement canvas;
    CanvasRenderingContext2D context;

    setUp(() {
      canvas = querySelector(".game-canvas");
      game_loop = new GameLoopHtml(canvas);
    });

    group("setting state,", () {
      TestState state;

      setUp(() {
        state = new TestState();

        game_loop.state = state;
      });

      test("game_loop.state = state", () {
        expect(game_loop.state, equals(state));
      });

      test("game_loop.onFullScreenChange = state.onFullScreenChange", () {
        expect(game_loop.onFullscreenChange, equals(state.onFullScreenChange));
      });

      test("game_loop.onKeyDown = state.onKeyDown", () {
        expect(game_loop.onKeyDown, equals(state.onKeyDown));
      });

      test("game_loop.onPointerLockChange = state.onPointerLockChange", () {
        expect(game_loop.onPointerLockChange, equals(state.onPointerLockChange));
      });

      test("game_loop.onRender = state.onRender", () {
        expect(game_loop.onRender, equals(state.onRender));
      });

      test("game_loop.onResize = state.onResize", () {
        expect(game_loop.onResize, equals(state.onResize));
      });

      test("game_loop.onTouchEnd = state.onTouchEnd", () {
        expect(game_loop.onTouchEnd, equals(state.onTouchEnd));
      });

      test("game_loop.onTouchState = state.onTouchStart", () {
        expect(game_loop.onTouchStart, equals(state.onTouchStart));
      });

      test("game_loop.onUpdate = state.onUpdate", () {
        expect(game_loop.onUpdate, equals(state.onUpdate));
      });
    });
  });
}