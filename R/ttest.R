#' Pipe-friendly data.frame methods for t.test and wilcox.test
#'
#' S3 `data.frame` methods for [stats::t.test()] and [stats::wilcox.test()]
#' that allow a data frame to be passed as the first argument via the base pipe
#' (`|>`), avoiding the need for the `data = _` placeholder syntax.
#'
#' @param x A data frame.
#' @param formula A formula of the form `lhs ~ rhs`.
#' @param ... Additional arguments passed to the underlying stats function.
#'
#' @name pipe_tests
NULL

#' @rdname pipe_tests
#'
#' @return For `t.test`: an object of class `"htest"`, as returned by
#'   [stats::t.test()].
#'
#' @examples
#' # Without pipedreams:
#' # mtcars |> t.test(mpg ~ am, data = _)
#'
#' # With pipedreams:
#' mtcars |> t.test(mpg ~ am)
#'
#' @method t.test data.frame
#' @export
t.test.data.frame <- function(x, formula, ...) {
  if (!inherits(formula, "formula"))
    stop("'formula' must be a formula object")
  stats::t.test(formula, data = x, ...)
}

#' @rdname pipe_tests
#'
#' @return For `wilcox.test`: an object of class `"htest"`, as returned by
#'   [stats::wilcox.test()].
#'
#' @examples
#' mtcars |> wilcox.test(mpg ~ am)
#'
#' @method wilcox.test data.frame
#' @export
wilcox.test.data.frame <- function(x, formula, ...) {
  if (!inherits(formula, "formula"))
    stop("'formula' must be a formula object")
  stats::wilcox.test(formula, data = x, ...)
}
