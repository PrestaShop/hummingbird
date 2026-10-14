<?php

/**
 * For the full copyright and license information, please view the
 * LICENSE.md file that was distributed with this source code.
 */

/**
 * Smarty modifier `srcset`: builds the srcset attribute values of an image from the sizes the shop has.
 *
 * For each requested image type found in the image's `bySize`, it adds one candidate (URL + descriptor)
 * per format: the default URL, `sources.webp` and `sources.avif`. Types or formats the shop does not
 * have are skipped. A format with no candidate returns an empty string, so the template can drop the
 * attribute or the <source> altogether.
 *
 * Usage:
 *
 *   {$srcset = $image|srcset:['default_sm', 'default_md']}
 *     -> ".../default_sm/1.jpg 216w, .../default_md/1.jpg 261w" (widths read from each size)
 *
 *   {$srcset = $image|srcset:['default_xs' => '1x', 'default_md' => '2x']}
 *     -> ".../default_xs/1.jpg 1x, .../default_md/1.jpg 2x" (descriptors given explicitly)
 *
 *   Then print {$srcset.url} on the <img>, and include `_partials/picture-sources.tpl` for the
 *   avif/webp <source> elements. The values are not escaped, so the front office's automatic
 *   escaping applies as usual.
 *
 * @param mixed $image the value before the `|`: an image array with a `bySize` map (e.g. `$product.cover`);
 *                     anything else gives empty values
 * @param array<int|string, string>|string $imageTypes the argument after the `:`: type names, type => descriptor
 *                                                     map, or a single type name
 *
 * @return array{url: string, webp: string, avif: string} srcset per format, '' when empty
 */
function smarty_modifier_srcset(mixed $image, array|string $imageTypes): array
{
    $bySize = is_array($image) && isset($image['bySize']) && is_array($image['bySize'])
        ? $image['bySize']
        : [];

    if (is_string($imageTypes)) {
        $imageTypes = [$imageTypes];
    }

    $candidates = ['url' => [], 'webp' => [], 'avif' => []];

    foreach ($imageTypes as $key => $value) {
        [$type, $descriptor] = is_int($key) ? [$value, null] : [$key, $value];

        $size = $bySize[$type] ?? null;
        if (!is_array($size)) {
            continue;
        }

        if ($descriptor === null) {
            $width = (int) ($size['width'] ?? 0);
            if ($width <= 0) {
                continue;
            }
            $descriptor = $width . 'w';
        }

        foreach (array_keys($candidates) as $format) {
            $url = $format === 'url' ? ($size['url'] ?? null) : ($size['sources'][$format] ?? null);
            if (!is_string($url) || $url === '') {
                continue;
            }
            $candidates[$format][] = $descriptor === '' ? $url : $url . ' ' . $descriptor;
        }
    }

    return array_map(static fn (array $list): string => implode(', ', $list), $candidates);
}
