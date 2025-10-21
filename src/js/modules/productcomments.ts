/**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */
import {Modal} from 'bootstrap';
import selectorsMap from '@constants/selectors-map';
import A11yHelpers from '@helpers/a11y';
import {events} from '@js/theme';

const a11y = new A11yHelpers();
const {prestashop} = window;

// Global variables from template (these should be set in the template)
declare global {
  interface Window {
    productCommentPostErrorMessage: string;
    productCommentMandatoryMessage: string;
    ratingChosen: boolean;
    productCommentUpdatePostErrorMessage: string;
    productCommentAbuseReportErrorMessage: string;
  }
}

// Comment data interfaces
interface CommentData {
  id_product_comment: number;
  id_product: number;
  customer_name?: string;
  firstname: string;
  lastname: string;
  date_add: string;
  title: string;
  content: string;
  usefulness: number;
  grade: number;
  total_usefulness: number;
}

interface CommentsResponse {
  comments: CommentData[];
}

interface UsefulnessResponse {
  success: boolean;
  usefulness?: number;
  total_usefulness?: number;
  error?: string;
}

interface ReportResponse {
  success: boolean;
  error?: string;
}

// Selectors following theme naming conventions
const SELECTORS = {
  POST_REVIEW_BUTTON: "[data-ps-ref='product-post-review-button']",
  MODAL_REVIEW: "[data-ps-ref='product-post-review-modal']",
  MODAL_REVIEW_FORM: "[data-ps-ref='product-post-review-form']",
  MODAL_REVIEW_ERROR: "[data-ps-ref='product-post-review-error-modal']",
  MODAL_REVIEW_POSTED: "[data-ps-ref='product-post-review-posted-modal']",
  CRITERIONS_LIST: "[data-ps-ref='criterions-list']",
  CRITERIONS_INPUT: "[data-ps-ref='criterions-list'] input",
  NO_RATING_INFO: "[data-ps-ref='no-rating-info']",
  FORM_VALIDATION_BUTTON: "[data-ps-action='form-validation-submit']",
  FORM_FIELD: "[data-ps-ref='product-post-review-form'] [name]",
  // Comments listing selectors
  COMMENTS_LIST: "[data-ps-ref='product-comments-list']",
  EMPTY_PRODUCT_COMMENT: "[data-ps-ref='empty-product-comment']",
  // Product list reviews selectors
  PRODUCT_LIST_REVIEW: "[data-ps-ref='product-list-review']",
  PRODUCT_LIST_GRADE_NUMBER: "[data-ps-ref='product-list-comments-number'] [data-ps-ref='grade-value']",
  PRODUCT_LIST_COMMENTS_NUMBER: "[data-ps-ref='product-list-comments-number'] [data-ps-ref='number-value']",
  // Pagination selectors
  PAGINATION: "[data-ps-ref='product-comments-pagination']",
  PAGINATION_ITEM: "[data-ps-ref='pagination-item']",
  PAGINATION_PREV: "[data-ps-ref='pagination-item'][data-ps-action='prev']",
  PAGINATION_NEXT: "[data-ps-ref='pagination-item'][data-ps-action='next']",
  PAGINATION_PAGE: "[data-ps-ref='pagination-item'][data-ps-action='page']",
  // Grade stars selectors
  GRADE_STARS: "[data-ps-ref='grade-stars']",
  // Comments note selectors
  COMMENTS_NOTE: "[data-ps-ref='comments-note']",
  COMMENTS_NUMBER: "[data-ps-ref='comments-number']",
  AVERAGE_GRADE: "[data-ps-ref='average-grade']",
  // Comment interaction selectors
  USEFUL_REVIEW: "[data-ps-ref='useful-review']",
  NOT_USEFUL_REVIEW: "[data-ps-ref='not-useful-review']",
  REPORT_ABUSE: "[data-ps-ref='report-abuse']",
  USEFUL_REVIEW_VALUE: "[data-ps-ref='useful-review-value']",
  NOT_USEFUL_REVIEW_VALUE: "[data-ps-ref='not-useful-review-value']",
  CONFIRM_BUTTON: "[data-ps-ref='confirm-button']",
  REFUSE_BUTTON: "[data-ps-ref='refuse-button']",
  // Error modals
  UPDATE_COMMENT_USEFULNESS_POST_ERROR: "[data-ps-ref='update-comment-usefulness-post-error']",
  REPORT_COMMENT_CONFIRMATION: "[data-ps-ref='report-comment-confirmation']",
  REPORT_COMMENT_POST_ERROR: "[data-ps-ref='report-comment-post-error']",
  REPORT_COMMENT_POST_SUCCESS: "[data-ps-ref='report-comment-post-success']",
} as const;

