import inputContent from './input.html'
import disabledContent from './disabled.html'
import helperContent from './helper.html'
import checkboxesContent from './checkboxes.html'
import radiosContent from './radios.html'
import switchContent from './switch.html'
import selectContent from './selects.html'
import statesContent from './states.html'
import groupContent from './input-group.html'
import inputDropdownContent from './input-dropdown.html'
import loginContent from './login-example.html'

export default {
  title: 'UI/Forms',
  parameters: {
    docs: {
      description: {
        component: 'Forms are used to collect user input and submit data.'
      }
    }
  }
};

export const Normal = () => inputContent;
Normal.parameters = {
  docs: {
    source: {
      code: inputContent
    }
  }
};

export const Disabled = () => disabledContent;
Disabled.parameters = {
  docs: {
    source: {
      code: disabledContent
    }
  }
};

export const InputStates = () => statesContent;
InputStates.parameters = {
  docs: {
    source: {
      code: statesContent
    }
  }
};
InputStates.storyName = 'Input states';

export const InputGroup = () => groupContent;
InputGroup.parameters = {
  docs: {
    source: {
      code: groupContent
    }
  }
};
InputGroup.storyName = 'Input group';

export const InputWithDropdown = () => inputDropdownContent;
InputWithDropdown.parameters = {
  docs: {
    source: {
      code: inputDropdownContent
    }
  }
};
InputWithDropdown.storyName = 'Input with dropdown';

export const LoginExample = () => loginContent;
LoginExample.parameters = {
  docs: {
    source: {
      code: loginContent
    }
  }
};
LoginExample.storyName = 'Example of login form';

export const Helpers = () => helperContent;
Helpers.parameters = {
  docs: {
    source: {
      code: helperContent
    }
  }
};

export const Checkboxes = () => checkboxesContent;
Checkboxes.parameters = {
  docs: {
    source: {
      code: checkboxesContent
    }
  }
};

export const RadioButtons = () => radiosContent;
RadioButtons.parameters = {
  docs: {
    source: {
      code: radiosContent
    }
  }
};
RadioButtons.storyName = 'Radio buttons';

export const Switch = () => switchContent;
Switch.parameters = {
  docs: {
    source: {
      code: switchContent
    }
  }
};

export const Selects = () => selectContent;
Selects.parameters = {
  docs: {
    source: {
      code: selectContent
    }
  }
};
