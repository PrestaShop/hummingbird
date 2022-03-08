# Smarty template generator

This script is used to generate static smarty template from the theme, in order to display some components or to be used inside jest tests.

## Datas

The `datas` folder contains some datas required for smarty to be compiled into static HTML.

You can generate these datas using the `|@json_encode` smarty modifier. (Example: `{$page|@json_encode}`)

## Constants

They are used as a script dependency, basically container templates to generate and other informations needed for the script to run.

## Build

This will output templates inside the build folder, using the same path as the theme, so you can include them inside Storybook.