// DOM queries utility class following theme patterns
class ProductCommentsQueries {
  static getPostReviewButtons(): NodeListOf<Element> {
    return document.querySelectorAll(SELECTORS.POST_REVIEW_BUTTON);
  }

  static getModalReview(): HTMLElement | null {
    return document.querySelector(SELECTORS.MODAL_REVIEW);
  }

  static getModalReviewForm(): HTMLFormElement | null {
    return document.querySelector(SELECTORS.MODAL_REVIEW_FORM);
  }

  static getModalReviewError(): HTMLElement | null {
    return document.querySelector(SELECTORS.MODAL_REVIEW_ERROR);
  }

  static getModalReviewPosted(): HTMLElement | null {
    return document.querySelector(SELECTORS.MODAL_REVIEW_POSTED);
  }

  static getCriterionsList(): HTMLElement | null {
    return document.querySelector(SELECTORS.CRITERIONS_LIST);
  }

  static getRatings(): NodeListOf<HTMLInputElement> {
    return document.querySelectorAll(SELECTORS.CRITERIONS_INPUT);
  }

  static getNoRatingInfo(): HTMLElement | null {
    return document.querySelector(SELECTORS.NO_RATING_INFO);
  }

  static getFormValidationButton(form: HTMLFormElement): HTMLElement | null {
    return form.querySelector(SELECTORS.FORM_VALIDATION_BUTTON);
  }

  static getFormField(fieldName: string): HTMLElement | null {
    return document.querySelector(`${SELECTORS.FORM_FIELD}="${fieldName}"]`) as HTMLElement;
  }

  // Comments listing queries
  static getCommentsList(): HTMLElement | null {
    return document.querySelector(SELECTORS.COMMENTS_LIST);
  }

  static getEmptyProductComment(): HTMLElement | null {
    return document.querySelector(SELECTORS.EMPTY_PRODUCT_COMMENT);
  }

  static getPagination(): HTMLElement | null {
    return document.querySelector(SELECTORS.PAGINATION);
  }

  static getPaginationItems(): NodeListOf<Element> {
    return document.querySelectorAll(SELECTORS.PAGINATION_ITEM);
  }

  static getPaginationPrev(): HTMLElement | null {
    return document.querySelector(SELECTORS.PAGINATION_PREV);
  }

  static getPaginationNext(): HTMLElement | null {
    return document.querySelector(SELECTORS.PAGINATION_NEXT);
  }

  static getPaginationPages(): NodeListOf<Element> {
    return document.querySelectorAll(SELECTORS.PAGINATION_PAGE);
  }

  static getPaginationPage(pageNumber: number): HTMLElement | null {
    return document.querySelector(`${SELECTORS.PAGINATION_ITEM}[data-ps-data="${pageNumber}"]`);
  }

  // Comment-specific queries
  static getCommentById(commentId: number): HTMLElement | null {
    return document.querySelector(`[data-product-comment-id="${commentId}"]`);
  }

  static getGradeStars(): NodeListOf<Element> {
    return document.querySelectorAll(SELECTORS.GRADE_STARS);
  }

  static getCommentsNote(): HTMLElement | null {
    return document.querySelector(SELECTORS.COMMENTS_NOTE);
  }

  static getCommentsNumber(): HTMLElement | null {
    return document.querySelector(SELECTORS.COMMENTS_NUMBER);
  }

  static getAverageGrade(): HTMLElement | null {
    return document.querySelector(SELECTORS.AVERAGE_GRADE);
  }

  // Product list reviews queries
  static getProductListReviews(): NodeListOf<Element> {
    return document.querySelectorAll(SELECTORS.PRODUCT_LIST_REVIEW);
  }

  static getProductListGradeNumber(element: HTMLElement): HTMLElement | null {
    return element.querySelector(SELECTORS.PRODUCT_LIST_GRADE_NUMBER);
  }

  static getProductListCommentsNumber(element: HTMLElement): HTMLElement | null {
    return element.querySelector(SELECTORS.PRODUCT_LIST_COMMENTS_NUMBER);
  }

  // Comment interaction queries
  static getUsefulReviewButtons(commentElement: HTMLElement): NodeListOf<Element> {
    return commentElement.querySelectorAll(SELECTORS.USEFUL_REVIEW);
  }

