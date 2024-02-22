# Contributing

### Understanding

Before getting started, you should read our article introducing the project:
[We're Building A Starter Theme For PrestaShop 1.7.8 and 8](https://build.prestashop-project.org/news/2022/new-theme-announce/).

If you are contributing to this theme, you are probably interested in PrestaShop development as well. Please the following article to get familiar with [PrestaShop branching model](https://build.prestashop-project.org/news/2015/introducing-new-branching-model-prestashop/).

You got any questions ? Join the open source slack.

[Join the slack at https://www.prestashop-project.org/slack/](https://www.prestashop-project.org/slack/)

### Setting up

There are few things to do before you are ready to contribute.

1. Check your _Git_ configuration. Read [Set Up Your Git For Contributing](https://build.prestashop-project.org/howtos/misc/set-up-your-git-for-contributing/)
2. Check your editor configuration. The rules are defined in `.editorconfig`. Do it manually or [install the available plugin](http://editorconfig.org/#download).
3. Make sure you at least have [NodeJS 14](https://nodejs.org/en/download/) installed.
4. You should install the theme inside a PrestaShop instance, please refer to [the developers docummentation of the project](https://devdocs.prestashop-project.org/1.7/basics/installation/).

### How to build the theme

First you need to install every node module:

`npm ci`

then create a `.env` file inside the *webpack* folder by copying `webpack/.env-example` and complete it with your environment's informations. Please use a free tcp port.

then build assets:

`npm run build`

### Good practices

- Follow the BEM convention
- Be careful about creating SCSS files in the right folder, refer to the [documentation](https://build.prestashop-project.org/hummingbird/) for further informations.
- When you want to submit a PR, please make sure that you ran both linters using `npm run lint-fix && npm run scss-fix` and fixed every lint issues.
- If your PR is a work in progress, make sure that you use the Github draft mode.
- Fill the PR template as much as possible, it's important to speed the process of testing, reviewing...
- Try to organize your commits in a way to simplify the review.

### Reporting issues

Open an issue:

1. To report a bug.
2. To propose an improvement and get feedbacks before you code it. ([example](https://github.com/PrestaShop/hummingbird/issues/))
