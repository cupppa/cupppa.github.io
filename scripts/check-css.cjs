const fs = require('node:fs');
const path = require('node:path');
const postcss = require('postcss');

function check(file) {
  const root = postcss.parse(fs.readFileSync(file, 'utf8'), { from: file });
  root.walkDecls(decl => {
    if (decl.parent.type === 'root') {
      throw decl.error('Declaration outside a CSS rule');
    }
  });
}

function checkDirectory(directory) {
  for (const entry of fs.readdirSync(directory, { withFileTypes: true })) {
    const file = path.join(directory, entry.name);
    if (entry.isDirectory()) checkDirectory(file);
    else if (entry.name.endsWith('.css')) check(file);
  }
}

try {
  if (process.argv[2]) check(process.argv[2]);
  else checkDirectory('public_html/assets');
  console.log('CSS syntax checks passed.');
} catch (error) {
  console.error(error.message);
  process.exitCode = 1;
}
