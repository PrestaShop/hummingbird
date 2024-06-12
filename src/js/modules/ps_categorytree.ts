const initCategoryTree = () => {
  const categoryTree = document.querySelector('.ps_categorytree');

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
