// Hugo runs the `sass` executable found in PATH in "embedded" mode (Dart Sass).
// `sass-embedded` ships one, but it also pulls the pure-JS `sass` package as an
// optional fallback, which provides a `sass` bin too. Depending on the npm
// version, node_modules/.bin/sass may end up pointing to the pure-JS one,
// which Hugo cannot use ("sass --embedded is unavailable in pure JS mode").
// This makes node_modules/.bin/sass always point to sass-embedded.
const fs = require("fs");
const path = require("path");

const binDir = path.join(__dirname, "..", "node_modules", ".bin");
const target = path.join("..", "sass-embedded", "dist", "bin", "sass.js");

if (process.platform === "win32") {
  // npm creates .cmd shims on Windows; nothing to relink there.
  process.exit(0);
}

try {
  if (!fs.existsSync(path.join(binDir, target))) {
    console.warn("link-dart-sass: sass-embedded is not installed, skipping");
    process.exit(0);
  }
  const link = path.join(binDir, "sass");
  fs.rmSync(link, { force: true });
  fs.symlinkSync(target, link);
} catch (err) {
  console.warn(`link-dart-sass: ${err.message}`);
}
