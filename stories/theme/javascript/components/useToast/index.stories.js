import { Meta, Story, Canvas } from '@storybook/addon-docs/blocks';
import useToastContent from './usetoast.html'
import useMultipleContent from './multiple.html'

export default {
  title: 'Theme/JavaScript/Components/useToast',
  parameters: {
    docs: {
      autodocs: false,
    }
  }
};

export const BasicUsage = () => useToastContent;
BasicUsage.parameters = {
  docs: {
    source: {
      code: useToastContent
    },
    description: {
      story: `
<h1>useToast</h1>

<p><strong>useToast</strong> is accessible through <code>window.Theme.components.useToast</code>.</p>

<h2>Concept</h2>

<p>The useToast function use the markup of <a href="https://github.com/PrestaShop/theme-refacto/blob/develop/templates/components/toast-container.tpl">toast-container.tpl</a> and <a href="https://github.com/PrestaShop/theme-refacto/blob/develop/templates/components/toast.tpl">toast.tpl</a>.</p>

<p>The toast container is placed on the top right of the viewport by default.</p>

<p>The toast markup is generated on the fly using the <code>&lt;template&gt;</code> element.</p>

<p>If these files has been removed from the theme, it generates everything on-the fly using JavaScript only, to avoid failure cases.</p>

<p>If the template is not on the page, and you override the toast template, if your override is wrong, it will not throw an error to avoid blocking the JavaScript execution but it will send an error to the console and return <code>false</code>.</p>

<h2>Options</h2>

<p><strong>type</strong>:  'light' | 'dark' | 'primary' | 'secondary' | 'info' | 'success' | 'warning' | 'danger'<br>
<strong>autohide</strong> (Optional): boolean;<br>
<strong>delay</strong> (Optional): number;<br>
<strong>classlist</strong> (Optional): string;<br>
<strong>template</strong> (Optional): string;</p>

<h2>Return</h2>
<p>useToast return an Object, here is the definition:</p>

<pre><code>interface Instance {
  // Bootstrap instance
  instance: Toast | null;
  element: HTMLElement | null;
  content: HTMLElement | null;
  // Bootstrap methods wrapped
  show: () => boolean;
  hide: () => boolean;
  dispose: () => boolean;
  remove: () => boolean;
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
    const {show} = window.Theme.components.useToast('Test');
    show();
  });
};

export const WithPrimaryParameter = () => useToastContent;
WithPrimaryParameter.parameters = {
  docs: {
    source: {
      code: useToastContent
    },
    description: {
      story: `
<p>Without a different colorscheme:</p>

<pre><code>const {show} = window.Theme.components.useToast('Test', {type: 'primary'});
show();</code></pre>
      `
    }
  }
};
WithPrimaryParameter.play = async ({canvasElement}) => {
  const btn = document.querySelector('.btn');
  btn.addEventListener('click', () => {
    const {show} = window.Theme.components.useToast('Test', {type: 'primary'});
    show();
  });
};

export const WithoutAutohide = () => useToastContent;
WithoutAutohide.parameters = {
  docs: {
    source: {
      code: useToastContent
    },
    description: {
      story: `
<p>Without autohide:</p>

<pre><code>const {show} = window.Theme.components.useToast('Test', {autohide: false});
show();</code></pre>
      `
    }
  }
};
WithoutAutohide.play = async ({canvasElement}) => {
  const btn = document.querySelector('.btn');
  btn.addEventListener('click', () => {
    const {show} = window.Theme.components.useToast('Test', {autohide: false});
    show();
  });
};

export const WithTemplateOverridden = () => useToastContent;
WithTemplateOverridden.parameters = {
  docs: {
    source: {
      code: useToastContent
    },
    description: {
      story: `
<p>With template overridden:</p>

<pre><code>const myTemplate = \`
  <div class="toast toast--override">
    <div class="toast-header">My header text</div>
    <div class="toast-body"></div>
  </div>
\`
const {show} = window.Theme.components.useToast('Test', {template: myTemplate});
show();</code></pre>
      `
    }
  }
};
WithTemplateOverridden.play = async ({canvasElement}) => {
  const myTemplate = `
    <div class="toast toast--override">
      <div class="toast-header">My header text</div>
      <div class="toast-body"></div>
    </div>
  `;
  const btn = document.querySelector('.btn');
  btn.addEventListener('click', () => {
    const {show} = window.Theme.components.useToast('Test', {template: myTemplate});
    show();
  });
};

export const MultipleToasts = () => useMultipleContent;
MultipleToasts.parameters = {
  docs: {
    source: {
      code: useMultipleContent
    },
    description: {
      story: `
<p>Use multiple toasts at the same time:</p>

<pre><code>const {useToast} = window.Theme.components;

const btnPrimary = document.querySelector('.btn-primary');
const btnSecondary = document.querySelector('.btn-secondary');

const {show: showPrimaryToast} = useToast('Test with primary', {type: 'primary'});
const {show: showSecondaryToast} = useToast('Test with secondary', {type: 'secondary'});

btnPrimary.addEventListener('click', () => {
  showPrimaryToast();
});

btnSecondary.addEventListener('click', () => {
  showSecondaryToast();
});</code></pre>
      `
    }
  }
};
MultipleToasts.play = async ({canvasElement}) => {
  const {useToast} = window.Theme.components;
  const btnPrimary = document.querySelector('.btn-primary');
  const btnSecondary = document.querySelector('.btn-secondary');
  const {show: showPrimaryToast} = useToast('Test with primary', {type: 'primary'});
  const {show: showSecondaryToast} = useToast('Test with secondary', {type: 'secondary'});
  btnPrimary.addEventListener('click', () => {
    showPrimaryToast();
  });
  btnSecondary.addEventListener('click', () => {
    showSecondaryToast();
  });
};
