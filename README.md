# pipedreams

Pipe-friendly wrappers for common R statistical tests and models.

## The problem

When using the base pipe (`|>`), functions like `t.test`, `lm`, and friends
require the awkward `data = _` placeholder because they expect a formula as
their first argument, not a data frame:

```r
mtcars |> t.test(mpg ~ am, data = _)
mtcars |> lm(mpg ~ wt + cyl, data = _)
```

## The solution

`pipedreams` adds `data.frame` S3 methods so the data frame piped in becomes
the `data` argument automatically:

```r
library(pipedreams)

# base stats
mtcars |> t.test(mpg ~ am)
mtcars |> wilcox.test(mpg ~ am)
mtcars |> lm(mpg ~ wt + cyl)
mtcars |> glm(am ~ mpg + wt, family = binomial)
npk    |> aov(yield ~ block + N * P * K)
Puromycin |>
  subset(state == "treated") |>
  nls(rate ~ Vm * conc / (K + conc), start = list(Vm = 200, K = 0.05))

# survival
survival::lung |> survfit(Surv(time, status) ~ sex)
survival::lung |> coxph(Surv(time, status) ~ age + sex)
survival::lung |> survreg(Surv(time, status) ~ age + sex, dist = "weibull")

# lme4
lme4::sleepstudy |> lmer(Reaction ~ Days + (Days | Subject))
lme4::cbpp |> glmer(cbind(incidence, size - incidence) ~ period + (1 | herd),
              family = binomial)

# MASS
MASS::quine   |> glm_nb(Days ~ Sex + Age + Eth)
MASS::housing |> polr(Sat ~ Infl + Type + Cont)
mtcars |> rlm(mpg ~ wt + cyl)
iris    |> lda(Species ~ .)
iris    |> qda(Species ~ .)

# Naturally chains with data manipulation:
mtcars |>
  subset(cyl != 6) |>
  lm(mpg ~ wt + hp)
```

## How it works

For `t.test` and `wilcox.test`, which are already S3 generics in `stats`, the
package registers `data.frame` methods that reorder the arguments.

For `lm`, `glm`, `aov`, and `nls`, which are *not* S3 generics in `stats`, the
package masks them with new generics. The `.default` methods call through to the
original `stats::` functions, so all existing code continues to work.

For functions from `survival`, `lme4`, and `MASS`, the same generic-promotion
pattern is used, with a `requireNamespace()` check in each method so the
package itself does not hard-depend on these optional packages.

## Installation

```r
# install.packages("pak")
pak::pkg_install("mthulin/pipedreams")
```