  static getNotUsefulReviewButtons(commentElement: HTMLElement): NodeListOf<Element> {
    return commentElement.querySelectorAll(SELECTORS.NOT_USEFUL_REVIEW);
  }

  static getReportAbuseButtons(commentElement: HTMLElement): NodeListOf<Element> {
    return commentElement.querySelectorAll(SELECTORS.REPORT_ABUSE);
  }

  static getUsefulReviewValue(commentElement: HTMLElement): HTMLElement | null {
    return commentElement.querySelector(SELECTORS.USEFUL_REVIEW_VALUE);
  }

  static getNotUsefulReviewValue(commentElement: HTMLElement): HTMLElement | null {
    return commentElement.querySelector(SELECTORS.NOT_USEFUL_REVIEW_VALUE);
  }

  // Error modal queries
  static getUpdateCommentUsefulnessPostErrorModal(): HTMLElement | null {
    return document.querySelector(SELECTORS.UPDATE_COMMENT_USEFULNESS_POST_ERROR);
  }

  static getReportCommentConfirmationModal(): HTMLElement | null {
    return document.querySelector(SELECTORS.REPORT_COMMENT_CONFIRMATION);
  }

  static getReportCommentPostErrorModal(): HTMLElement | null {
    return document.querySelector(SELECTORS.REPORT_COMMENT_POST_ERROR);
  }

  static getReportCommentPostSuccessModal(): HTMLElement | null {
    return document.querySelector(SELECTORS.REPORT_COMMENT_POST_SUCCESS);
  }
}

// Form validation utility class
class ProductCommentsForm {
  static validateRatingChosen(): boolean {
    const {ratingChosen} = window;
    const noRatingInfo = ProductCommentsQueries.getNoRatingInfo();

    if (noRatingInfo) {
      if (ratingChosen) {
        noRatingInfo.classList.add('d-none');
        return true;
      }
      noRatingInfo.classList.remove('d-none');
      return false;
    }

    return ratingChosen;
  }

  static validateForm(form: HTMLFormElement): boolean {
    return form.checkValidity();
  }

  static clearReviewForm(): void {
    const form = ProductCommentsQueries.getModalReviewForm();

    if (form) {
      form.reset();
      form.classList.remove('was-validated');
    }
  }

  static async submitReviewForm(form: HTMLFormElement, event: Event): Promise<void> {
    event.preventDefault();

    const formData = new FormData(form);

    if (!this.validateForm(form) || !this.validateRatingChosen()) return;

    try {
      const response = await fetch(form.action, {
        method: 'POST',
        body: formData,
      });

      const jsonData = await response.json();

      if (jsonData) {
        if (jsonData.success) {
          this.clearReviewForm();
          ProductCommentsModals.showReviewPostedModal();
        } else {
          this.handleSubmissionError(jsonData);
        }
      } else {
        ProductCommentsModals.showReviewErrorModal(window.productCommentPostErrorMessage);
      }
    } catch {
      ProductCommentsModals.showReviewErrorModal(window.productCommentPostErrorMessage);
    }
  }

  private static handleSubmissionError(jsonData: { errors?: string[]; error?: string }): void {
    if (jsonData.errors && Array.isArray(jsonData.errors)) {
      const errorList = `<ul>${jsonData.errors.map((error: string) => `<li>${error}</li>`).join('')}</ul>`;
      ProductCommentsModals.showReviewErrorModal(errorList);
    } else {
      const errorMessage = jsonData.error || window.productCommentPostErrorMessage;
      ProductCommentsModals.showReviewErrorModal(errorMessage);
    }
  }
}

// Modal management utility class
class ProductCommentsModals {
  static showReviewPostedModal(): void {
    this.closeReviewRelatedModals();

    const modal = ProductCommentsQueries.getModalReviewPosted();

    if (modal) {
      const modalInstance = Modal.getOrCreateInstance(modal);

      modalInstance.show();
    }
  }

  static showReviewErrorModal(errorMessage: string): void {
    this.closeReviewRelatedModals();

    const modal = ProductCommentsQueries.getModalReviewError();

    if (modal) {
      const errorContent = modal.querySelector('.modal-body');
      const modalInstance = Modal.getOrCreateInstance(modal);

      if (errorContent) {
        errorContent.innerHTML = errorMessage;
      }

      modalInstance.show();
    }
  }

