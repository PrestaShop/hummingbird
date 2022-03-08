import './colors.scss';

export default function renderContent(array, isColor) {
  let principalContent = '<div class="color-container">';

  Object.keys(array).forEach((variableName) => {
    if (isColor) {
      principalContent += `<div class="color"><span class="color-name">${variableName}</span><div class="color-code"><span class="color-box" style="background-color: ${array[variableName]};"></span> ${array[variableName]}</div></span></div>`;
    } else {
      principalContent += `<div class="color"><span class="color-name">${variableName}</span> ${array[variableName]}</div></span></div>`;
    }
  });

  principalContent += '</div>';

  return principalContent;
}
