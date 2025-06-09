import modalContent from './modal.html';

export default {
  title: 'UI/Modals',
  parameters: {
    docs: {
      description: {
        component: 'Modals are used to display content in a dialog box that overlays the main content.'
      }
    }
  }
};

export const Modal = () => modalContent;
Modal.parameters = {
  docs: {
    source: {
      code: modalContent
    }
  }
};

