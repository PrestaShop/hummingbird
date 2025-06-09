import useProgressRingContent from './useprogressring.html';

export default {
  title: 'Theme/JavaScript/Components/useProgressRing',
  parameters: {
    docs: {
      autodocs: false,
    }
  }
};

export const BasicUsage = () => useProgressRingContent;
BasicUsage.parameters = {
  docs: {
    source: {
      code: useProgressRingContent
    },
    description: {
      story: `
<h1>useProgressRing</h1>

<p><strong>useProgressRing</strong> is accessible through <code>window.Theme.components.useProgressRing</code>.</p>

<h2>Concept</h2>

<p>You can use the smarty file from <code>components/progress-circle.tpl</code>.</p>

<p>Example: <code>{include file="components/progress-circle.tpl" classes="text-success col-4" size=74 stroke=4 percent=50 text={l s='2 / 4' d='Shop.Theme.Checkout'}}</code></p>

<p>The progress ring use the text color for the ring color.</p>

<p><strong>Size, stroke, percent</strong> are required in order to set the default state of the ring.</p>

<p>Initial calculation for the ring are done in smarty, so every child themes can override it and change the behavior.</p>

<h2>Options</h2>

<p><strong>element</strong>:  HTMLElement</p>

<h2>Return</h2>
<p>useProgressRing return an Object, here is the definition:</p>

<pre><code>interface ProgressRingReturn {
  setProgress?: (perfect: number) => void
  error?: Error
}</code></pre>

<h3>Examples</h3>
<p>Overall destructuring is a good practice, if you can, use it!</p>
      `
    }
  }
};
BasicUsage.play = async ({canvasElement}) => {
  const progressElement = document.querySelector(window.prestashop.themeSelectors.progressRing.checkout.element);
  const {setProgress, error} = window.Theme.components.useProgressRing(progressElement);
  if (!error && setProgress) {
    setProgress(75);
  }
};

export const WithExample = () => useProgressRingContent;
WithExample.parameters = {
  docs: {
    source: {
      code: useProgressRingContent
    },
    description: {
      story: `
<p>Without a different colorscheme:</p>

<pre><code>const progressElement = document.querySelector<HTMLElement>(window.prestashop.themeSelectors.progressRing.checkout.element);
const {setProgress, error} = window.Theme.components.useProgressRing(progressElement);

if (!error && setProgress) {
  setProgress(75);
}</code></pre>
      `
    }
  }
};
