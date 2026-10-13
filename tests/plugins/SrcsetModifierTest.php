<?php

/**
 * For the full copyright and license information, please view the
 * LICENSE.md file that was distributed with this source code.
 */

declare(strict_types=1);

namespace Tests\Plugins;

use PHPUnit\Framework\Attributes\DataProvider;
use PHPUnit\Framework\TestCase;

require_once __DIR__ . '/../../plugins/modifier.srcset.php';

final class SrcsetModifierTest extends TestCase
{
    private const EMPTY = ['url' => '', 'webp' => '', 'avif' => ''];

    /**
     * A `bySize` entry as ImageRetriever::getImage() builds it. The no-picture image has no `sources`.
     *
     * @return array{url: string, width: int, height: int, sources?: array<string, string>}
     */
    private static function imageSize(string $type, int $width, bool $withSources = true): array
    {
        $size = ['url' => "https://shop.test/img/p/1-$type.jpg", 'width' => $width, 'height' => $width];
        if ($withSources) {
            $size['sources'] = [
                'jpg' => "https://shop.test/img/p/1-$type.jpg",
                'avif' => "https://shop.test/img/p/1-$type.avif",
                'webp' => "https://shop.test/img/p/1-$type.webp",
            ];
        }

        return $size;
    }

    /** @return array<string, mixed> */
    private static function image(string ...$types): array
    {
        $widths = ['default_xs' => 160, 'default_sm' => 216, 'default_md' => 261, 'default_lg' => 336];
        $bySize = [];
        foreach ($types as $type) {
            $bySize[$type] = self::imageSize($type, $widths[$type]);
        }

        return ['bySize' => $bySize, 'legend' => 'Mug'];
    }

    public function testListDerivesWidthDescriptorsFromEachSizeForEveryFormat(): void
    {
        $image = self::image('default_sm', 'default_md', 'default_lg');

        self::assertSame(
            [
                'url' => 'https://shop.test/img/p/1-default_sm.jpg 216w, https://shop.test/img/p/1-default_md.jpg 261w, https://shop.test/img/p/1-default_lg.jpg 336w',
                'webp' => 'https://shop.test/img/p/1-default_sm.webp 216w, https://shop.test/img/p/1-default_md.webp 261w, https://shop.test/img/p/1-default_lg.webp 336w',
                'avif' => 'https://shop.test/img/p/1-default_sm.avif 216w, https://shop.test/img/p/1-default_md.avif 261w, https://shop.test/img/p/1-default_lg.avif 336w',
            ],
            smarty_modifier_srcset($image, ['default_sm', 'default_md', 'default_lg'])
        );
    }

    public function testMapUsesExplicitDescriptors(): void
    {
        $image = self::image('default_xs', 'default_md');

        self::assertSame(
            'https://shop.test/img/p/1-default_xs.jpg 1x, https://shop.test/img/p/1-default_md.jpg 2x',
            smarty_modifier_srcset($image, ['default_xs' => '1x', 'default_md' => '2x'])['url']
        );
    }

    public function testEmptyDescriptorEmitsTheBareUrl(): void
    {
        $image = self::image('default_xs', 'default_md');

        self::assertSame(
            'https://shop.test/img/p/1-default_xs.jpg, https://shop.test/img/p/1-default_md.jpg 2x',
            smarty_modifier_srcset($image, ['default_xs' => '', 'default_md' => '2x'])['url']
        );
    }

    public function testMissingSizesAreSkippedAndOrderIsKept(): void
    {
        // The reported shop: upgraded from 9.0.x, it carries default_md but neither default_sm nor default_lg.
        $image = self::image('default_md');

        self::assertSame(
            [
                'url' => 'https://shop.test/img/p/1-default_md.jpg 261w',
                'webp' => 'https://shop.test/img/p/1-default_md.webp 261w',
                'avif' => 'https://shop.test/img/p/1-default_md.avif 261w',
            ],
            smarty_modifier_srcset($image, ['default_sm', 'default_md', 'default_lg'])
        );
        self::assertSame(
            'https://shop.test/img/p/1-default_md.jpg 2x',
            smarty_modifier_srcset($image, ['default_xs' => '1x', 'default_md' => '2x'])['url']
        );
    }

    public function testEveryFormatIsEmptyWhenNoListedSizeExists(): void
    {
        self::assertSame(self::EMPTY, smarty_modifier_srcset(self::image('default_xs'), ['default_sm', 'default_lg']));
        self::assertSame(self::EMPTY, smarty_modifier_srcset(['bySize' => []], ['default_sm']));
    }

    public function testFormatsMissingFromSourcesStayEmpty(): void
    {
        // The no-picture image exposes `url` only: the <source> elements must not be emitted.
        $image = ['bySize' => ['default_md' => self::imageSize('default_md', 261, false)]];

        self::assertSame(
            ['url' => 'https://shop.test/img/p/1-default_md.jpg 261w', 'webp' => '', 'avif' => ''],
            smarty_modifier_srcset($image, ['default_md'])
        );
    }

    public function testSizeWithoutWidthIsSkippedInListMode(): void
    {
        $image = ['bySize' => ['default_md' => ['url' => 'https://shop.test/x.jpg']]];

        self::assertSame(self::EMPTY, smarty_modifier_srcset($image, ['default_md']));
        self::assertSame('https://shop.test/x.jpg 2x', smarty_modifier_srcset($image, ['default_md' => '2x'])['url']);
    }

    public function testSingleTypeNameIsAcceptedAsAString(): void
    {
        $image = self::image('default_md');

        self::assertSame('https://shop.test/img/p/1-default_md.jpg 261w', smarty_modifier_srcset($image, 'default_md')['url']);
        self::assertSame(self::EMPTY, smarty_modifier_srcset($image, 'default_sm'));
    }

    /** @return iterable<string, array{mixed}> */
    public static function nonImages(): iterable
    {
        yield 'null' => [null];
        yield 'false' => [false];
        yield 'empty array' => [[]];
        yield 'string' => ['https://shop.test/x.jpg'];
        yield 'bySize not an array' => [['bySize' => 'oops']];
    }

    #[DataProvider('nonImages')]
    public function testAnythingButAnImageArrayYieldsEmptyValues(mixed $image): void
    {
        self::assertSame(self::EMPTY, smarty_modifier_srcset($image, ['default_sm', 'default_md']));
    }

    public function testReturnsRawUrlsForTheTemplateToEscape(): void
    {
        $image = ['bySize' => ['default_md' => ['url' => 'https://shop.test/x.jpg?a=1&b=2', 'width' => 261]]];

        self::assertSame('https://shop.test/x.jpg?a=1&b=2 261w', smarty_modifier_srcset($image, ['default_md'])['url']);
    }
}