  static closeReviewRelatedModals(): void {
    const modals = [
      ProductCommentsQueries.getModalReview(),
      ProductCommentsQueries.getModalReviewPosted(),
      ProductCommentsQueries.getModalReviewError(),
    ];

    modals.forEach((modal) => {
      if (modal) {
        const modalInstance = Modal.getInstance(modal);

        if (modalInstance) {
          modalInstance.hide();
        }
      }
    });
  }
}

// Comments listing utility class
class ProductCommentsListing {
  private static currentPage: number = 1;

  private static totalPages: number = 0;

  private static commentsListUrl: string | null = null;

  private static commentPrototype: string | null = null;

  static init(): void {
    const commentsList = ProductCommentsQueries.getCommentsList();

    if (!commentsList) return;

    this.currentPage = parseInt(commentsList.dataset.currentPage || '1', 10);
    this.totalPages = parseInt(commentsList.dataset.totalPages || '0', 10);
    this.commentsListUrl = commentsList.dataset.listCommentsUrl || '';
    this.commentPrototype = commentsList.dataset.commentItemPrototype || '';

    this.initCommentsListingRatingSystem();
    this.initPagination();
  }

  private static initCommentsListingRatingSystem(): void {
    ProductCommentsRating.initRatingSystem();

    // Listen for rating updates from the CORE
    document.addEventListener('updateRating', () => {
      ProductCommentsRating.initRatingSystem();
    });
  }

  private static initPagination(): void {
    const pagination = ProductCommentsQueries.getPagination();

    if (!pagination || this.totalPages <= 1) {
      this.loadInitialComments();
      return;
    }

    this.initPaginationListeners();
    this.initOnePagePagination();
  }

  private static initPaginationListeners(): void {
    const paginationItems = ProductCommentsQueries.getPaginationItems();

    paginationItems.forEach((item) => {
      item.addEventListener('click', (event) => {
        event.preventDefault();

        if (item.classList.contains('disabled')) {
          return;
        }

        const action = item.getAttribute('data-ps-action');
        const pageNumber = item.getAttribute('data-ps-data');

        this.handlePageClick(action, pageNumber);
      });
    });
  }

  private static handlePageClick(action: string | null, pageNumber: string | null): void {
    let newPage = this.currentPage;

    if (action === 'prev') {
      newPage = this.currentPage - 1;
    } else if (action === 'next') {
      newPage = this.currentPage + 1;
    } else if (action === 'page' && pageNumber) {
      newPage = parseInt(pageNumber, 10);
    }

    // Validate page number
    if (newPage < 1 || newPage > this.totalPages || newPage === this.currentPage) {
      return;
    }

    this.currentPage = newPage;
    this.fetchComments(newPage);
    this.updatePaginationUI();
  }

  private static updatePaginationUI(): void {
    // Update all page items
    for (let i = 1; i <= this.totalPages; i += 1) {
      const pageItem = ProductCommentsQueries.getPaginationPage(i);

      if (pageItem) {
        const isActive = i === this.currentPage;
        pageItem.classList.toggle('active', isActive);

        const button = pageItem.querySelector('button');

        if (button) {
          if (isActive) {
            button.setAttribute('aria-current', 'page');
          } else {
            button.removeAttribute('aria-current');
          }
        }
      }
    }

    // Update prev button
    const prevItem = ProductCommentsQueries.getPaginationPrev();

    if (prevItem) {
      const prevButton = prevItem.querySelector('button');

      if (prevButton) {
        const isDisabled = this.currentPage === 1;
        prevItem.classList.toggle('disabled', isDisabled);
        prevButton.disabled = isDisabled;
      }
    }

    // Update next button
    const nextItem = ProductCommentsQueries.getPaginationNext();

    if (nextItem) {
      const nextButton = nextItem.querySelector('button');

      if (nextButton) {
        const isDisabled = this.currentPage === this.totalPages;
        nextItem.classList.toggle('disabled', isDisabled);
        nextButton.disabled = isDisabled;
      }
    }
  }

  private static async fetchComments(page: number): Promise<void> {
    try {
      const response = await fetch(`${this.commentsListUrl}&page=${page}`);

      if (response.status === 200) {
        const data = await response.text();
        const commentsData: CommentsResponse = JSON.parse(data);
        this.populateComments(commentsData.comments);
      }
    } catch (error) {
      console.error('Error fetching comments:', error);
    }
  }

  private static populateComments(comments: CommentData[]): void {
    const commentsList = ProductCommentsQueries.getCommentsList();

    if (!commentsList) return;

    commentsList.innerHTML = '';
    comments.forEach((comment) => {
      this.addComment(comment);
    });
  }

