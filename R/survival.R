#' Pipe-friendly wrappers for survival analysis functions
#'
#' These functions wrap [survival::survfit()], [survival::coxph()], and
#' [survival::survreg()] as proper S3 generics, adding `data.frame` methods so
#' that a data frame can be passed as the first argument via the base pipe
#' (`|>`).
#'
#' These functions require the `survival` package to be installed.
#'
#' @param x For `data.frame` methods: a data frame to use as the `data`
#'   argument. For `default` methods: passed straight through to the
#'   corresponding `survival::` function.
#' @param ... Additional arguments passed to the underlying function.
#'
#' @name pipe_survival
NULL


# survfit ------------------------------------------------------------------

#' @rdname pipe_survival
#'
#' @return For `survfit`: an object of class `"survfit"`, as returned by
#'   [survival::survfit()].
#'
#' @examples
#' if (requireNamespace("survival", quietly = TRUE)) {
#'   survival::lung |> survfit(survival::Surv(time, status) ~ sex)
#' }
#'
#' @export
survfit <- function(x, ...) UseMethod("survfit")

#' @rdname pipe_survival
#' @method survfit default
#' @export
survfit.default <- function(x, ...) {
  if (!requireNamespace("survival", quietly = TRUE))
    stop("Package 'survival' is required but not installed.")
  survival::survfit(x, ...)
}

#' @rdname pipe_survival
#' @param formula A formula with a [survival::Surv()] object on the left-hand
#'   side, passed to [survival::survfit()].
#' @method survfit data.frame
#' @export
survfit.data.frame <- function(x, formula, ...) {
  if (!requireNamespace("survival", quietly = TRUE))
    stop("Package 'survival' is required but not installed.")
  if (!inherits(formula, "formula"))
    stop("'formula' must be a formula object")
  survival::survfit(formula, data = x, ...)
}


# coxph --------------------------------------------------------------------

#' @rdname pipe_survival
#'
#' @return For `coxph`: an object of class `"coxph"`, as returned by
#'   [survival::coxph()].
#'
#' @examples
#' if (requireNamespace("survival", quietly = TRUE)) {
#'   survival::lung |> coxph(survival::Surv(time, status) ~ age + sex)
#' }
#'
#' @export
coxph <- function(x, ...) UseMethod("coxph")

#' @rdname pipe_survival
#' @method coxph default
#' @export
coxph.default <- function(x, ...) {
  if (!requireNamespace("survival", quietly = TRUE))
    stop("Package 'survival' is required but not installed.")
  survival::coxph(x, ...)
}

#' @rdname pipe_survival
#' @param formula A formula with a [survival::Surv()] object on the left-hand
#'   side, passed to [survival::coxph()].
#' @method coxph data.frame
#' @export
coxph.data.frame <- function(x, formula, ...) {
  if (!requireNamespace("survival", quietly = TRUE))
    stop("Package 'survival' is required but not installed.")
  if (!inherits(formula, "formula"))
    stop("'formula' must be a formula object")
  survival::coxph(formula, data = x, ...)
}


# survreg ------------------------------------------------------------------

#' @rdname pipe_survival
#'
#' @return For `survreg`: an object of class `"survreg"`, as returned by
#'   [survival::survreg()].
#'
#' @examples
#' if (requireNamespace("survival", quietly = TRUE)) {
#'   survival::lung |>
#'     survreg(survival::Surv(time, status) ~ age + sex, dist = "weibull")
#' }
#'
#' @export
survreg <- function(x, ...) UseMethod("survreg")

#' @rdname pipe_survival
#' @method survreg default
#' @export
survreg.default <- function(x, ...) {
  if (!requireNamespace("survival", quietly = TRUE))
    stop("Package 'survival' is required but not installed.")
  survival::survreg(x, ...)
}

#' @rdname pipe_survival
#' @param formula A formula with a [survival::Surv()] object on the left-hand
#'   side, passed to [survival::survreg()].
#' @method survreg data.frame
#' @export
survreg.data.frame <- function(x, formula, ...) {
  if (!requireNamespace("survival", quietly = TRUE))
    stop("Package 'survival' is required but not installed.")
  if (!inherits(formula, "formula"))
    stop("'formula' must be a formula object")
  survival::survreg(formula, data = x, ...)
}
