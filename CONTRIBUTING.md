# 🤝 Contributing to Hummingbird

Thank you for your interest in contributing! Hummingbird is an open-source **development theme** for PrestaShop, and your help is highly appreciated 🙌

## 🧠 Learn Before You Start

- [We’re Building a Starter Theme for PrestaShop](https://build.prestashop-project.org/news/2022/new-theme-announce/).
- [PrestaShop Branching Model](https://build.prestashop-project.org/news/2015/introducing-new-branching-model-prestashop/).

💬 Join our Slack community: [https://www.prestashop-project.org/slack/](https://www.prestashop-project.org/slack/)

## 🛠️ Environment Setup

Follow the [README.md](https://github.com/PrestaShop/hummingbird/blob/develop/README.md) for detailed setup and build instructions.

## ✅ Checklist Before You Start

1. Set up your Git config:<br>
  [Set up your Git for contributing](https://build.prestashop-project.org/howtos/misc/set-up-your-git-for-contributing/)
2. Use an editor that supports .editorconfig.<br>
  [Download an EditorConfig plugin](http://editorconfig.org/#download).
3. Make sure you have [Node.js v20](https://nodejs.org/en/download/) installed.

## 👍 Good Practices

- Use [BEM naming conventions](https://getbem.com/) for CSS.
- Use Bootstrap components **when they fully meet your needs**.
- Create custom components when **Bootstrap isn't sufficient**.
- Use **Bootstrap CSS variables** in your custom components wherever possible to maintain consistency.
- Add comments to your code where clarification is needed.
- Before submitting a PR:
  - Format code using Prettier:<br>
    `npm run prettier` and `npm run prettier:fix`
  - Run linters for both JavaScript and styles:<br>
    For linting check use `npm run lint && npm run stylelint`. Use `npm run lint:fix && npm run stylelint:fix` to auto-fix where possible.<br>
    **Otherwise, fix issues manually.**
- If your PR is a work in progress, use **GitHub draft PR**.
- Fill out the PR template thoroughly to speed up testing and review.
- Organize your commits clearly and try to follow [conventional commits](https://www.conventionalcommits.org/) to name it.<br>
  **Examples:**
  - `feat: add responsive support for product cards`
  - `fix: correct header spacing on mobile`
  - `chore: update dependencies`

## 🐛 Reporting Issues 

You can [open an issue](https://github.com/PrestaShop/hummingbird/issues) to:

- Report a bug 🐞
- Suggest an improvement 💡
- Ask a question or get feedback before starting work 💬