  private static addComment(comment: CommentData): void {
    const commentsList = ProductCommentsQueries.getCommentsList();

    if (!commentsList) return;

    let commentTemplate = this.commentPrototype;

    if (!commentTemplate) return;

    const customerName = comment.customer_name || `${comment.firstname} ${comment.lastname}`;

    // Replace template placeholders
    commentTemplate = commentTemplate.replace(/@COMMENT_ID@/g, comment.id_product_comment.toString());
    commentTemplate = commentTemplate.replace(/@PRODUCT_ID@/g, comment.id_product.toString());
    commentTemplate = commentTemplate.replace(/@CUSTOMER_NAME@/g, customerName);
    commentTemplate = commentTemplate.replace(/@COMMENT_DATE@/g, comment.date_add);
    commentTemplate = commentTemplate.replace(/@COMMENT_TITLE@/g, comment.title);
    commentTemplate = commentTemplate.replace(/@COMMENT_COMMENT@/g, comment.content);
    commentTemplate = commentTemplate.replace(/@COMMENT_USEFUL_ADVICES@/g, comment.usefulness.toString());
    commentTemplate = commentTemplate.replace(/@COMMENT_GRADE@/g, comment.grade.toString());
    commentTemplate = commentTemplate.replace(
      /@COMMENT_NOT_USEFUL_ADVICES@/g,
      (comment.total_usefulness - comment.usefulness).toString(),
    );
    commentTemplate = commentTemplate.replace(/@COMMENT_TOTAL_ADVICES@/g, comment.total_usefulness.toString());

    const commentElement = document.createElement('div');
    commentElement.innerHTML = commentTemplate;
    const commentDiv = commentElement.firstElementChild as HTMLElement;

    if (commentDiv) {
      commentsList.appendChild(commentDiv);
      this.initCommentInteractions(commentDiv, comment);
    }
  }

  private static initCommentInteractions(commentElement: HTMLElement, comment: CommentData): void {
    // Initialize comment rating
    ProductCommentsRating.initCommentRating(commentElement, comment.grade);

    const usefulButtons = ProductCommentsQueries.getUsefulReviewButtons(commentElement);
    const notUsefulButtons = ProductCommentsQueries.getNotUsefulReviewButtons(commentElement);
    const reportButtons = ProductCommentsQueries.getReportAbuseButtons(commentElement);

    usefulButtons.forEach((button) => {
      button.addEventListener('click', () => {
        ProductCommentsInteractions.updateCommentUsefulness(commentElement, comment.id_product_comment, 1);
        a11y.storeFocus();
      });
    });

    notUsefulButtons.forEach((button) => {
      button.addEventListener('click', () => {
        ProductCommentsInteractions.updateCommentUsefulness(commentElement, comment.id_product_comment, 0);
        a11y.storeFocus();
      });
    });

    reportButtons.forEach((button) => {
      button.addEventListener('click', () => {
        ProductCommentsInteractions.confirmCommentAbuse(comment.id_product_comment);
        a11y.storeFocus();
      });
    });
  }

  private static initOnePagePagination(): void {
    if (this.totalPages > 0) {
      this.currentPage = 1;
      this.updatePaginationUI();
      this.fetchComments(1);
    }
  }

  private static async loadInitialComments(): Promise<void> {
    if (!this.commentsListUrl) return;

    try {
      const response = await fetch(`${this.commentsListUrl}&page=1`);

      if (response.status === 200) {
        const data = await response.text();
        const commentsData: CommentsResponse = JSON.parse(data);
        this.populateComments(commentsData.comments);
      }
    } catch (error) {
      console.error('Error loading initial comments:', error);
    }
  }
}

// Rating system utility class
class ProductCommentsRating {
  // eslint-disable-next-line @typescript-eslint/no-explicit-any
  static getJQueryRating(element: Element): any {
    // eslint-disable-next-line @typescript-eslint/no-explicit-any
    return (window as any).jQuery(element);
  }

  static initRatingSystem(): void {
    const gradeStars = ProductCommentsQueries.getGradeStars();
    gradeStars.forEach((star) => {
      if (this.isRatingPluginAvailable()) {
        this.getJQueryRating(star).rating();
      }
    });
  }

