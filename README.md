# PrestaShop 8.0

This theme is the new theme of PrestaShop. Please, if you work on this theme, use the `develop` branch of PrestaShop, because this theme will be available on 8.0

## How to build assets

Same as the PrestaShop project, you need **NodeJS 14.x** and **NPM 7** in order to build the project.

First you need to install every node module:

`npm i`

then create a webpack/.env by copying webpack/.env-example
`cp webpack/.env-example webpack/.env`

then configure your local web server in this .env file. Please use a free tcp port

then build assets:

`npm run build`

