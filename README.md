# snyk deps demo

This repo demonstrates an apparent issue with snyk.io with recent versions of node (7.5.0), in that it appears to behave
differently depending on whether --legacy-bundling is used.

The test package installs the vulnerable package grunt-jsdoc-to-markdown@0.4.3 as a `devDependency`, which according to
[snyk docs](https://snyk.io/docs/using-snyk/#wizard), should NOT be scanned.

## Prereqs

Install [`nvm`](https://github.com/creationix/nvm#installation) and run `nvm use` if necessary

## Test

Run ./test.sh:
```sh
✗ High severity vulnerability found on marked@0.3.6
- desc: Cross-site Scripting (XSS) via Data URIs
- info: https://snyk.io/vuln/npm:marked:20170112
- from: snyk-test@1.0.0 > jsdoc@3.3.0-dev > marked@0.3.6
Fix: None available. Consider removing this dependency.

Tested 13 dependencies for known vulnerabilities, found 1 vulnerability, 1 vulnerable path.
```

Run ./test_legacy.sh
```sh
✓ Tested 0 dependencies for known vulnerabilities, no vulnerable paths found.

Next steps:
- Run `snyk monitor` to be notified about new related vulnerabilities.
- Run `snyk test` as part of your CI/test.
```

Run ./yarn.sh
```sh
✗ Medium severity vulnerability found on marked@0.3.1
- desc: Regular Expression Denial of Service
- info: https://snyk.io/vuln/npm:marked:20140131-1
- from: snyk-test@1.0.0 > jsdoc@3.3.0-dev > marked@0.3.1
Upgrade direct dependency jsdoc@3.3.0-dev to jsdoc@3.3.0 (triggers upgrades to marked@0.3.4)

✗ Medium severity vulnerability found on marked@0.3.1
- desc: VBScript Content Injection
- info: https://snyk.io/vuln/npm:marked:20140131-2
- from: snyk-test@1.0.0 > jsdoc@3.3.0-dev > marked@0.3.1
Upgrade direct dependency jsdoc@3.3.0-dev to jsdoc@3.3.0 (triggers upgrades to marked@0.3.3)

✗ High severity vulnerability found on marked@0.3.1
- desc: Content & Code Injection (XSS)
- info: https://snyk.io/vuln/npm:marked:20150520
- from: snyk-test@1.0.0 > jsdoc@3.3.0-dev > marked@0.3.1
Upgrade direct dependency jsdoc@3.3.0-dev to jsdoc@3.3.0 (triggers upgrades to marked@0.3.6)

✗ High severity vulnerability found on marked@0.3.6
- desc: Cross-site Scripting (XSS) via Data URIs
- info: https://snyk.io/vuln/npm:marked:20170112
- from: snyk-test@1.0.0 > marked@0.3.6
Fix: None available. Consider removing this dependency.

✗ High severity vulnerability found on marked@0.3.1
- desc: Cross-site Scripting (XSS) via Data URIs
- info: https://snyk.io/vuln/npm:marked:20170112
- from: snyk-test@1.0.0 > jsdoc@3.3.0-dev > marked@0.3.1
Fix: None available. Consider removing this dependency.

Tested 18 dependencies for known vulnerabilities, found 4 vulnerabilities, 5 vulnerable paths.

Run `snyk wizard` to address these issues.
```