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

/** A keyboard input. Has digital buttons corresponding to keyboard keys.
 *  Contains the same constants as the [html.KeyCode] class.
 */
class Keyboard extends DigitalInput {
  /** The A key. */
  static const A = html.KeyCode.A;
  /** The B key. */
  static const B = html.KeyCode.B;
  /** The C key. */
  static const C = html.KeyCode.C;
  /** The D key. */
  static const D = html.KeyCode.D;
  /** The E key. */
  static const E = html.KeyCode.E;
  /** The F key. */
  static const F = html.KeyCode.F;
  /** The G key. */
  static const G = html.KeyCode.G;
  /** The H key. */
  static const H = html.KeyCode.H;
  /** The I key. */
  static const I = html.KeyCode.I;
  /** The J key. */
  static const J = html.KeyCode.J;
  /** The K key. */
  static const K = html.KeyCode.K;
  /** The L key. */
  static const L = html.KeyCode.L;
  /** The M key. */
  static const M = html.KeyCode.M;
  /** The N key. */
  static const N = html.KeyCode.N;
  /** The O key. */
  static const O = html.KeyCode.O;
  /** The P key. */
  static const P = html.KeyCode.P;
  /** The Q key. */
  static const Q = html.KeyCode.Q;
  /** The R key. */
  static const R = html.KeyCode.R;
  /** The S key. */
  static const S = html.KeyCode.S;
  /** The T key. */
  static const T = html.KeyCode.T;
  /** The U key. */
  static const U = html.KeyCode.U;
  /** The V key. */
  static const V = html.KeyCode.V;
  /** The W key. */
  static const W = html.KeyCode.W;
  /** The X key. */
  static const X = html.KeyCode.X;
  /** The Y key. */
  static const Y = html.KeyCode.Y;
  /** The Z key. */
  static const Z = html.KeyCode.Z;
  /** The Shift key. */
  static const SHIFT = html.KeyCode.SHIFT;
  /** The Control key. */
  static const CTRL = html.KeyCode.CTRL;
  /** The Alt key. */
  static const ALT = html.KeyCode.ALT;
  /** The Space key. */
  static const SPACE = html.KeyCode.SPACE;
  /** The Zero key. */
  static const ZERO = html.KeyCode.ZERO;
  /** The One key. */
  static const ONE = html.KeyCode.ONE;
  /** The Two key. */
  static const TWO = html.KeyCode.TWO;
  /** The Three key. */
  static const THREE = html.KeyCode.THREE;
  /** The Four key. */
  static const FOUR = html.KeyCode.FOUR;
  /** The Five key. */
  static const FIVE = html.KeyCode.FIVE;
  /** The Six key. */
  static const SIX = html.KeyCode.SIX;
  /** The Seven key. */
  static const SEVEN = html.KeyCode.SEVEN;
  /** The Eight key. */
  static const EIGHT = html.KeyCode.EIGHT;
  /** The Nine key. */
  static const NINE = html.KeyCode.NINE;
  /** The Enter key. */
  static const ENTER = html.KeyCode.ENTER;
  /** The Up key. */
  static const UP = html.KeyCode.UP;
  /** The Down key. */
  static const DOWN = html.KeyCode.DOWN;
  /** The Left key. */
  static const LEFT = html.KeyCode.LEFT;
  /** The Right key. */
  static const RIGHT = html.KeyCode.RIGHT;
  /** The Escape key. */
  static const ESCAPE = html.KeyCode.ESC;
  /** The Apostrophe key. CAUTION: This constant requires localization for other
   * locales and keyboard layouts. */
  static const APOSTROPHE = html.KeyCode.APOSTROPHE;
  /** The Backslash key. CAUTION: This constant requires localization for other
   * locales and keyboard layouts. */
  static const BACKSLASH = html.KeyCode.BACKSLASH;
  /** The Backspace key. */
  static const BACKSPACE = html.KeyCode.BACKSPACE;
  /** The Caps Lock key. */
  static const CAPS_LOCK = html.KeyCode.CAPS_LOCK;
  /** The Close Square Bracket key. CAUTION: This constant requires localization
   * for other locales and keyboard layouts. */
  static const CLOSE_SQUARE_BRACKET = html.KeyCode.CLOSE_SQUARE_BRACKET;
  /** The Comma key. CAUTION: This constant requires localization for other
   * locales and keyboard layouts. */
  static const COMMA = html.KeyCode.COMMA;
  /** The Context Menu key. */
  static const CONTEXT_MENU = html.KeyCode.CONTEXT_MENU;
  /** The Dash key. CAUTION: This constant requires localization for other
   * locales and keyboard layouts. */
  static const DASH = html.KeyCode.DASH;
  /** The Delete key. */
  static const DELETE = html.KeyCode.DELETE;
  /** The End key. */
  static const END = html.KeyCode.END;
  /** The Equals key. CAUTION: This constant requires localization for other
   * locales and keyboard layouts. */
  static const EQUALS = html.KeyCode.EQUALS;
  /** The F1 key. */
  static const F1 = html.KeyCode.F1;
  /** The F2 key. */
  static const F2 = html.KeyCode.F2;
  /** The F3 key. */
  static const F3 = html.KeyCode.F3;
  /** The F4 key. */
  static const F4 = html.KeyCode.F4;
  /** The F5 key. */
  static const F5 = html.KeyCode.F5;
  /** The F6 key. */
  static const F6 = html.KeyCode.F6;
  /** The F7 key. */
  static const F7 = html.KeyCode.F7;
  /** The F8 key. */
  static const F8 = html.KeyCode.F8;
  /** The F9 key. */
  static const F9 = html.KeyCode.F9;
  /** The F10 key. */
  static const F10 = html.KeyCode.F10;
  /** The F11 key. */
  static const F11 = html.KeyCode.F11;
  /** The F12 key. */
  static const F12 = html.KeyCode.F12;
  /** The FF Equals key. */
  static const FF_EQUALS = html.KeyCode.FF_EQUALS;
  /** The FF Semicolon key. */
  static const FF_SEMICOLON = html.KeyCode.FF_SEMICOLON;
  /** The First Media key. */
  static const FIRST_MEDIA_KEY = html.KeyCode.FIRST_MEDIA_KEY;
  /** The Home key. */
  static const HOME = html.KeyCode.HOME;
  /** The Insert key. */
  static const INSERT = html.KeyCode.INSERT;
  /** The Last Media key. */
  static const LAST_MEDIA_KEY = html.KeyCode.LAST_MEDIA_KEY;
  /** The Mac Enter key. */
  static const MAC_ENTER = html.KeyCode.MAC_ENTER;
  /** The Mac FF Meta key. */
  static const MAC_FF_META = html.KeyCode.MAC_FF_META;
  /** The Meta key. */
  static const META = html.KeyCode.META;
  /** The Num Center key. */
  static const NUM_CENTER = html.KeyCode.NUM_CENTER;
  /** The Num Delete key. */
  static const NUM_DELETE = html.KeyCode.NUM_DELETE;
  /** The Num Division key. */
  static const NUM_DIVISION = html.KeyCode.NUM_DIVISION;
  /** The Num East key. */
  static const NUM_EAST = html.KeyCode.NUM_EAST;
  /** The Num Eight key. */
  static const NUM_EIGHT = html.KeyCode.NUM_EIGHT;
  /** The Num Five key. */
  static const NUM_FIVE = html.KeyCode.NUM_FIVE;
  /** The Num Four key. */
  static const NUM_FOUR = html.KeyCode.NUM_FOUR;
  /** The Num Insert key. */
  static const NUM_INSERT = html.KeyCode.NUM_INSERT;
  /** The Num Minus key. */
  static const NUM_MINUS = html.KeyCode.NUM_MINUS;
  /** The Num Multiply key. */
  static const NUM_MULTIPLY = html.KeyCode.NUM_MULTIPLY;
  /** The Num Nine key. */
  static const NUM_NINE = html.KeyCode.NUM_NINE;
  /** The Num North key. */
  static const NUM_NORTH = html.KeyCode.NUM_NORTH;
  /** The Num North East key. */
  static const NUM_NORTH_EAST = html.KeyCode.NUM_NORTH_EAST;
  /** The Num North West key. */
  static const NUM_NORTH_WEST = html.KeyCode.NUM_NORTH_WEST;
  /** The Num One key. */
  static const NUM_ONE = html.KeyCode.NUM_ONE;
  /** The Num Period key. */
  static const NUM_PERIOD = html.KeyCode.NUM_PERIOD;
  /** The Num Plus key. */
  static const NUM_PLUS = html.KeyCode.NUM_PLUS;
  /** The Num Seven key. */
  static const NUM_SEVEN = html.KeyCode.NUM_SEVEN;
  /** The Num Six key. */
  static const NUM_SIX = html.KeyCode.NUM_SIX;
  /** The Num South key. */
  static const NUM_SOUTH = html.KeyCode.NUM_SOUTH;
  /** The Num South East key. */
  static const NUM_SOUTH_EAST = html.KeyCode.NUM_SOUTH_EAST;
  /** The Num South West key. */
  static const NUM_SOUTH_WEST = html.KeyCode.NUM_SOUTH_WEST;
  /** The Num Three key. */
  static const NUM_THREE = html.KeyCode.NUM_THREE;
  /** The Num Two key. */
  static const NUM_TWO = html.KeyCode.NUM_TWO;
  /** The Num West key. */
  static const NUM_WEST = html.KeyCode.NUM_WEST;
  /** The Num Zero key. */
  static const NUM_ZERO = html.KeyCode.NUM_ZERO;
  /** The Num Lock key. */
  static const NUMLOCK = html.KeyCode.NUMLOCK;
  /** The Open Square Bracket key. CAUTION: This constant requires localization
   * for other locales and keyboard layouts. */
  static const OPEN_SQUARE_BRACKET = html.KeyCode.OPEN_SQUARE_BRACKET;
  /** The Page up key. */
  static const PAGE_UP = html.KeyCode.PAGE_UP;
  /** The Page down key. */
  static const PAGE_DOWN = html.KeyCode.PAGE_DOWN;
  /** The Pause key. */
  static const PAUSE = html.KeyCode.PAUSE;
  /** The Period key. CAUTION: This constant requires localization for other
   * locales and keyboard layouts. */
  static const PERIOD = html.KeyCode.PERIOD;
  /** The Print Screen key. */
  static const PRINT_SCREEN = html.KeyCode.PRINT_SCREEN;
  /** The Question Mark key. CAUTION: This constant requires localization for
   * other locales and keyboard layouts.*/
  static const QUESTION_MARK = html.KeyCode.QUESTION_MARK;
  /** The Scroll Lock key. */
  static const SCROLL_LOCK = html.KeyCode.SCROLL_LOCK;
  /** The Semicolon key. CAUTION: This constant requires localization for other
   * locales and keyboard layouts. */
  static const SEMICOLON = html.KeyCode.SEMICOLON;
  /** The Single Quote key. CAUTION: This constant requires localization for
   * other locales and keyboard layouts.*/
  static const SINGLE_QUOTE = html.KeyCode.SINGLE_QUOTE;
  /** The Slash key. CAUTION: This constant requires localization for other
   * locales and keyboard layouts.*/
  static const SLASH = html.KeyCode.SLASH;
  /** The Tab key. */
  static const TAB = html.KeyCode.TAB;
  /** The Tilde key. CAUTION: This constant requires localization for other
   * locales and keyboard layouts. */
  static const TILDE = html.KeyCode.TILDE;
  /** The Win IME key. */
  static const WIN_IME = html.KeyCode.WIN_IME;
  /** The Win key. */
  static const WIN_KEY = html.KeyCode.WIN_KEY;
  /** The Win FF Linux key. */
  static const WIN_KEY_FF_LINUX = html.KeyCode.WIN_KEY_FF_LINUX;
  /** The Win Left key. */
  static const WIN_KEY_LEFT = html.KeyCode.WIN_KEY_LEFT;
  /** The Win Right key. */
  static const WIN_KEY_RIGHT = html.KeyCode.WIN_KEY_RIGHT;
  static final List<int> _buttonIds = [A, B, C,
                               D, E, F,
                               G, H, I,
                               J, K, L,
                               M, N, O,
                               P, Q, R,
                               S, T, U,
                               V, W, X,
                               Y, Z,
                               SHIFT,
                               CTRL,
                               ALT,
                               SPACE,
                               ZERO,
                               ONE,
                               TWO,
                               THREE,
                               FOUR,
                               FIVE,
                               SIX,
                               SEVEN,
                               EIGHT,
                               NINE,
                               ENTER,
                               UP,
                               DOWN,
                               LEFT,
                               RIGHT,
                               ESCAPE,
                               APOSTROPHE,
                               BACKSLASH,
                               BACKSPACE,
                               CAPS_LOCK,
                               CLOSE_SQUARE_BRACKET,
                               COMMA,
                               CONTEXT_MENU,
                               DASH,
                               DELETE,
                               END,
                               EQUALS,
                               F1, F2, F3,
                               F4, F5, F6,
                               F7, F8, F9,
                               F10, F11, F12,
                               FF_EQUALS,
                               FF_SEMICOLON,
                               FIRST_MEDIA_KEY,
                               HOME,
                               INSERT,
                               LAST_MEDIA_KEY,
                               MAC_ENTER,
                               MAC_FF_META,
                               META,
                               NUM_CENTER,
                               NUM_DELETE,
                               NUM_DIVISION,
                               NUM_EAST,
                               NUM_EIGHT,
                               NUM_FIVE,
                               NUM_FOUR,
                               NUM_INSERT,
                               NUM_MINUS,
                               NUM_MULTIPLY,
                               NUM_NINE,
                               NUM_NORTH,
                               NUM_NORTH_EAST,
                               NUM_NORTH_WEST,
                               NUM_ONE,
                               NUM_PERIOD,
                               NUM_PLUS,
                               NUM_SEVEN,
                               NUM_SIX,
                               NUM_SOUTH,
                               NUM_SOUTH_EAST,
                               NUM_SOUTH_WEST,
                               NUM_THREE,
                               NUM_TWO,
                               NUM_WEST,
                               NUM_ZERO,
                               NUMLOCK,
                               OPEN_SQUARE_BRACKET,
                               PAGE_UP,
                               PAGE_DOWN,
                               PAUSE,
                               PERIOD,
                               PRINT_SCREEN,
                               QUESTION_MARK,
                               SCROLL_LOCK,
                               SEMICOLON,
                               SINGLE_QUOTE,
                               SLASH,
                               TAB,
                               TILDE,
                               WIN_IME,
                               WIN_KEY,
                               WIN_KEY_FF_LINUX,
                               WIN_KEY_LEFT,
                               WIN_KEY_RIGHT
                               ];

  Keyboard(gameLoop) : super(gameLoop, _buttonIds);
}