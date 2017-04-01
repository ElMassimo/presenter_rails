## PresenterRails 2.0.0 (2017-04-01) ##

*   Now every call to `present` must pass a block, and defines a single method.
*   PresenterRails is auto-included in mailers as well.
*   Presenter methods are no longer assignable since the need does not come up in practice (`pakiderm` used to provide the feature).
*   Dropped `pakiderm` as a dependency since memoization is now simpler.
