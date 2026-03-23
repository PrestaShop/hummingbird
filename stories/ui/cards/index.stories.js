/**
 * For the full copyright and license information, please view the
 * LICENSE.md file that was distributed with this source code.
 */
import cardContent from './cards.html';

export default {
  title: 'UI/Cards',
  parameters: {
    docs: {
      description: {
        component: 'Cards are used to group related content and actions.'
      }
    }
  }
};

export const Cards = () => cardContent;
Cards.parameters = {
  docs: {
    source: {
      code: cardContent
    }
  }
};
