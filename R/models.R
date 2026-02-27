#' Pipe-friendly wrappers for lm, glm, and aov
#'
#' These functions wrap [stats::lm()], [stats::glm()], and [stats::aov()] as
#' proper S3 generics, adding `data.frame` methods so that a data frame can be
#' passed as the first argument via the base pipe (`|>`).
#'
#' Because `lm`, `glm`, and `aov` in the stats package are not internally S3
#' generics, they cannot be extended with new methods directly. This package
#' masks them with generic versions that dispatch on the class of the first
#' argument. The `.default` methods call the original `stats::` functions, so
#' all existing behaviour is preserved.
#'
#' @param x For `data.frame` methods: a data frame to use as the `data`
#'   argument. For `default` methods: passed straight through to the
#'   corresponding `stats::` function.
#' @param ... Additional arguments passed to the underlying stats function.
#'
#' @name pipe_models
NULL


# lm -----------------------------------------------------------------------

#' @rdname pipe_models
#'
#' @return For `lm`: an object of class `"lm"`, as returned by [stats::lm()].
#'
#' @examples
#' # Without pipedreams:
#' # mtcars |> lm(mpg ~ wt, data = _)
#'
#' # With pipedreams:
#' mtcars |> lm(mpg ~ wt)
#'
#' @export
lm <- function(x, ...) UseMethod("lm")

#' @rdname pipe_models
#' @method lm default
#' @export
lm.default <- function(x, ...) stats::lm(x, ...)

#' @rdname pipe_models
#' @param formula A formula, passed to [stats::lm()].
#' @method lm data.frame
#' @export
lm.data.frame <- function(x, formula, ...) {
  if (!inherits(formula, "formula"))
    stop("'formula' must be a formula object")
  stats::lm(formula, data = x, ...)
}


# glm ----------------------------------------------------------------------

#' @rdname pipe_models
#'
#' @return For `glm`: an object of class `c("glm", "lm")`, as returned by
#'   [stats::glm()].
#'
#' @examples
#' mtcars |> glm(am ~ mpg + wt, family = binomial)
#'
#' @export
glm <- function(x, ...) UseMethod("glm")

#' @rdname pipe_models
#' @method glm default
#' @export
glm.default <- function(x, ...) stats::glm(x, ...)

#' @rdname pipe_models
#' @param formula A formula, passed to [stats::glm()].
#' @method glm data.frame
#' @export
glm.data.frame <- function(x, formula, ...) {
  if (!inherits(formula, "formula"))
    stop("'formula' must be a formula object")
  stats::glm(formula, data = x, ...)
}


# aov ----------------------------------------------------------------------

#' @rdname pipe_models
#'
#' @return For `aov`: an object of class `c("aov", "lm")`, as returned by
#'   [stats::aov()].
#'
#' @examples
#' npk |> aov(yield ~ block + N * P * K)
#'
#' @export
aov <- function(x, ...) UseMethod("aov")

#' @rdname pipe_models
#' @method aov default
#' @export
aov.default <- function(x, ...) stats::aov(x, ...)

#' @rdname pipe_models
#' @param formula A formula, passed to [stats::aov()].
#' @method aov data.frame
#' @export
aov.data.frame <- function(x, formula, ...) {
  if (!inherits(formula, "formula"))
    stop("'formula' must be a formula object")
  stats::aov(formula, data = x, ...)
}
