const process = require('process');
const fs = require('fs');
const TOML = require('@iarna/toml');
const mergeOptions = require('merge-options');

const inputObjects = process.argv.slice(2).map(inputPath => {
    if (inputPath == '-') {
        inputPath = '/dev/stdin';
    }

    return TOML.parse(fs.readFileSync(inputPath, 'utf8'));
});

const mergedObject = mergeOptions(...inputObjects);

process.stdout.write(TOML.stringify(mergedObject));
