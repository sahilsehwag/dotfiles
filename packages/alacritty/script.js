const fs = require('fs');

// For Alt, Command (and possibly more) normal characters works instead of unicode
// Command actually breaks with unicode so just using upper or lowercase character works
// TODO: characters like space, backslash needs to be escaped
const keys = {
  // Letters (A–Z)
  A: 65, B: 66, C: 67, D: 68, E: 69,
  F: 70, G: 71, H: 72, I: 73, J: 74,
  K: 75, L: 76, M: 77, N: 78, O: 79,
  P: 80, Q: 81, R: 82, S: 83, T: 84,
  U: 85, V: 86, W: 87, X: 88, Y: 89, Z: 90,

  // Digits (0–9)
  Key0: 48, Key1: 49, Key2: 50, Key3: 51, Key4: 52,
  Key5: 53, Key6: 54, Key7: 55, Key8: 56, Key9: 57,

  // Symbols / Punctuation
  "'": 39,  // '
  '`': 96,       // `
  Minus: 45,       // -
  Equals: 61,      // =
  LBracket: 91,    // [
  RBracket: 93,    // ]
  Backslash: 92,   // \
  Semicolon: 59,   // ;
  Comma: 44,       // ,
  Period: 46,      // .
  Slash: 47,       // /

  // Whitespace & control characters
  Space: 32,       // space
  Tab: 9,          // \t
  Enter: 13,       // \r
  Backspace: 8,    // \b
  Escape: 27,      // \u001B

  // Delete
  Delete: 127,     // DEL (not Backspace)

  // These keys do NOT have direct ASCII values (navigation, function)
  // Insert: null,
  // Home: null,
  // End: null,
  // PageUp: null,
  // PageDown: null,
  // Up: null,
  // Down: null,
  // Left: null,
  // Right: null,

  // F1: null, F2: null, F3: null, F4: null, F5: null,
  // F6: null, F7: null, F8: null, F9: null, F10: null,
  // F11: null, F12: null,
};

const modifiers = {
  // "None": 1,
  // "Shift": 2,

  "Control": 5,
  "Control|Shift": 6,

  "Alt": 3,
  "Alt|Shift": 4,
  //"Option": 3,
  //"Option|Shift": 4,

  //"Super": 9,
  //"Super|Shift": 10,
  //"Command": 9,
  //"Command|Shift": 10,

  //"Control|Alt": 7,
  //"Control|Alt|Shift": 8,
  //"Control|Option": 7,
  //"Control|Option|Shift": 8,

  //"Alt|Super": 11,
  //"Alt|Super|Shift": 12,
  //"Alt|Command": 11,
  //"Alt|Command|Shift": 12,

  //"Option|Super": 11,
  //"Option|Super|Shift": 12,
  //"Option|Command": 11,
  //"Option|Command|Shift": 12,

  //"Control|Super": 13,
  //"Control|Super|Shift": 14,
  //"Control|Command": 13,
  //"Control|Command|Shift": 14,

  //"Control|Alt|Super": 15,
  //"Control|Alt|Super|Shift": 16,
  //"Control|Alt|Command": 15,
  //"Control|Alt|Command|Shift": 16,

  //"Control|Option|Super": 15,
  //"Control|Option|Super|Shift": 16,
  //"Control|Option|Command": 15,
  //"Control|Option|Command|Shift": 16,

  //"Hyper": 17 // uncommon, only with extended keyboards or remapped input
};

const bindings = Object
  .entries(modifiers)
  .map(([mLabel, mCode]) => {
    return Object
      .entries(keys)
      .map(([kLabel, kCode]) => {
        const code = (!~mLabel.indexOf('Shift') && kCode >= 65 && kCode <= 90) ? (97 + kCode - 65) : kCode

        // in case of Alt, Command and possibly more ...
        //`chars = "\\u001B${String.fromCharCode(code)}"\n` +
        return (
          `# Key: ${mLabel.split('|').join('-')}-${kLabel}\n` +
          '[[keyboard.bindings]]\n' +
          `chars = "\\u001B[${code};${mCode}u"\n` +
          `key = "${kLabel}"\n` +
          `mods = "${mLabel}"\n`
        );
      });
  }).flat();


//console.log(bindings.join('\n'))
fs.writeFileSync('keybindings.toml', bindings.join('\n'));
