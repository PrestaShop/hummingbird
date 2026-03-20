/**
 * For the full copyright and license information, please view the
 * LICENSE.md file that was distributed with this source code.
 */
const initCategoryTree = () => {
  const categoryTree = document.querySelector('.ps-categorytree');

  if (categoryTree) {
    const accordionButtons = categoryTree.querySelectorAll('.accordion-button');

    accordionButtons.forEach((element) => {
      element.addEventListener('click', () => {
        const isActive = element.getAttribute('aria-expanded') === 'true';
        element.closest('.category-tree__item')?.classList.toggle('active', isActive);
      });
    });
  }
};

export default initCategoryTree;
