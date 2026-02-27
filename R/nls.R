#' Pipe-friendly wrapper for nls
#'
#' Wraps [stats::nls()] as a proper S3 generic, adding a `data.frame` method
#' so that a data frame can be passed as the first argument via the base pipe
#' (`|>`).
#'
#' @param x For the `data.frame` method: a data frame to use as the `data`
#'   argument. For the `default` method: passed straight through to
#'   [stats::nls()].
#' @param ... Additional arguments passed to [stats::nls()].
#'
#' @name pipe_nls
NULL

#' @rdname pipe_nls
#'
#' @return An object of class `"nls"`, as returned by [stats::nls()].
#'
#' @examples
#' # Without pipedreams:
#' # Puromycin |> subset(state == "treated") |>
#' #   nls(rate ~ Vm * conc / (K + conc), data = _,
#' #       start = list(Vm = 200, K = 0.05))
#'
#' # With pipedreams:
#' Puromycin |>
#'   subset(state == "treated") |>
#'   nls(rate ~ Vm * conc / (K + conc), start = list(Vm = 200, K = 0.05))
#'
#' @export
nls <- function(x, ...) UseMethod("nls")

#' @rdname pipe_nls
#' @method nls default
#' @export
nls.default <- function(x, ...) stats::nls(x, ...)

#' @rdname pipe_nls
#' @param formula A nonlinear model formula, passed to [stats::nls()].
#' @method nls data.frame
#' @export
nls.data.frame <- function(x, formula, ...) {
  if (!inherits(formula, "formula"))
    stop("'formula' must be a formula object")
  stats::nls(formula, data = x, ...)
}