  static resetModalStars(): void {
    const modal = ProductCommentsQueries.getModalReview();

    if (modal) {
      const starsInModal = modal.querySelectorAll(SELECTORS.GRADE_STARS);
      starsInModal.forEach((star) => {
        if (this.isRatingPluginAvailable()) {
          this.getJQueryRating(star).rating('destroy');
          this.getJQueryRating(star).rating();
        }
      });
    }
  }

  static initCommentRating(commentElement: HTMLElement, grade: number): void {
    const gradeStars = commentElement.querySelectorAll(SELECTORS.GRADE_STARS);
    gradeStars.forEach((star) => {
      if (this.isRatingPluginAvailable()) {
        this.getJQueryRating(star).rating({grade});
      }
    });
  }

  static isRatingPluginAvailable(): boolean {
    // eslint-disable-next-line @typescript-eslint/no-explicit-any
    return !!(window as any).jQuery && typeof (window as any).jQuery.fn.rating === 'function';
  }
}

// Comment interactions utility class
class ProductCommentsInteractions {
  static async updateCommentUsefulness(
    commentElement: HTMLElement, commentId: number, usefulness: number,
  ): Promise<void> {
    const commentsList = ProductCommentsQueries.getCommentsList();

    if (!commentsList) return;

    const updateUrl = commentsList.dataset.updateCommentUsefulnessUrl;

    if (!updateUrl) return;

    try {
      const response = await fetch(updateUrl, {
        method: 'POST',
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: `id_product_comment=${commentId}&usefulness=${usefulness}`,
      });

      if (response.status === 200) {
        const jsonData: UsefulnessResponse = await response.json();

        if (jsonData.success && jsonData.usefulness !== undefined && jsonData.total_usefulness !== undefined) {
          this.updateUsefulnessValues(commentElement, jsonData.usefulness, jsonData.total_usefulness);
        } else {
          this.showUpdatePostCommentErrorModal(jsonData.error || 'Unknown error');
        }
      } else {
        this.showUpdatePostCommentErrorModal(window.productCommentUpdatePostErrorMessage);
      }
    } catch (error) {
      this.showUpdatePostCommentErrorModal(error instanceof Error ? error.message : 'Network error');
    }
  }

  private static updateUsefulnessValues(
    commentElement: HTMLElement,
    usefulness: number,
    totalUsefulness: number,
  ): void {
    const usefulValue = ProductCommentsQueries.getUsefulReviewValue(commentElement);
    const notUsefulValue = ProductCommentsQueries.getNotUsefulReviewValue(commentElement);

    if (usefulValue) {
      usefulValue.textContent = usefulness.toString();
    }
    if (notUsefulValue) {
      notUsefulValue.textContent = (totalUsefulness - usefulness).toString();
    }
  }

  static confirmCommentAbuse(commentId: number): void {
    const confirmModal = ProductCommentsQueries.getReportCommentConfirmationModal();

    if (!confirmModal) return;

    const modalInstance = Modal.getOrCreateInstance(confirmModal);

    modalInstance.show();

    // Listen for confirmation (one-time listener)
    const handleConfirm = (event: CustomEvent) => {
      if (event.detail?.confirm) {
        this.confirmCommentAbuseFetch(commentId);
      }
    };

    confirmModal.addEventListener('modal:confirm', handleConfirm, {once: true});
  }

  private static async confirmCommentAbuseFetch(commentId: number): Promise<void> {
    const commentsList = ProductCommentsQueries.getCommentsList();

    if (!commentsList) return;

    const reportUrl = commentsList.dataset.reportCommentUrl;

    if (!reportUrl) return;

    try {
      const response = await fetch(reportUrl, {
        method: 'POST',
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: `id_product_comment=${commentId}`,
      });

      if (response.status === 200) {
        const jsonData: ReportResponse = await response.json();

        if (jsonData.success) {
          this.showReportCommentPostedModal();
        } else {
          this.showReportCommentErrorModal(jsonData.error || 'Unknown error');
        }
      } else {
        this.showReportCommentErrorModal(window.productCommentAbuseReportErrorMessage);
      }
    } catch (error) {
      this.showReportCommentErrorModal(error instanceof Error ? error.message : 'Network error');
    }
  }

  private static showUpdatePostCommentErrorModal(errorMessage: string): void {
    const modal = ProductCommentsQueries.getUpdateCommentUsefulnessPostErrorModal();

    if (!modal) return;

    const messageElement = modal.querySelector('.modal-body');

    if (messageElement) {
      messageElement.innerHTML = errorMessage;
    }

    const modalInstance = Modal.getOrCreateInstance(modal);
    modalInstance.show();
  }

