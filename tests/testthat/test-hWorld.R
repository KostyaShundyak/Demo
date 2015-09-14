context("HelloWorld")

test_that("Return right string",{
  h <- hWorld()
  expect_that(h, is_a("character"))
  expect_identical(h, 'Hello World!')
})