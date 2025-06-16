# Hummingbird Theme for PrestaShop

Hummingbird is a modern, in-development theme for PrestaShop built to be compatible with versions `8.1.x` and above.

## 🔍 Theme previews

| [<img src="https://github.com/user-attachments/assets/66c2611c-f10e-4371-8495-212c4522705e">](https://github.com/user-attachments/assets/59828a32-462d-437b-b137-3c78ce057bb6) | [<img src="https://github.com/user-attachments/assets/345a4813-33c3-45d8-92c7-18a34db81786">](https://github.com/user-attachments/assets/77e5e3ec-1004-4f69-bda6-c51a140c812f) | [<img src="https://github.com/user-attachments/assets/b27625ec-ff08-40a2-8ef8-f63392254c43">](https://github.com/user-attachments/assets/31a1966b-6e73-44af-9735-874666ae486a) |
| --- | --- | --- |
| Homepage | Category | Product |

## 🛠️ Getting Started

To build the theme assets, you'll need:

- Node.js **v20.x**.
- npm **v8**.

### 🧰 Installation

1. Install dependencies, from the **project root** run: `npm ci`.
2. Set up environment:
    - 👀 Using watch mode:
      - From the **project root** run `npm run watch`.
    - 🔥 Using HMR:
      - Navigate to the `webpack/` directory.
      - Copy `.env-docker-example` or `.env-vhost-example` (depending on how you will run PrestaShop) to `.env` in the `webpack/` directory.
      - Edit `.env` with your local environment settings and ensure you use a free TCP port.
      - **To avoid issues with cached files during development:**
        - Open your browser's DevTools.
        - Go to the Network tab and enable 'Disable cache' **(⚠️ this setting works only while DevTools remains open)**.
        - In the PrestaShop back office, go to **Advanced Parameters > Performance**. In the **Smarty** section, enable `Force compilation` and set Cache to `No`. Then, in the **CCC (Combine, Compress and Cache)** section, disable all available options. This ensures your theme changes are applied immediately during development.
      - From the **project root** run `npm run dev`.
3. Build production assets, from the **project root** run `npm run build`.

### 🖌️ Linting

To ensure code quality and consistency, run the following commands:

- Lint & auto-fix SCSS files: `npm run stylelint` or `npm run stylelint:fix`.
- Format & auto-format SCSS with Prettier: `npm run prettier` or `npm run prettier:fix`.
- Lint & auto-fix JS/TS files: `npm run lint` or `npm run lint:fix`.

## 🐳 Docker Environment

This theme includes Docker configurations for both **PrestaShop** and **PrestaShop Flashlight** development environments.

### 🛠️ Getting Started

1. Navigate to the `docker/` directory.
2. Copy the example environment file: `cp .env-example .env`.
3. Edit `.env` to configure the following variables:
   - `PS_TAG`: PrestaShop or Flashlight version tag.
      - [Prestashop tags](https://hub.docker.com/r/prestashop/prestashop/tags).
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

### 👀 After starting the environment
- PrestaShop/Flashlight will be available at http://localhost:8887 and BO at http://localhost:8887/admin-dev
- phpMyAdmin will be available at http://localhost:8889

### ⏹️ Stopping the environment

From the **project root**, run one of the following commands:

```bash
# For PrestaShop environment
docker compose -f docker/docker-compose-prestashop.yml down -v

# For Flashlight environment
docker compose -f docker/docker-compose-flashlight.yml down
```

## 📚 Storybook

Storybook is used to document and preview the theme's UI components during development. You can view the [live documentation here](https://build.prestashop.com/hummingbird/). Since the theme is still in progress, contributions to improve or expand the documentation are welcome and encouraged.

## Contributing

Please refer to the [contributing guide](https://github.com/PrestaShop/hummingbird/blob/develop/CONTRIBUTING.md)

## Continuous Integration

The CI runs contain stylelint, eslint, TypeScript type checks.

## Continuous Deployment

Whenever the `develop` branch is merged into `master`, the Storybook documentation is automatically deployed to GitHub Pages and becomes publicly accessible within minutes.

## License

This theme is released under the [Academic Free License 3.0][AFL-3.0]

[AFL-3.0]: https://opensource.org/licenses/AFL-3.0