  private static showReportCommentErrorModal(errorMessage: string): void {
    const modal = ProductCommentsQueries.getReportCommentPostErrorModal();

    if (!modal) return;

    const messageElement = modal.querySelector('#report-comment-post-error-message');

    if (messageElement) {
      messageElement.innerHTML = errorMessage;
    }

    const modalInstance = Modal.getOrCreateInstance(modal);
    modalInstance.show();
  }

  private static showReportCommentPostedModal(): void {
    const modal = ProductCommentsQueries.getReportCommentPostSuccessModal();

    if (!modal) return;

    const modalInstance = Modal.getOrCreateInstance(modal);
    modalInstance.show();
  }
}

// Product List Reviews Handler
class ProductListReviews {
  static init(): void {
    this.loadProductListReviews();
    this.setupUpdateListener();
  }

  private static setupUpdateListener(): void {
    prestashop.on(events.updateProductList, () => {
      this.loadProductListReviews();
    });

    prestashop.on(events.updatedProduct, () => {
      this.loadProductListReviews();
    });
  }

  private static async loadProductListReviews(): Promise<void> {
    const productListReviews = ProductCommentsQueries.getProductListReviews();

    if (!productListReviews) return;

    const productIds: Array<number> = [];
    productListReviews.forEach((review) => {
      const productId = parseInt(review.getAttribute('data-id') || '0', 10);

      if (productId > 0) {
        productIds.push(productId);
      }
    });

    if (productIds.length === 0) return;

    try {
      const productListReview = document.querySelector(SELECTORS.PRODUCT_LIST_REVIEW);
      const url = productListReview?.getAttribute('data-url');

      if (!url) return;

      const response = await fetch(`${url}?id_products[]=${productIds.join('&id_products[]=')}`);

      if (response.status === 200) {
        const data = await response.json();
        this.updateProductListReviews(data);
      }
    } catch (error) {
      console.error('Error loading product list reviews:', error);
    }
  }

  private static updateProductListReviews(
    data: { products: Array<{ id_product: number; comments_nb: string; average_grade: number | null }> },
  ): void {
    const productListReviews = ProductCommentsQueries.getProductListReviews();

    productListReviews.forEach((review) => {
      const productId = parseInt(review.getAttribute('data-id') || '0', 10);
      const productData = data.products.find((p) => p.id_product === productId);

      if (productData && productData.comments_nb !== '0' && productData.average_grade !== null) {
        this.updateSingleProductReview(review as HTMLElement, {
          grade: Math.round(productData.average_grade),
          comments_nb: parseInt(productData.comments_nb, 10),
        });
        review.classList.add('d-flex');
      }
    });
  }

  private static updateSingleProductReview(
    reviewElement: HTMLElement, data: { grade: number; comments_nb: number },
  ): void {
    const starsContainer = reviewElement.querySelector(SELECTORS.GRADE_STARS);

    if (starsContainer) {
      this.updateStarsWithRating(starsContainer, data.grade);
    }

    const productListCommentsNumber = ProductCommentsQueries.getProductListCommentsNumber(reviewElement);
    const productListGradeNUmber = ProductCommentsQueries.getProductListGradeNumber(reviewElement);

    if (productListCommentsNumber && productListGradeNUmber) {
      productListCommentsNumber.textContent = data.comments_nb.toString();
      productListGradeNUmber.textContent = data.grade.toString();
    }
  }

  private static updateStarsWithRating(container: Element, grade: number): void {
    if (this.isRatingPluginAvailable()) {
      ProductCommentsRating.getJQueryRating(container).rating('destroy');
      ProductCommentsRating.getJQueryRating(container).rating({
        grade,
        readOnly: true,
      });
    }
  }

  private static isRatingPluginAvailable(): boolean {
    // eslint-disable-next-line @typescript-eslint/no-explicit-any
    return !!(window as any).jQuery && typeof (window as any).jQuery.fn.rating === 'function';
  }
}

// Main Product Comments
class ProductComments {
  static init(): void {
    this.initPostReviewButton();
    this.initReviewModal();
    this.initReviewPostedModal();
    this.initReviewErrorModal();
    this.initCommentsListing();
    this.initProductListReviews();
    this.initConfirmationModals();
    this.initCommentsModalHandler();
  }

