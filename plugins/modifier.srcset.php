<?php

/**
 * For the full copyright and license information, please view the
 * LICENSE.md file that was distributed with this source code.
 */

/**
 * Smarty modifier `srcset`: builds a srcset attribute value from the image sizes the shop has.
 *
 * An image type declared in config/theme.yml only reaches `bySize` once the shop holds a row for it
 * in ps_image_type, which happens when the theme is enabled, not on every upgrade. A template that
 * names a type unconditionally therefore emits a candidate with a descriptor and no URL on a shop
 * missing that type (` 216w`), which browsers resolve as a relative URL. This modifier only emits
 * the candidates whose size exists, and returns an empty string when none does, so the template can
 * drop the attribute altogether.
 *
 * Usage:
 *
 *   {$image|srcset:['default_sm', 'default_md', 'default_lg']}
 *     -> width descriptors taken from each size: ".../default_sm/1.jpg 216w, .../default_md/1.jpg 261w, ..."
 *
 *   {$image|srcset:['default_xs' => '1x', 'default_md' => '2x']:'webp'}
 *     -> explicit descriptors, URLs read from the `webp` entry of each size's `sources`
 *
 * The returned string is raw: print it with `{$var}` so the front office's automatic HTML escaping
 * applies, as for any other template variable.
 *
 * @param mixed $image image array exposing a `bySize` map, as built by ImageRetriever
 *                     (e.g. `$product.cover`, `$urls.no_picture_image`). Anything else yields ''.
 * @param array<int|string, string>|string $imageTypes list of image type names (width descriptors are
 *                                                     derived from each size's `width`), map of image type
 *                                                     name => descriptor ('2x', '320w', '' for none), or a
 *                                                     single type name
 * @param string|null $format key of `sources` to read ('avif', 'webp'), or null for the default `url`
 *
 * @return string comma-separated srcset candidates, '' when no listed size exists
 */
function smarty_modifier_srcset($image, array|string $imageTypes, ?string $format = null): string
{
    if (is_string($imageTypes)) {
        $imageTypes = [$imageTypes];
    }

    $bySize = is_array($image) && isset($image['bySize']) && is_array($image['bySize'])
        ? $image['bySize']
        : [];

    $candidates = [];

    foreach ($imageTypes as $key => $value) {
        [$type, $descriptor] = is_int($key) ? [$value, null] : [$key, $value];

        $size = $bySize[$type] ?? null;
        if (!is_array($size)) {
            continue;
        }

        $url = $format === null ? ($size['url'] ?? null) : ($size['sources'][$format] ?? null);
        if (!is_string($url) || $url === '') {
            continue;
        }

        if ($descriptor === null) {
            if (empty($size['width'])) {
                continue;
            }
            $descriptor = (int) $size['width'] . 'w';
        }

        $candidates[] = $descriptor === '' ? $url : $url . ' ' . $descriptor;
    }

    return implode(', ', $candidates);
}
