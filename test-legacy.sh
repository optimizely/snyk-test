#!/bin/sh -e

rm -rf node_modules
npm install --legacy-bundling
npm test