#' Pipe-friendly wrappers for mixed-effects models
#'
#' These functions wrap [lme4::lmer()] and [lme4::glmer()] as proper S3
#' generics, adding `data.frame` methods so that a data frame can be passed as
#' the first argument via the base pipe (`|>`).
#'
#' These functions require the `lme4` package to be installed.
#'
#' @param x For `data.frame` methods: a data frame to use as the `data`
#'   argument. For `default` methods: passed straight through to the
#'   corresponding `lme4::` function.
#' @param ... Additional arguments passed to the underlying function.
#'
#' @name pipe_lme4
NULL


# lmer ---------------------------------------------------------------------

#' @rdname pipe_lme4
#'
#' @return For `lmer`: an object of class `"lmerMod"`, as returned by
#'   [lme4::lmer()].
#'
#' @examples
#' if (requireNamespace("lme4", quietly = TRUE)) {
#'   lme4::sleepstudy |> lmer(Reaction ~ Days + (Days | Subject))
#' }
#'
#' @export
lmer <- function(x, ...) UseMethod("lmer")

#' @rdname pipe_lme4
#' @method lmer default
#' @export
lmer.default <- function(x, ...) {
  if (!requireNamespace("lme4", quietly = TRUE))
    stop("Package 'lme4' is required but not installed.")
  lme4::lmer(x, ...)
}

#' @rdname pipe_lme4
#' @param formula A mixed-effects model formula, passed to [lme4::lmer()].
#' @method lmer data.frame
#' @export
lmer.data.frame <- function(x, formula, ...) {
  if (!requireNamespace("lme4", quietly = TRUE))
    stop("Package 'lme4' is required but not installed.")
  if (!inherits(formula, "formula"))
    stop("'formula' must be a formula object")
  lme4::lmer(formula, data = x, ...)
}


# glmer --------------------------------------------------------------------

#' @rdname pipe_lme4
#'
#' @return For `glmer`: an object of class `"glmerMod"`, as returned by
#'   [lme4::glmer()].
#'
#' @examples
#' if (requireNamespace("lme4", quietly = TRUE)) {
#'   lme4::cbpp |>
#'     glmer(cbind(incidence, size - incidence) ~ period + (1 | herd),
#'           family = binomial)
#' }
#'
#' @export
glmer <- function(x, ...) UseMethod("glmer")

#' @rdname pipe_lme4
#' @method glmer default
#' @export
glmer.default <- function(x, ...) {
  if (!requireNamespace("lme4", quietly = TRUE))
    stop("Package 'lme4' is required but not installed.")
  lme4::glmer(x, ...)
}

#' @rdname pipe_lme4
#' @param formula A mixed-effects model formula, passed to [lme4::glmer()].
#' @method glmer data.frame
#' @export
glmer.data.frame <- function(x, formula, ...) {
  if (!requireNamespace("lme4", quietly = TRUE))
    stop("Package 'lme4' is required but not installed.")
  if (!inherits(formula, "formula"))
    stop("'formula' must be a formula object")
  lme4::glmer(formula, data = x, ...)
}