  private static initReviewModal(): void {
    const modal = ProductCommentsQueries.getModalReview();
    const form = ProductCommentsQueries.getModalReviewForm();
    const formValidationButton = form ? ProductCommentsQueries.getFormValidationButton(form) : null;

    if (modal && form && formValidationButton) {
      formValidationButton.addEventListener('click', () => {
        ProductCommentsForm.validateRatingChosen();
      });

      form.addEventListener('submit', (event) => {
        ProductCommentsForm.submitReviewForm(form, event);
      });
    }
  }

  private static initReviewPostedModal(): void {
    const modal = ProductCommentsQueries.getModalReviewPosted();

    if (modal) {
      modal.addEventListener('hidden.bs.modal', () => {
        const focusElement = document.querySelector(selectorsMap.product.rightSection) as HTMLElement;
        a11y.restoreFocus(focusElement);
        ProductCommentsForm.clearReviewForm();
        ProductCommentsRating.resetModalStars();
      });
    }
  }

  private static initReviewErrorModal(): void {
    const modal = ProductCommentsQueries.getModalReviewError();

    if (modal) {
      modal.addEventListener('hidden.bs.modal', () => {
        const focusElement = document.querySelector(selectorsMap.product.rightSection) as HTMLElement;
        a11y.restoreFocus(focusElement);
      });
    }
  }

  private static initCommentsListing(): void {
    ProductCommentsListing.init();
  }

  private static initProductListReviews(): void {
    ProductListReviews.init();
  }

  private static initConfirmationModals(): void {
    this.initReportCommentConfirmationModal();
  }

  private static initReportCommentConfirmationModal(): void {
    const confirmModal = ProductCommentsQueries.getReportCommentConfirmationModal();

    if (!confirmModal) {
      return;
    }

    confirmModal.addEventListener('hidden.bs.modal', () => {
      const customEvent = new CustomEvent('modal:confirm', {
        detail: {confirm: false},
        bubbles: true,
      });
      confirmModal.dispatchEvent(customEvent);
    });

    const confirmButton = confirmModal.querySelector(SELECTORS.CONFIRM_BUTTON);

    if (confirmButton) {
      confirmButton.addEventListener('click', () => {
        const customEvent = new CustomEvent('modal:confirm', {
          detail: {confirm: true},
          bubbles: true,
        });
        confirmModal.dispatchEvent(customEvent);
      });
    }

    const refuseButton = confirmModal.querySelector(SELECTORS.REFUSE_BUTTON);

    if (refuseButton) {
      refuseButton.addEventListener('click', () => {
        const customEvent = new CustomEvent('modal:confirm', {
          detail: {confirm: false},
          bubbles: true,
        });
        confirmModal.dispatchEvent(customEvent);
      });
    }
  }

  private static initPostReviewButton(): void {
    const buttons = ProductCommentsQueries.getPostReviewButtons();

    if (buttons) {
      buttons.forEach((button) => {
        button.addEventListener('click', () => {
          a11y.storeFocus();
        });
      });
    }
  }

  static initCommentsModalHandler(): void {
    const updateCommentUsefulnessPostErrorModal = ProductCommentsQueries.getUpdateCommentUsefulnessPostErrorModal();
    const reportCommentConfirmationModal = ProductCommentsQueries.getReportCommentConfirmationModal();
    const reportCommentPostErrorModal = ProductCommentsQueries.getReportCommentPostErrorModal();
    const reportCommentPostSuccessModal = ProductCommentsQueries.getReportCommentPostSuccessModal();

    if (updateCommentUsefulnessPostErrorModal) {
      updateCommentUsefulnessPostErrorModal.addEventListener('hidden.bs.modal', () => {
        a11y.restoreFocus();
      });
    }

    if (reportCommentConfirmationModal) {
      reportCommentConfirmationModal.addEventListener('hidden.bs.modal', () => {
        const storedFocus = a11y.getStoredFocus();

        setTimeout(() => {
          if (storedFocus
            && !reportCommentPostErrorModal?.classList.contains('show')
            && !reportCommentPostSuccessModal?.classList.contains('show')) {
            a11y.setFocus(storedFocus);
          }
        }, 250);
      });
    }

    if (reportCommentPostErrorModal) {
      reportCommentPostErrorModal.addEventListener('hidden.bs.modal', () => {
        a11y.restoreFocus();
      });
    }

    if (reportCommentPostSuccessModal) {
      reportCommentPostSuccessModal.addEventListener('hidden.bs.modal', () => {
        a11y.restoreFocus();
      });
    }
  }
}

// Initialize product comments functionality
const initProductComments = (): void => {
  ProductComments.init();
};

export default initProductComments;
