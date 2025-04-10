/* PrestaShop license placeholder */
$(document).ready(function() {
  productListingComments.init();
  productListingComments.load();
});

var productListingComments = (function () {

  var data = {
      productIDs: [],
      commentsLoadingInProgress: false,
      ajaxIDsLimit: 50,
      ajaxUrl: ''
  }

  var DOMStrings = {
      productListReviewsContainer: '.product-list-reviews',
      productListReviewsNumberOfComments: '.comments-nb',
      productListReviewsStarsContainer: '.grade-stars',
      productContainer: '.js-product-miniature'
  };

  var DOMClasses =  {
      inProgress: 'reviews-loading',
      reviewsLoaded: 'reviews-loaded',
      hasReviews: 'has-reviews',
      productListReviewShow: 'product-list-reviews--show',
  };

  function setEvents() {
      prestashop.on('updateProductList', function() {
          addProductsIDs();
      });
  }


  function setAjaxUrl() {
      if (data.ajaxUrl !== '')
          return;

      var url = $(DOMStrings.productListReviewsContainer).first().data('url');
      data.ajaxUrl = url;
  }

  function getNewProductsReviewsElements() {
      var $productListReviews = $(DOMStrings.productContainer)
          .not('.' + DOMClasses.reviewsLoaded + ', .' + DOMClasses.inProgress)
          .addClass(DOMClasses.inProgress)
          .find(DOMStrings.productListReviewsContainer);

      return $productListReviews;
  }

  function addProductsIDs() {

      var $productsList = getNewProductsReviewsElements(),
          seenIds = {};

      $productsList.each(function () {
          var id = $(this).data('id');
          seenIds[id] = true;
      });


      var IDsArray = Object.keys(seenIds).filter(e => e !== 'undefined');
      var prevDataIDs = data.productIDs.splice(0);
      data.productIDs = prevDataIDs.concat(IDsArray);

      if (!data.commentsLoadingInProgress) {
          loadProductsData();
      }
  }

  function loadProductsData() {
      if (data.productIDs.length === 0)
          return;

      data.commentsLoadingInProgress = true;

      var dataIDsCopy = data.productIDs.slice(0);
          selectedProductIDs = dataIDsCopy.splice(0, data.ajaxIDsLimit);


      $.get(data.ajaxUrl, { id_products: selectedProductIDs }, function (jsonData) {
          if (jsonData) {
              $.each(jsonData.products, function(i, elem) {
                  var productData = elem;
                  var $productsReviewsContainer = $('.product-list-reviews[data-id="' + productData.id_product + '"]');

                  $productsReviewsContainer.each(function () {
                      var $self = $(this);

                      if (productData.comments_nb > 0) {
                        $self.find(DOMStrings.productListReviewsStarsContainer).rating({ grade: productData.average_grade, starWidth: 16 });
                        $self.find(DOMStrings.productListReviewsNumberOfComments).text('(' + productData.comments_nb + ')');
                        $self.closest(DOMStrings.productContainer).addClass(DOMClasses.hasReviews);
                        $self.addClass(DOMClasses.productListReviewShow);
                      } else if (productData.comments_nb == 0) {
                        $self.hide();
                      }

                      $self.closest(DOMStrings.productContainer).addClass(DOMClasses.reviewsLoaded);
                      $self.closest(DOMStrings.productContainer).removeClass(DOMClasses.inProgress);

                  });
                  data.productIDs.shift();
              });

              data.commentsLoadingInProgress = false;
              if (data.productIDs.length > 0) {
                  loadProductsData();
              }

          }
      });
  }


  return {
      load: function () {
          addProductsIDs();
      },
      init: function () {
          setAjaxUrl();
          setEvents();
      }
  }
})();
