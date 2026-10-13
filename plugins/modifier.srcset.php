<?php

/**
 * For the full copyright and license information, please view the
 * LICENSE.md file that was distributed with this source code.
 */

/**
 * Smarty modifier `srcset`: builds the srcset attribute values of an image from the sizes the shop has.
 *
 * An image type declared in config/theme.yml only reaches `bySize` once the shop holds a row for it
 * in ps_image_type, which happens when the theme is enabled, not on every upgrade. A template that
 * names a type unconditionally therefore emits a candidate with a descriptor and no URL on a shop
 * missing that type (` 216w`), which browsers resolve as a relative URL. This modifier only emits
 * the candidates whose size exists, and returns an empty string for a format with none, so the
 * template can drop the attribute or the <source> altogether.
 *
 * Usage:
 *
 *   {$srcset = $image|srcset:['default_sm', 'default_md', 'default_lg']}
 *     -> width descriptors taken from each size:
 *        $srcset.url  = ".../default_sm/1.jpg 216w, .../default_md/1.jpg 261w, .../default_lg/1.jpg 336w"
 *        $srcset.webp = the same list read from each size's `sources.webp`, '' when the shop has no webp
 *        $srcset.avif = idem for avif
 *
 *   {$srcset = $image|srcset:['default_xs' => '1x', 'default_md' => '2x']}
 *     -> explicit descriptors
 *
 * The returned strings are raw: print them with `{$srcset.webp}` so the front office's automatic
 * HTML escaping applies, as for any other template variable.
 *
 * @param mixed $image image array exposing a `bySize` map, as built by ImageRetriever
 *                     (e.g. `$product.cover`, `$urls.no_picture_image`). Anything else yields empty values.
 * @param array<int|string, string>|string $imageTypes list of image type names (width descriptors are
 *                                                     derived from each size's `width`), map of image type
 *                                                     name => descriptor ('2x', '320w', '' for none), or a
 *                                                     single type name
 *
 * @return array{url: string, webp: string, avif: string} comma-separated srcset candidates per format,
 *                                                        '' when no listed size exists for that format
 */
function smarty_modifier_srcset($image, array|string $imageTypes): array
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
            if (empty($size['width'])) {
                continue;
            }
            $descriptor = (int) $size['width'] . 'w';
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
