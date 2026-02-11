import useAlertContent from './usealert.html';

export default {
  title: 'Theme/JavaScript/Components/useAlert',
  parameters: {
    docs: {
      autodocs: false,
    }
  }
};

export const BasicUsage = () => useAlertContent;
BasicUsage.parameters = {
  docs: {
    source: {
      code: useAlertContent
    },
    description: {
      story: `
<h1>useAlert</h1>

<p><strong>useAlert</strong> is accessible through <code>window.Theme.components.useAlert</code>.</p>

<h2>Concept</h2>

<p>The alert container is the default notifications container of the theme, you can use another one specifying the selector option.</p>

<p>The toast markup is generated on the fly by the javascript, based on bootstrap.</p>

<h2>Parameters</h2>

<p><strong>text</strong> (Optional): string;<br>
<strong>options</strong> (Optional): Options;</p>

<h2>Options</h2>

<p><strong>type</strong>:  'light' | 'dark' | 'primary' | 'secondary' | 'info' | 'success' | 'warning' | 'danger'<br>
<strong>icon</strong> (Optional): string;<br>
<strong>title</strong> (Optional): string;<br>
<strong>dismissible</strong> (Optional): boolean;<br>
<strong>classlist</strong> (Optional): string;<br>
<strong>selector</strong> (Optional): string;</p>

<h2>Return</h2>
<p>useAlert return an Object, here is the definition:</p>
<pre><code>interface Instance {
  instance: Alert | null;
  element: HTMLElement | null;
  show: () => boolean;
  hide: () => boolean;
  dispose: () => boolean;
  remove: () => boolean;
  title: (markup?: string) => string | boolean;
  message: (markup?: string) => string | boolean;
}</code></pre>

<h3>Examples</h3>
<p>Overall destructuring is a good practice, if you can, use it!</p>

<p>Without any options:</p>
      `
    }
  }
};
BasicUsage.play = async ({canvasElement}) => {
  const btn = document.querySelector('.btn');
  btn.addEventListener('click', () => {
    const {show} = window.Theme.components.useAlert('Lorem ipsum sit dolor amet');
    show();
  });
};

export const WithPrimaryParameter = () => useAlertContent;
WithPrimaryParameter.parameters = {
  docs: {
    source: {
      code: useAlertContent
    },
    description: {
      story: `
<p>Without a different colorscheme:</p>

<pre><code>const {show} = window.Theme.components.useAlert('Lorem ipsum sit dolor amet', {type: 'primary'});
show();</code></pre>
      `
    }
  }
};
WithPrimaryParameter.play = async ({canvasElement}) => {
  const btn = document.querySelector('.btn');
  btn.addEventListener('click', () => {
    const {show} = window.Theme.components.useAlert('Lorem ipsum sit dolor amet', {type: 'primary'});
    show();
  });
};
