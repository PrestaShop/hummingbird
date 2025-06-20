# Hummingbird Theme for PrestaShop

![CI](https://github.com/PrestaShop/hummingbird/actions/workflows/lint.yml/badge.svg)
![PrestaShop 8.1+](https://img.shields.io/badge/prestashop-8.1%2B-brightgreen.svg)
![Docker Ready](https://img.shields.io/badge/docker-ready-blue.svg)
![Node.js v20](https://img.shields.io/badge/node.js-20.x-blue.svg)
![License](https://img.shields.io/badge/license-AFL%203.0-lightgray.svg)

Hummingbird is a modern, in-development theme for PrestaShop built to be compatible with versions `8.1.x` and above.

## 🔍 Theme Previews

| [<img src="https://github.com/user-attachments/assets/66c2611c-f10e-4371-8495-212c4522705e">](https://github.com/user-attachments/assets/59828a32-462d-437b-b137-3c78ce057bb6) | [<img src="https://github.com/user-attachments/assets/345a4813-33c3-45d8-92c7-18a34db81786">](https://github.com/user-attachments/assets/77e5e3ec-1004-4f69-bda6-c51a140c812f) | [<img src="https://github.com/user-attachments/assets/b27625ec-ff08-40a2-8ef8-f63392254c43">](https://github.com/user-attachments/assets/31a1966b-6e73-44af-9735-874666ae486a) |
| --- | --- | --- |
| Homepage | Category | Product |

## ⚠️ Requirements

To work on Hummingbird, you'll need:

- Node.js **v20.x**.
- npm **v8**.

## 📑 Table of Contents
- Want to help develop the theme? Start with [🧑‍💻 Develop on Hummingbird](#-develop-on-hummingbird).
- Want to preview or test it? Jump to [🐳 Run Hummingbird with Docker](#-run-hummingbird-with-docker).
- Having issues with caching during development? Jump to [🥵 Troubleshooting](#-troubleshooting).

## 🧑‍💻 Develop on Hummingbird

### 🧰 Installation / Setup

#### 👀 Watch Mode Setup

From the **project root** run the following commands if you want to:

1. Install dependencies: `npm ci`.
2. Run watch mode to build assets: `npm run watch`.
3. You can now go to [🐳 Run Hummingbird with Docker](#-run-hummingbird-with-docker) section to run PrestaShop embedding Hummingbird.

#### 🔥 Hot Module Reload (HMR) Setup

1. From the **project root** run: `npm ci`.
2. Navigate to the `webpack/` directory.
3. Run `cp .env-docker-example .env` or `cp .env-vhost-example .env` (depending on how you want to run your PrestaShop environment).
4. Edit `.env` with your local environment settings and ensure you use a free TCP port.
5. From the **project root** run `npm run dev`.
6. You can now go to [🐳 Run Hummingbird with Docker](#-run-hummingbird-with-docker) section to run PrestaShop embedding Hummingbird.

### 🖌️ Code Quality

To ensure code quality and consistency, run the following commands from the **project root**:

- Lint & auto-fix SCSS files: `npm run stylelint` or `npm run stylelint:fix`.
- Format & auto-format SCSS with Prettier: `npm run prettier` or `npm run prettier:fix`.
- Lint & auto-fix JS/TS files: `npm run lint` or `npm run lint:fix`.

## 🐳 Run Hummingbird with Docker

This theme includes Docker configurations for both **PrestaShop** and **PrestaShop Flashlight** development environments.

### 🛠️ Getting Started

**Note:** If you've already set up your development environment using `Watch Mode` or `Hot Module Reload (HMR)`, you can skip ahead to **step 3**.

1. From the **project root** run: `npm ci`.
2. Then run: `npm run build`.
3. Navigate to the `docker/` directory: `cd docker`.
4. Copy the example environment file: `cp .env-example .env`.
5. Edit `.env` to configure the following variables:
   - `PS_TAG`: PrestaShop or Flashlight version tag.
      - [PrestaShop tags](https://hub.docker.com/r/prestashop/prestashop/tags).
      - [Flashlight tags](https://hub.docker.com/r/prestashop/prestashop-flashlight/tags).
   - `PLATFORM`: Platform architecture (e.g., linux/amd64, linux/arm64).
   - `ADMIN_EMAIL`: Back office admin email.
   - `ADMIN_PASSWORD`: Back office admin password.

### 📦 Available Configurations

- `docker-compose-prestashop.yml`: for standard PrestaShop development environment.
- `docker-compose-flashlight.yml`: for PrestaShop Flashlight development environment.

### ▶️ Starting the Environment

From the **project root**, run one of the following commands:

```bash
# For PrestaShop environment
docker compose -f docker/docker-compose-prestashop.yml up -d

# For Flashlight environment
docker compose -f docker/docker-compose-flashlight.yml up -d
```

### 👀 After Starting the Environment
- PrestaShop/Flashlight will be available at http://localhost:8887 and BO at http://localhost:8887/admin-dev.
- phpMyAdmin will be available at http://localhost:8889.

### ⏹️ Stopping the Environment

From the **project root**, run one of the following commands:

```bash
# For PrestaShop environment
docker compose -f docker/docker-compose-prestashop.yml down -v

# For Flashlight environment
docker compose -f docker/docker-compose-flashlight.yml down
```

## 🥵 Troubleshooting

> [!WARNING]  
> If you're experiencing issues with styles or assets not updating while using HMR mode, follow these steps to avoid browser and PrestaShop caching problems:

1. Disable browser cache during development:
    - Open your browser's DevTools.
    - Go to the `Network` tab.
    - Enable `Disable cache` (⚠️ this only works while DevTools stays open).
2. Disable PrestaShop caching:
    - In the back office, go to: `Advanced Parameters` → `Performance`.
    - Under the Smarty section:
        - Set Force compilation to `Yes`.
        - Set Cache to `No`.
    - Under the CCC (Combine, Compress and Cache) section:
        - Disable all options.

## 📚 Storybook

Storybook is used to document and preview the theme's UI components during development. You can view the [live documentation here](https://build.prestashop.com/hummingbird/). Since the theme is still in progress, contributions to improve or expand the documentation are welcome and encouraged.

### ▶️ Run Storybook Locally

To run Storybook on your machine:

1. Make sure project dependencies are installed, if not, from the **project root** run: `npm ci`.
2. Then run: `npm run storybook`.
3. Storybook will be available at http://localhost:6006.

## 🤝 Contributing

Please refer to the [contributing guide](CONTRIBUTING.md).

## ✅ Continuous Integration

The CI runs include Stylelint, Prettier, ESLint, and TypeScript type checks.

## 🚀 Continuous Deployment

Whenever the `develop` branch is merged into `master`, the Storybook documentation is automatically deployed to GitHub Pages and becomes publicly accessible within minutes.

## 📄 License

This theme is released under the [Academic Free License 3.0][AFL-3.0].

[AFL-3.0]: https://opensource.org/licenses/AFL-3.0
