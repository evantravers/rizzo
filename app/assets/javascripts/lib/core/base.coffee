define [
  'jquery',
  'lib/page/swipe',
  'lib/core/authenticator',
  'lib/core/shopping_cart',
  'lib/core/ad_manager',
  'lib/core/cookie_compliance',
  'lib/components/select_group_manager',
  "lib/core/feature_detect"
], ($, Swipe, Authenticator, ShoppingCart, AdManager, CookieCompliance, SelectGroupManager) ->

  class Base

    constructor: (args={})->
      @showUserBasket()
      @initAds() unless args.secure
      @showCookieMessage()
      @initialiseSelectGroupManager()
      @addNavTracking()
      @initSwipe()

    initAds: ->
      if (window.lp && window.lp.ads)
        @adManager = new AdManager(window.lp.ads)

    showUserBasket: ->
      shopCart = new ShoppingCart()

    initialiseSelectGroupManager: ->
      new SelectGroupManager()

    showCookieMessage: ->
      new CookieCompliance()

    addNavTracking: ->
      $('#js-primary-nav').on 'click', '.js-nav-item', ->
        window.s.linkstacker($(@).text())

      $('#js-primary-nav').on 'click', '.js-nav-cart', ->
        window.s.linkstacker("shopping-cart")

      $('#js-primary-nav').on 'submit', '.js-nav-search', ->
        window.s.linkstacker("search")

      $('#js-secondary-nav').on 'click', '.js-nav-item', ->
        window.s.linkstacker($(@).text() + "-sub")

      $('#js-breadcrumbs').on 'click', '.js-nav-item', ->
        window.s.linkstacker("breadcrumbs")

      $('#js-footer-nav').on 'click', '.js-nav-item', ->
        window.s.linkstacker("footer")

    initSwipe: ->
      new Swipe()
