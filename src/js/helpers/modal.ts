import selectorsMap from '@js/constants/selectors-map';

export default function getModalContentContainer(): HTMLElement {
  let container = document.querySelector<HTMLElement>(selectorsMap.modalContainer.selector);

  if (!container) {
    container = document.createElement('div');
    container.setAttribute(selectorsMap.modalContainer.attribute, selectorsMap.modalContainer.value);
    document.body.appendChild(container);
  }
  return container;
}
