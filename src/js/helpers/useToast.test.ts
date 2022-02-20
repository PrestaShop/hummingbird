import selectorsMap from '@constants/selectors-map';
import useToast from '@helpers/useToast';
import { 
  containerComponent, btnCloseComponent, testMessage, testOptions, defaultType, validTemplate, invalidTemplate 
} from '@constants/mocks/useToast-data';

describe('useToast', () => {
  const expectedOptions = {
    getType(hasType: boolean) {

      return hasType ? `.bg-${testOptions.type}` : `.bg-${defaultType}`;
    },
    getClassList() {
      const customClassList = testOptions.classlist;
      let expectedClassList = '';

      if (customClassList) {
        customClassList.trim().split(' ').forEach((value) => {
          
          if (value) {
            expectedClassList = expectedClassList.concat(' ', value);
          }
        });

        return expectedClassList.trim();
      }
    },
    getBtnClose() {
      if (testOptions.autohide !== undefined && testOptions.autohide === false) {

        return `.${btnCloseComponent}`;
      }
    }
  }

  describe('with valid template', () => {
    beforeEach(() => {
      const body = document.querySelector<HTMLBodyElement>('body');
      
      if (body) {
        body.innerHTML = validTemplate;
      }
    });

    it('should display the message', () => {
      useToast(testMessage).show();
      const toastElement = getToastElement(document);

      expect(getToastMessage(toastElement) === testMessage).toBe(true);
    });

    it('should add custom class list to the element if exists', () => {
      useToast(testMessage, testOptions).show();
      const toastElement = getToastElement(document, true);
      const expectedClassList = expectedOptions.getClassList();

      if (expectedClassList) {
        const pattern = new RegExp(expectedClassList);

        expect(toastElement?.classList.toString().match(pattern)?.length).toBe(1);
      }   
    });

    it('should display the close button if autohide is false', () => {
      useToast(testMessage, testOptions).show();
      const toastElement = getToastElement(document, true);
      const expectedBtnClose = expectedOptions.getBtnClose();

      if (expectedBtnClose) {
        const btnCloseElement = toastElement?.querySelector<HTMLButtonElement>(expectedBtnClose);

        expect(btnCloseElement?.classList.contains('d-none')).toBe(false);
      }
    });
  });

  describe('with invalid template', () => {
    beforeEach(() => {      
      const body = document.querySelector<HTMLBodyElement>('body');

      if (body) {
        body.innerHTML = '';
      }
    });

    it('should add fallback container if template is invalid', () => {
      const body = document.querySelector<HTMLBodyElement>('body');

      if (body) {
        body.innerHTML = invalidTemplate;
        useToast('').show();
        
        expect(isFallbackConnected(document)).toBe(true);
      }
    });

    it('should add fallback container if template is not exists', () => {
      useToast('').show();

      expect(isFallbackConnected(document)).toBe(true);
    });
  });

  const getToastElement = (document: Document, hasType = false) => {
    const toastContainer = document.querySelector<HTMLElement>(selectorsMap.toast.container);
    const toastElement = toastContainer?.querySelector<HTMLElement>(`${selectorsMap.toast.toast}${expectedOptions.getType(hasType)}`);

    return toastElement ?? null;
  }

  const getToastMessage = (toastElement: HTMLElement | null) => {
    const toastBody = toastElement?.querySelector<HTMLElement>(`${selectorsMap.toast.toast}-body`);
    
    return toastBody?.innerHTML ?? '';
  }

  const isFallbackConnected = (document: Document) => {
    const toastContainer = document.querySelector<HTMLElement>(selectorsMap.toast.container);

    return toastContainer?.classList.contains(`${containerComponent}--fallback`);
  }  
});
