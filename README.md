# depcheck action

[![Release Version](https://release-badges-generator.vercel.app/api/releases.svg?user=tubone24&repo=depcheck_action&gradient=ff6600,ffe500)](https://github.com/tubone24/depcheck_action/releases/latest)
[![license](https://img.shields.io/github/license/tubone24/depcheck_action.svg)](LICENSE)
[![standard-readme compliant](https://img.shields.io/badge/readme%20style-standard-brightgreen.svg?style=flat-square)](https://github.com/RichardLitt/standard-readme)
[![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg?style=flat-square)](http://makeapullrequest.com)

> List up libraries that are defined in dependencies and devDependencies in package.json but not used in your codes.

## Overview

You can use [depcheck](https://github.com/depcheck/depcheck) to check if the libraries defined in package.json are used in your code.

The result of the confirmation can be notified to the user in a PR comment at the time the GitHub Actions are executed, as shown in the example below.

![demo](https://i.imgur.com/x0HzZEF.png)

- **Unused dependencies** section indicates that the libraries defined in the package.json dependencies are not used in your `.js`, `.ts`, `.jsx`, `.tsx`, `.coffee`, `.sass`, `.scss`, and `.vue` files.
- **Unused devDpendencies** section also shows that the libraries defined in devDependencies in package.json are not present in each file.
- **Missing** section indicates that the library used in the code is not present in package.json. It is likely that you are using a library that is imported from CDN or declared globally.

## How to use

Use the depcheck aciton in your repository's GitHub Actions, which requires GitHub Token and PR comment URL as inputs, both of which can be retrieved as environment variables in GitHub Actions. Both of them can be retrieved as GitHub Actions environment variables. (Make sure to set the Action trigger to pull_request.)

- GITHUB_TOKEN
  - It can be retrieved as `secrets.GITHUB_TOKEN`.
- PR_COMMENT_URL
  - You can retrieve them from `github.event.pull_request.comments_url` during PR events.

```
on:
  pull_request:
    branches:
      - master
      
  build:
    runs-on: ubuntu-latest

    steps:
      - name: Checkout source code
        uses: actions/checkout@v2
      - name: Setup Node
        uses: actions/setup-node@v2
        with:
          node-version: 14.x
      - name: "depcheck"
        uses: tubone24/depcheck_action@main
        with:
          GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
          PR_COMMENT_URL: ${{ github.event.pull_request.comments_url }}
```

## Contributing

See [the contributing file](CONTRIBUTING.md)!

PRs accepted.

Small note: If editing the Readme, please conform to the [standard-readme](https://github.com/RichardLitt/standard-readme) specification.

## License

[MIT © tubone.](LICENSE)
