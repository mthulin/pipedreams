#' Pipe-friendly wrappers for MASS modelling functions
#'
#' These functions wrap [MASS::glm.nb()], [MASS::polr()], [MASS::lda()], and
#' [MASS::qda()] as proper S3 generics, adding `data.frame` methods so that a
#' data frame can be passed as the first argument via the base pipe (`|>`).
#'
#' These functions require the `MASS` package to be installed.
#'
#' @param x For `data.frame` methods: a data frame to use as the `data`
#'   argument. For `default` methods: passed straight through to the
#'   corresponding `MASS::` function.
#' @param ... Additional arguments passed to the underlying function.
#'
#' @name pipe_MASS
NULL


# glm_nb / glm.nb ----------------------------------------------------------
# MASS::glm.nb has a dot in its name. Exporting a dotted-name S3 generic
# triggers an unavoidable NOTE from R's static S3 checker because it cannot
# distinguish "method for generic glm, class nb" from "generic glm.nb".
# The solution is to export the generic under the unambiguous name glm_nb.

#' @rdname pipe_MASS
#'
#' @return For `glm_nb` / `glm.nb`: an object of class
#'   `c("negbin", "glm", "lm")`, as returned by [MASS::glm.nb()].
#'
#' @examples
#' if (requireNamespace("MASS", quietly = TRUE)) {
#'   MASS::quine |> glm_nb(Days ~ Sex + Age + Eth)
#' }
#'
#' @export
glm_nb <- function(x, ...) UseMethod("glm_nb")

#' @rdname pipe_MASS
#' @method glm_nb default
#' @export
glm_nb.default <- function(x, ...) {
  if (!requireNamespace("MASS", quietly = TRUE))
    stop("Package 'MASS' is required but not installed.")
  MASS::glm.nb(x, ...)
}

#' @rdname pipe_MASS
#' @param formula A formula, passed to [MASS::glm.nb()].
#' @method glm_nb data.frame
#' @export
glm_nb.data.frame <- function(x, formula, ...) {
  if (!requireNamespace("MASS", quietly = TRUE))
    stop("Package 'MASS' is required but not installed.")
  if (!inherits(formula, "formula"))
    stop("'formula' must be a formula object")
  MASS::glm.nb(formula, data = x, ...)
}




# polr ---------------------------------------------------------------------

#' @rdname pipe_MASS
#'
#' @return For `polr`: an object of class `"polr"`, as returned by
#'   [MASS::polr()].
#'
#' @examples
#' if (requireNamespace("MASS", quietly = TRUE)) {
#'   MASS::housing |> polr(Sat ~ Infl + Type + Cont)
#' }
#'
#' @export
polr <- function(x, ...) UseMethod("polr")

#' @rdname pipe_MASS
#' @method polr default
#' @export
polr.default <- function(x, ...) {
  if (!requireNamespace("MASS", quietly = TRUE))
    stop("Package 'MASS' is required but not installed.")
  MASS::polr(x, ...)
}

#' @rdname pipe_MASS
#' @param formula A formula, passed to [MASS::polr()].
#' @method polr data.frame
#' @export
polr.data.frame <- function(x, formula, ...) {
  if (!requireNamespace("MASS", quietly = TRUE))
    stop("Package 'MASS' is required but not installed.")
  if (!inherits(formula, "formula"))
    stop("'formula' must be a formula object")
  MASS::polr(formula, data = x, ...)
}


# lda ----------------------------------------------------------------------

#' @rdname pipe_MASS
#'
#' @return For `lda`: an object of class `"lda"`, as returned by [MASS::lda()].
#'
#' @examples
#' if (requireNamespace("MASS", quietly = TRUE)) {
#'   iris |> lda(Species ~ .)
#' }
#'
#' @export
lda <- function(x, ...) UseMethod("lda")

#' @rdname pipe_MASS
#' @method lda default
#' @export
lda.default <- function(x, ...) {
  if (!requireNamespace("MASS", quietly = TRUE))
    stop("Package 'MASS' is required but not installed.")
  MASS::lda(x, ...)
}

#' @rdname pipe_MASS
#' @param formula A formula, passed to [MASS::lda()].
#' @method lda data.frame
#' @export
lda.data.frame <- function(x, formula, ...) {
  if (!requireNamespace("MASS", quietly = TRUE))
    stop("Package 'MASS' is required but not installed.")
  if (!inherits(formula, "formula"))
    stop("'formula' must be a formula object")
  MASS::lda(formula, data = x, ...)
}


# qda ----------------------------------------------------------------------

#' @rdname pipe_MASS
#'
#' @return For `qda`: an object of class `"qda"`, as returned by [MASS::qda()].
#'
#' @examples
#' if (requireNamespace("MASS", quietly = TRUE)) {
#'   iris |> qda(Species ~ .)
#' }
#'
#' @export
qda <- function(x, ...) UseMethod("qda")

#' @rdname pipe_MASS
#' @method qda default
#' @export
qda.default <- function(x, ...) {
  if (!requireNamespace("MASS", quietly = TRUE))
    stop("Package 'MASS' is required but not installed.")
  MASS::qda(x, ...)
}

#' @rdname pipe_MASS
#' @param formula A formula, passed to [MASS::qda()].
#' @method qda data.frame
#' @export
qda.data.frame <- function(x, formula, ...) {
  if (!requireNamespace("MASS", quietly = TRUE))
    stop("Package 'MASS' is required but not installed.")
  if (!inherits(formula, "formula"))
    stop("'formula' must be a formula object")
  MASS::qda(formula, data = x, ...)
}


# rlm ----------------------------------------------------------------------

#' @rdname pipe_MASS
#'
#' @return For `rlm`: an object of class `"rlm"`, as returned by [MASS::rlm()].
#'
#' @examples
#' if (requireNamespace("MASS", quietly = TRUE)) {
#'   mtcars |> rlm(mpg ~ wt)
#' }
#'
#' @export
rlm <- function(x, ...) UseMethod("rlm")

#' @rdname pipe_MASS
#' @method rlm default
#' @export
rlm.default <- function(x, ...) {
    if (!requireNamespace("MASS", quietly = TRUE))
        stop("Package 'MASS' is required but not installed.")
    MASS::rlm(x, ...)
}

#' @rdname pipe_MASS
#' @param formula A formula, passed to [MASS::rlm()].
#' @method rlm data.frame
#' @export
rlm.data.frame <- function(x, formula, ...) {
    if (!requireNamespace("MASS", quietly = TRUE))
        stop("Package 'MASS' is required but not installed.")
    if (!inherits(formula, "formula"))
        stop("'formula' must be a formula object")
    MASS::rlm(formula, data = x, ...)
}
