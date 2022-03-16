# PrestaShop 8.0

This theme is the new theme of PrestaShop. Please, if you work on this theme, use the `develop` branch of PrestaShop, because this theme will be available on 8.0

[Read more](https://build.prestashop.com/news/new-theme-announce/) about this theme on the blog.

## How to build assets

Same as the PrestaShop project, you need **NodeJS 14.x** and **NPM 7** in order to build the project.

First you need to install every node module:

`npm i`

then create a `.env` file inside the *webpack* folder by copying `webpack/.env-example` and complete it with your environment's informations. Please use a free tcp port.

then build assets:

`npm run build`

## License

This theme is released under the [Academic Free License 3.0][AFL-3.0] 

[AFL-3.0]: https://opensource.org/licenses/AFL-3.0
