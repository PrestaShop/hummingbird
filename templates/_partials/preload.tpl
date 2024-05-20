{$themeDir = _PS_THEME_DIR_}
{$preloadFilePath = "`$themeDir`assets/preload.html"}
{$assetsUrl = $urls.theme_assets}

{if file_exists($preloadFilePath)}
  {capture name="preloadBlock"}{include file=$preloadFilePath}{/capture}
  {$smarty.capture.preloadBlock|replace:'href="../':"href=\"$assetsUrl" nofilter}
{/if}
